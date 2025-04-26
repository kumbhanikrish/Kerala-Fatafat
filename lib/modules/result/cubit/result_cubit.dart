import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:kolkata_fatafat/modules/result/model/result_model.dart';
import 'package:kolkata_fatafat/modules/result/repository/result_repository.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());

  ResultRepository resultRepository = ResultRepository();
  List<ResultModel> resultList = [];
  int pageNumber = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  Future<void> result(BuildContext context, {bool isRefresh = false}) async {
    if (isLoading || !hasMoreData) return;

    if (isRefresh) {
      pageNumber = 1;
      hasMoreData = true;
      resultList.clear();
      emit(ResultLoading());
    }

    isLoading = true;

    final Response response = await resultRepository.result(
      context,
      page: pageNumber.toString(),
    );

    if (response.statusCode == 200) {
      List<ResultModel> newResults =
          (response.data['data'] as List)
              .map((e) => ResultModel.fromJson(e))
              .toList();

      if (newResults.isNotEmpty) {
        resultList.addAll(newResults);
        pageNumber++;
      } else {
        hasMoreData = false; // No more pages
      }

      emit(ResultLoaded(resultList: List.from(resultList)));
    } else {
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );
    }

    isLoading = false;
  }
}
