import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/utils/constant/api_constant.dart';

class WalletRepository {
  Future<Response> wallet(BuildContext context) async {
    Response response = await api.getDynamicData(context, AppApi.wallet);

    return response;
  }
}
