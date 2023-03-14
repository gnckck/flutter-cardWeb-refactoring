import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_refactoring/bloc/card_bloc.dart';

import 'cardList.dart';

void main() {
  runApp(const CardApp());
}

class CardApp extends StatelessWidget {
  const CardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardBloc>(
      create: (_) => CardBloc(),
      child: MaterialApp(
        title: 'cardList',
        home: DefaultTabController(length: 3, child: CardList()),
      ),
    );
  }
}
