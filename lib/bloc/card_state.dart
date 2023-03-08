part of 'card_bloc.dart';

class CardState {
  final List<int> cardNumbers;
  final int cardNumber;

  CardState({
    cardNumbers,
    this.cardNumber = 0,
  }) : cardNumbers = cardNumbers ?? [];

  CardState copyWith({
    List<int>? cardNumbers,
    int? cardNumber,
  }) =>
      CardState(
        cardNumbers: cardNumbers ?? this.cardNumbers,
        cardNumber: cardNumber ?? this.cardNumber,
      );
}
