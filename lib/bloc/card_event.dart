part of 'card_bloc.dart';

@immutable
abstract class CardEvent {}

class RemoveCard extends CardEvent {
  final int currentList;
  RemoveCard(this.currentList);
}

class DragCard extends CardEvent {
  final int currentIndex;
  DragCard(this.currentIndex);
}

class EndDrag extends CardEvent {}

class SendText extends CardEvent {
  final String enteredText;
  SendText(this.enteredText);
}

class IsChecked extends CardEvent {
  final int index;

  IsChecked(this.index);
}
