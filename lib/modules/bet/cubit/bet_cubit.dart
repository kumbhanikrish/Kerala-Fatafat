import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kolkata_fatafat/modules/bet/model/add_bet_model.dart';
import 'package:kolkata_fatafat/modules/bet/repository/bet_repository.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';

part 'bet_state.dart';

class BetCubit extends Cubit<BetState> {
  BetCubit() : super(BetInitial());
  BetRepository betRepository = BetRepository();

  Future<Response> addBet(
    BuildContext context, {
    required int gameId,
    required Map<String, dynamic> body,
  }) async {
    final Response response = await betRepository.betRepository(
      context,
      gameId: gameId,
      body: body,
    );
    if (response.statusCode == 200) {
      Navigator.pushNamed(
        context,
        AppRoutes.bidHistoryScreen,

        // (route) => false,
      );
      customToast(
        context,
        text: response.data['message'],

        animatedSnackBarType: AnimatedSnackBarType.success,
      );
      emit(BetLoaded(addBetList: []));
    } else {
      customToast(
        context,
        text: response.data['message'],

        animatedSnackBarType: AnimatedSnackBarType.error,
      );
    }

    return response;
  }

  addBetSection(
    BuildContext context, {
    required int numberOfBet,
    required String betAmount,
  }) {
    List<AddBetModel> addBetList = [];

    if (state is BetLoaded) {
      addBetList = (state as BetLoaded).addBetList;
    }

    if (numberOfBet == -1) {
      customToast(
        context,
        text: 'Please select bet number',
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
    } else if (betAmount.isEmpty) {
      customToast(
        context,
        text: 'Please select bet amount',
        animatedSnackBarType: AnimatedSnackBarType.error,
      );
    } else {
      addBetList.add(
        AddBetModel(betAmount: int.parse(betAmount), numberOfBet: numberOfBet),
      );

      emit(BetLoaded(addBetList: List.from(addBetList)));
    }
  }

  removeBetSection(BuildContext context, {required int numberOfBet}) {
    List<AddBetModel> addBetList = [];

    if (state is BetLoaded) {
      addBetList = (state as BetLoaded).addBetList;
    }

    addBetList.removeWhere((element) => element.numberOfBet == numberOfBet);

    emit(BetLoaded(addBetList: addBetList));
  }

  init() {
    emit(BetInitial());
  }
}

class ChangeBorderCubit extends Cubit<ChangeBorderState> {
  ChangeBorderCubit() : super(ChangeBorderInitial());

  changeBorderValue({required int changeNumber}) {
    emit(ChangeBorderLoaded(changeNumber: changeNumber));
  }

  init() {
    emit(ChangeBorderInitial());
  }
}
