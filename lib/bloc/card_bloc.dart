import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState()) {
    on<CreateList>(((event, emit) {
      emit(
        state.copyWith(
            cardNumbers: List.from(state.cardNumbers)
              ..add(Random().nextInt(50))),
      );
    }));

    on<RemoveList>(
      ((event, emit) {
        emit(state.copyWith(
            cardNumbers: List.from(state.cardNumbers)
              ..removeAt(event.currentList)));
      }),
    );

    on<IncreaseNumber>(((event, emit) {
      emit(
          state.copyWith(cardNumber: state.cardNumbers[event.currentNumber]++));
    }));
  }
}
