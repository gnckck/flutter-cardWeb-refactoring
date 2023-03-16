part of 'card_bloc.dart';

class CheckState {
  String cardName;
  bool isChecked;
  String cardId;

  CheckState(this.cardName, this.cardId, {this.isChecked = false});
}

class CardState {
  final List<CheckState> sample;

  CardState({
    sample,
  }) : sample = sample ?? [];

  CardState copyWith({
    List<CheckState>? sample,
  }) =>
      CardState(
        sample: sample,
      );
}
