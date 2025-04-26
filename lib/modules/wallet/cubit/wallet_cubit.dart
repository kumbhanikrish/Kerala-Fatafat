import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/modules/wallet/model/wallet_model.dart';
import 'package:kolkata_fatafat/modules/wallet/repository/wallet_repository.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  WalletRepository walletRepository = WalletRepository();
  Future<Response> wallet(BuildContext context) async {
    WalletModel walletModel = WalletModel(walletBalance: 0, transactions: []);
    final Response response = await walletRepository.wallet(context);
    if (response.statusCode == 200) {
      walletModel = WalletModel.fromJson(response.data);
      emit(WalletLoaded(walletModel: walletModel));
    }
    return response;
  }
}
