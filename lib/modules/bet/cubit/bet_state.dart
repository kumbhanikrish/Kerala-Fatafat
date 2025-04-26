part of 'bet_cubit.dart';

@immutable
sealed class BetState {}

final class BetInitial extends BetState {}

final class BetLoaded extends BetState {
  final List<AddBetModel> addBetList;

  BetLoaded({required this.addBetList});
}

sealed class ChangeBorderState {}

final class ChangeBorderInitial extends ChangeBorderState {}

final class ChangeBorderLoaded extends ChangeBorderState {
  final int changeNumber;

  ChangeBorderLoaded({required this.changeNumber});
}
