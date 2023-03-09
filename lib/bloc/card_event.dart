part of 'card_bloc.dart';

@immutable
abstract class CardEvent {}

class CreateCard extends CardEvent {}

class RemoveCard extends CardEvent {
  final int currentList;
  RemoveCard(this.currentList);
}

class IncreaseNumber extends CardEvent {
  final int currentNumber;
  IncreaseNumber(this.currentNumber);
}

class DragCard extends CardEvent {
  final int currentIndex;
  DragCard(this.currentIndex);
}

class EndDrag extends CardEvent {}
