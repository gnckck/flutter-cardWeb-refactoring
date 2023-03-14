part of 'card_bloc.dart';

class CardState {
  final List<String> cardNames;
  List<bool> cardStates;

  CardState({
    cardNames,
    cardStates,
  })  : cardNames = cardNames ?? [],
        cardStates = cardStates ?? [];

  CardState copyWith({
    List<String>? cardNames,
    List<bool>? cardStates,
  }) =>
      CardState(
        cardNames: cardNames ?? this.cardNames,
        cardStates: cardStates ?? this.cardStates,
      );
}
