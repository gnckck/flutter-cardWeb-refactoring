import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/card_bloc.dart';

class Search extends StatelessWidget {
  final TextEditingController searchCardController;

  const Search({
    super.key,
    required this.searchCardController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 80, top: 10),
      child: SizedBox(
        width: 500,
        height: 40,
        child: TextField(
          onChanged: ((value) {
            context.read<CardBloc>().add(SearchCard(value));
          }),
          controller: searchCardController,
          decoration: const InputDecoration(
            labelText: '텍스트를 입력해주세요',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
