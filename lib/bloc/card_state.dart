part of 'card_bloc.dart';

class CheckState {
  String cardName;
  bool isChecked;
  String cardId;

  CheckState(this.cardName, this.cardId, {this.isChecked = false});
}

class CardState {
  List<CheckState> sample;

  List<CheckState> searchList;

  CardState({
    sample,
    searchList,
  })  : sample = sample ?? [],
        searchList = searchList ?? [...?sample];

  CardState copyWith({
    List<CheckState>? sample,
  }) =>
      CardState(
        sample: sample ?? this.sample,
      );

  CardState copyWithSample({
    List<CheckState>? searchList,
  }) =>
      CardState(
        sample: sample,
        searchList: searchList ?? sample,
      );
}
