part of 'game_slot_cubit.dart';

@immutable
sealed class GameSlotState {}

final class GameSlotInitial extends GameSlotState {}

final class GamesSlotsLoaded extends GameSlotState {
  final GamesSlotsModel gamesSlotsModel;

  GamesSlotsLoaded({required this.gamesSlotsModel});
}
