part of 'card_bloc.dart';

class CardState {
  final List<int> cardNumbers;

  CardState({
    cardNumbers,
  }) : cardNumbers = cardNumbers ?? [];

  CardState copyWith({
    List<int>? cardNumbers,
  }) =>
      CardState(
        cardNumbers: cardNumbers ?? this.cardNumbers,
      );
}
