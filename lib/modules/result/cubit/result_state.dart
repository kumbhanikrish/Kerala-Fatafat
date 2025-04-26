part of 'result_cubit.dart';

@immutable
sealed class ResultState {}

final class ResultInitial extends ResultState {}

final class ResultLoaded extends ResultState {
  final List<ResultModel> resultList;

  ResultLoaded({required this.resultList});
}

final class ResultLoading extends ResultState {}
