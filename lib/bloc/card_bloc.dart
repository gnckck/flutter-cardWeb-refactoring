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
          cardNames: List.from(state.cardNames)..removeAt(event.currentList),
        ),
      ),
    );

    on<DragCard>(
      (event, emit) {
        beforeIndex ??= event.currentIndex;
        if (beforeIndex != event.currentIndex) {
          String temp = state.cardNames[beforeIndex!];
          state.cardNames.removeAt(beforeIndex!);
          state.cardNames.insert(event.currentIndex, temp);
          beforeIndex = event.currentIndex;
          emit(state.copyWith(cardNames: state.cardNames));
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
            cardNames: List.from(state.cardNames)..add(event.enteredText),
            cardStates: List.from(state.cardStates)..add(false)),
      ),
    );

    on<IsChecked>((event, emit) {
      emit(
        state.copyWith(
          cardStates: List.from(state.cardStates)
              .mapIndexed<bool>((index, e) => index == event.index ? !e : e)
              .toList(),
        ),
      );
    });
  }
}
