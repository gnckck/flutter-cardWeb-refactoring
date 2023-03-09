import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  int? beforeIndex;

  CardBloc() : super(CardState()) {
    on<CreateCard>(
      (event, emit) => emit(
        state.copyWith(
            cardNumbers: List.from(state.cardNumbers)
              ..add(Random().nextInt(50))),
      ),
    );

    on<RemoveCard>(
      (event, emit) => emit(
        state.copyWith(
          cardNumbers: List.from(state.cardNumbers)
            ..removeAt(event.currentList),
        ),
      ),
    );

    on<IncreaseNumber>(
      ((event, emit) {
        List<int> nextCards = List<int>.from(state.cardNumbers);
        nextCards[event.currentNumber]++;
        emit(state.copyWith(cardNumbers: nextCards));
      }),
    );

    on<DragCard>(
      (event, emit) {
        beforeIndex ??= event.currentIndex;
        if (beforeIndex != event.currentIndex) {
          int temp = state.cardNumbers[beforeIndex!];
          state.cardNumbers.removeAt(beforeIndex!);
          state.cardNumbers.insert(event.currentIndex, temp);
          beforeIndex = event.currentIndex;
          emit(state.copyWith(cardNumbers: state.cardNumbers));
        }
      },
    );

    on<EndDrag>((event, emit) {
      beforeIndex = null;
      emit(state);
    });
  }
}
