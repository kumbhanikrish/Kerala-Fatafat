part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ChatLoaded extends ProfileState {
  final List<ChatModel> chatList;

  ChatLoaded({required this.chatList});
}

final class BidHistoryLoaded extends ProfileState {
  final List<BidHistoryModel> bidHistoryList;

  BidHistoryLoaded({required this.bidHistoryList});
}
