part of 'card_bloc.dart';

@immutable
abstract class CardEvent {}

class RemoveCard extends CardEvent {
  final String id;
  RemoveCard(this.id);
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
  final String id;
  final bool value;

  IsChecked(this.value, this.id);
}
