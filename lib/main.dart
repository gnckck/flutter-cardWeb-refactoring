import 'package:flutter/material.dart';

import 'cardList.dart';

void main() {
  runApp(const CardApp());
}

class CardApp extends StatelessWidget {
  const CardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'cardList',
      home: CardList(),
    );
  }
}
