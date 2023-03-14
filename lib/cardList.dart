import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_refactoring/bloc/card_bloc.dart';

class CardList extends StatelessWidget {
  final TextEditingController cardTextEditingController =
      TextEditingController();
  CardList({super.key});

  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CardBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random Card',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  '생성할 카드이름을 입력해주쇼',
                  style: TextStyle(fontSize: 18),
                ),
                content: TextField(
                  controller: cardTextEditingController,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      cardBloc.add(SendText(cardTextEditingController.text));
                      Navigator.pop(context);
                      cardTextEditingController.clear();
                    },
                    child: const Text('확인'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, '취소'),
                    child: const Text('취소'),
                  ),
                ],
              ),
            ),
            child: const Icon(Icons.add),
          ),
          Expanded(
            child: BlocBuilder<CardBloc, CardState>(
              builder: (context, state) {
                return DragTarget(
                  builder: (context, candidateData, rejectedData) {
                    return ListView.builder(
                      itemCount: state.cardNames.length,
                      itemBuilder: (context, index) {
                        final deviceWidth = MediaQuery.of(context).size.width;
                        final Widget showCard = SizedBox(
                          width: deviceWidth,
                          child: Card(
                            child: ListTile(
                              title: Text(
                                state.cardNames[index].toString(),
                              ),
                              trailing: GestureDetector(
                                child: const Icon(
                                  Icons.delete,
                                ),
                                onTap: () => cardBloc.add(RemoveCard(index)),
                              ),
                            ),
                          ),
                        );
                        return Draggable(
                          feedback: showCard,
                          data: index,
                          child: DragTarget(
                            builder: ((context, candidateData, rejectedData) {
                              return showCard;
                            }),
                            onMove: (details) => cardBloc.add(DragCard(index)),
                            onAccept: (data) => cardBloc.add(EndDrag()),
                          ),
                        );
                      },
                    );
                  },
                  onAccept: (data) => cardBloc.add(EndDrag()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



// cardBloc.add(CreateCard())