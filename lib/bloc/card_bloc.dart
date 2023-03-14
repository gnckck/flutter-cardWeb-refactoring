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
    on<RemoveCard>(
      (event, emit) => emit(
        state.copyWith(
          sample: List.from(state.sample)..removeAt(event.currentList),
        ),
      ),
    );

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
      (event, emit) => emit(
        state.copyWith(
          sample: List.from(state.sample)..add(CheckState(event.enteredText)),
        ),
      ),
    );

    on<IsChecked>((event, emit) {
      state.sample[event.index].isChecked = event.value;
      emit(state.copyWith(sample: state.sample));
    });
  }
}
