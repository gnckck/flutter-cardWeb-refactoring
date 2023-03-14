part of 'card_bloc.dart';

class CardState {
  final List<String> cardNames;

  CardState({
    cardNames,
  }) : cardNames = cardNames ?? [];

  CardState copyWith({
    List<String>? cardNames,
  }) =>
      CardState(
        cardNames: cardNames ?? this.cardNames,
      );
}
