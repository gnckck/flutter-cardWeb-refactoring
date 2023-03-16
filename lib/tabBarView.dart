import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/card_bloc.dart';

class CardView extends StatelessWidget {
  final List<CheckState> checkedList;
  const CardView({super.key, required this.checkedList});

  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CardBloc>(context);
    return Scaffold(body: BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        return ListView.builder(
            itemCount: checkedList.length,
            itemBuilder: ((context, index) {
              final cardModel = checkedList[index];
              return CheckboxListTile(
                value: cardModel.isChecked,
                onChanged: (newValue) {
                  cardBloc.add(IsChecked(newValue!, cardModel.cardId));
                },
                title: Text(
                  cardModel.cardName,
                ),
                secondary: GestureDetector(
                  child: const Icon(
                    Icons.delete,
                  ),
                  onTap: () => cardBloc.add(RemoveCard(cardModel.cardId)),
                ),
              );
            }));
      },
    ));
  }
}
