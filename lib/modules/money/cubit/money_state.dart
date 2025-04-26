part of 'money_cubit.dart';

@immutable
sealed class MoneyState {}

final class MoneyInitial extends MoneyState {}

final class QrCodeLoaded extends MoneyState {
  final String qrCode;

  QrCodeLoaded({required this.qrCode});
}
