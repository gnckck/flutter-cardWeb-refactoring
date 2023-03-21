import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_refactoring/bloc/card_bloc.dart';
import 'package:flutter_ex_refactoring/search.dart';
import 'package:flutter_ex_refactoring/tabBarView.dart';

class CardList extends StatelessWidget {
  final TextEditingController cardTextEditingController =
      TextEditingController();

  handleDialog({
    required title,
    required context,
    required Function() onPressed,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          content: TextField(
            controller: cardTextEditingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: const Text('확인'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, '취소');
                cardTextEditingController.clear();
              },
              child: const Text('취소'),
            ),
          ],
        ),
      );

  final TextEditingController searchCardController = TextEditingController();
  CardList({super.key});

  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CardBloc>(context);
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Text(
                    'Random Card',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Search(searchCardController: searchCardController),
                ],
              ),
              backgroundColor: Colors.white,
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      '전체',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '체크',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '체크없음',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () => handleDialog(
                          title: '생성할 카드이름을 입력해주쇼',
                          context: context,
                          onPressed: () {
                            context.read<CardBloc>().add(
                                  SendText(cardTextEditingController.text),
                                );
                            Navigator.pop(context);
                            cardTextEditingController.clear();
                          },
                        ),
                        child: const Icon(Icons.add),
                      ),
                      Expanded(
                        child: DragTarget(
                          builder: (context, candidateData, rejectedData) {
                            return ListView.builder(
                              itemCount: state.searchList.length,
                              itemBuilder: (context, index) {
                                final deviceWidth =
                                    MediaQuery.of(context).size.width;
                                final Widget showCard = SizedBox(
                                  width: deviceWidth,
                                  child: Card(
                                    child: CheckboxListTile(
                                      value: state.searchList[index].isChecked,
                                      onChanged: (newValue) {
                                        cardBloc.add(
                                          IsChecked(newValue!,
                                              state.searchList[index].cardId),
                                        );
                                      },
                                      title: GestureDetector(
                                        onTap: () => handleDialog(
                                          title: '바꿀 이름을 입력해주쇼',
                                          context: context,
                                          onPressed: () {
                                            context.read<CardBloc>().add(
                                                  ChangeName(
                                                    newCardName:
                                                        cardTextEditingController
                                                            .text,
                                                    id: state.searchList[index]
                                                        .cardId,
                                                  ),
                                                );

                                            Navigator.pop(context);
                                            cardTextEditingController.clear();
                                          },
                                        ),
                                        child: Text(
                                          state.searchList[index].cardName,
                                        ),
                                      ),
                                      secondary: GestureDetector(
                                        child: const Icon(
                                          Icons.delete,
                                        ),
                                        onTap: () => cardBloc.add(
                                          RemoveCard(
                                              state.searchList[index].cardId),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                return Draggable(
                                  feedback: showCard,
                                  data: index,
                                  child: DragTarget(
                                    builder: ((context, candidateData,
                                        rejectedData) {
                                      return showCard;
                                    }),
                                    onMove: (details) =>
                                        cardBloc.add(DragCard(index)),
                                    onAccept: (data) => cardBloc.add(EndDrag()),
                                  ),
                                );
                              },
                            );
                          },
                          onAccept: (data) => cardBloc.add(EndDrag()),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CardView(
                    checkedList: state.searchList
                        .where((card) => card.isChecked)
                        .toList(),
                  ),
                ),
                Center(
                  child: CardView(
                    checkedList: state.searchList
                        .where((card) => !card.isChecked)
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
