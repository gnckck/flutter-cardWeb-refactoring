import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState()) {
    on<CreateList>((event, emit) {
      emit(
        state.copyWith(
          cardNumbers: [...state.cardNumbers, Random().nextInt(50)],
        ),
      );
    });
  }
}
