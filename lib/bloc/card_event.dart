part of 'card_bloc.dart';

@immutable
abstract class CardEvent {}

class CreateList extends CardEvent {}

class RemoveList extends CardEvent {
  final int currentList;
  RemoveList(this.currentList);
}

class IncreaseNumber extends CardEvent {
  final int currentNumber;
  IncreaseNumber(this.currentNumber);
}
