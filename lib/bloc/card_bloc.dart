import 'dart:html';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ex_refactoring/cardList.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  int? beforeIndex;

  CardBloc() : super(CardState()) {
    on<RemoveCard>((event, emit) {
      emit(
        state.copyWith(
            sample: state.sample
              ..removeWhere((element) => event.id == element.cardId)),
      );
    });

    on<DragCard>(
      (event, emit) {
        beforeIndex ??= event.currentIndex;
        if (beforeIndex != event.currentIndex) {
          CheckState temp = state.sample[beforeIndex!];

          state.sample.removeAt(beforeIndex!);
          state.sample.insert(event.currentIndex, temp);

          beforeIndex = event.currentIndex;
          emit(state.copyWith(sample: state.sample));
        }
      },
    );

    on<EndDrag>(
      (event, emit) {
        beforeIndex = null;
        emit(state);
      },
    );

    on<SendText>(
      (event, emit) {
        final String id = DateTime.now().toString();
        emit(state.copyWith(
          sample: List.from(state.sample)
            ..add(CheckState(event.enteredText, id)),
        ));
      },
    );

    on<IsChecked>(
      (event, emit) {
        int targetIndex =
            state.sample.indexWhere((element) => event.id == element.cardId);
        state.sample[targetIndex].isChecked = event.value;

        emit(state.copyWith(sample: state.sample));
      },
    );

    on<ChangeName>(
      (event, emit) {
        int targetIndex =
            state.sample.indexWhere((element) => event.id == element.cardId);
        state.sample[targetIndex].cardName = event.newCardName;
        emit(state.copyWith(sample: state.sample));
      },
    );
  }
}
