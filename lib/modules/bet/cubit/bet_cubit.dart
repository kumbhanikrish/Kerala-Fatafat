import 'dart:developer';

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
      log('skjdfgosgdu ::${response.data['message']}');
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

class TapCubit extends Cubit<List<int>> {
  TapCubit() : super([]);

  void addTappedNumber(BuildContext context, {required int number}) {
    List<String> validNumbers = [
      '100',
      '200',
      '300',
      '400',
      '500',
      '600',
      '700',
      '800',
      '900',
      '000',
      '678',
      '345',
      '120',
      '789',
      '456',
      '123',
      '890',
      '567',
      '234',
      '127',
      '777',
      '444',
      '111',
      '888',
      '555',
      '222',
      '999',
      '666',
      '333',
      '190',
      '560',
      '570',
      '580',
      '590',
      '140',
      '150',
      '160',
      '170',
      '180',
      '280',
      '470',
      '480',
      '490',
      '130',
      '230',
      '330',
      '340',
      '350',
      '360',
      '370',
      '380',
      '390',
      '670',
      '680',
      '690',
      '240',
      '250',
      '260',
      '270',
      '460',
      '290',
      '660',
      '238',
      '248',
      '258',
      '268',
      '278',
      '288',
      '450',
      '550',
      '119',
      '129',
      '139',
      '149',
      '159',
      '169',
      '179',
      '189',
      '199',
      '235',
      '137',
      '237',
      '337',
      '347',
      '357',
      '367',
      '377',
      '116',
      '117',
      '118',
      '236',
      '336',
      '157',
      '158',
      '799',
      '448',
      '467',
      '233',
      '469',
      '578',
      '146',
      '246',
      '346',
      '446',
      '267',
      '899',
      '115',
      '459',
      '126',
      '145',
      '669',
      '679',
      '689',
      '699',
      '780',
      '178',
      '124',
      '125',
      '667',
      '479',
      '579',
      '255',
      '355',
      '455',
      '447',
      '790',
      '223',
      '224',
      '478',
      '668',
      '399',
      '147',
      '247',
      '266',
      '366',
      '466',
      '566',
      '477',
      '135',
      '299',
      '588',
      '228',
      '256',
      '112',
      '113',
      '358',
      '557',
      '990',
      '225',
      '334',
      '489',
      '499',
      '166',
      '356',
      '122',
      '880',
      '368',
      '134',
      '144',
      '488',
      '245',
      '688',
      '599',
      '239',
      '177',
      '114',
      '359',
      '558',
      '379',
      '389',
      '155',
      '778',
      '148',
      '338',
      '249',
      '556',
      '449',
      '369',
      '559',
      '226',
      '227',
      '138',
      '788',
      '257',
      '339',
      '259',
      '269',
      '378',
      '289',
      '569',
      '344',
      '156',
      '445',
      '220',
      '889',
      '349',
      '133',
      '440',
      '388',
      '677',
      '335',
      '110',
      '229',
      '770',
      '348',
      '457',
      '188',
      '279',
      '577',
      '136',
      '128',
      '589',
      '779',
      '167',
      '168',
      '277',
      '458',
      '468',
      '568',
      '244',
    ];

    final updatedList = List<int>.from(state);
    updatedList.add(number);
    String result = updatedList.join('');
    log('updatedList.length == 3 :: $result');

    if (result.length == 3) {
      if (validNumbers.contains(result)) {
        emit(updatedList);
      } else {
        updatedList.clear();
        customToast(
          context,
          text: 'Only valid numbers allowed. "$result" is not in the list.',
          animatedSnackBarType: AnimatedSnackBarType.error,
        );
        emit(updatedList);
      }
    } else {
      emit(updatedList);
    }
  }

  void clearTappedNumbers() {
    emit([]);
  }
}
