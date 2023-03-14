part of 'card_bloc.dart';

class CheckState {
  String cardName;
  bool isChecked;

  CheckState(this.cardName, {this.isChecked = false});
}

class CardState {
  final List<String> cardNames;
  final List<CheckState> sample;

  CardState({
    cardNames,
    sample,
  })  : cardNames = cardNames ?? [],
        sample = sample ?? [];

  CardState copyWith({
    List<String>? cardNames,
    List<CheckState>? sample,
  }) =>
      CardState(
        sample: sample,
        cardNames: cardNames ?? this.cardNames,
      );
}
