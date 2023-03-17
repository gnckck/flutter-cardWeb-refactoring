import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Search extends StatelessWidget {
  final TextEditingController searchCardController = TextEditingController();
  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchCardController,
      decoration: const InputDecoration(
        labelText: '텍스트를 입력해주세요',
        border: OutlineInputBorder(),
      ),
    );
  }
}
