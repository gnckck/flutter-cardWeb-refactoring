part of 'card_bloc.dart';

@immutable
abstract class CardEvent {}

class CreateList extends CardEvent {}

class RemoveList extends CardEvent {
  final int currentNumber;
  RemoveList(this.currentNumber);
}

class IncreaseNumber extends CardEvent {}
