import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_refactoring/bloc/card_bloc.dart';

class CardList extends StatelessWidget {
  const CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random Card',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        FloatingActionButton(
          onPressed: () => context.read<CardBloc>().add(CreateList()),
          child: const Icon(Icons.add),
        ),
        Expanded(
          child: BlocBuilder<CardBloc, CardState>(
            builder: (context, state) {
              return ListView.builder(
                  itemCount: state.cardNumbers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          state.cardNumbers[index].toString(),
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ]),
    );
  }
}
