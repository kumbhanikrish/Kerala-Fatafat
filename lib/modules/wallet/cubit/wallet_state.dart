part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

final class WalletLoaded extends WalletState {
  final WalletModel walletModel;

  WalletLoaded({required this.walletModel});
}
