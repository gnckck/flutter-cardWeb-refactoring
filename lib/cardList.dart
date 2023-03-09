import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_refactoring/bloc/card_bloc.dart';

class CardList extends StatelessWidget {
  const CardList({super.key});

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
            onPressed: () => cardBloc.add(CreateCard()),
            child: const Icon(Icons.add),
          ),
          Expanded(
            child: BlocBuilder<CardBloc, CardState>(
              builder: (context, state) {
                return DragTarget(
                  builder: (context, candidateData, rejectedData) {
                    return ListView.builder(
                      itemCount: state.cardNumbers.length,
                      itemBuilder: (context, index) {
                        final deviceWidth = MediaQuery.of(context).size.width;
                        final Widget showCard = SizedBox(
                          width: deviceWidth,
                          child: Card(
                            child: ListTile(
                              title: Text(
                                state.cardNumbers[index].toString(),
                              ),
                              trailing: GestureDetector(
                                child: const Icon(
                                  Icons.delete,
                                ),
                                onTap: () => cardBloc.add(RemoveCard(index)),
                              ),
                              onTap: () => cardBloc.add(IncreaseNumber(index)),
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
