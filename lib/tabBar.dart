import 'package:flutter/material.dart';

class ThreeTabs extends StatelessWidget {
  final String text;
  const ThreeTabs({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(tabs: <Widget>[
      Tab(
        child: Text(
          text,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
    ]);
  }
}
