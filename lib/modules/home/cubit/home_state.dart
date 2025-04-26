part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeGamesLoaded extends HomeState {
  final List<GamesModel> gamesList;

  HomeGamesLoaded({required this.gamesList});
}

final class BannersLoaded extends HomeState {
  final List<String> bannersList;

  BannersLoaded({required this.bannersList});
}
