import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/utils/constant/api_constant.dart';

class MoneyRepository {
  Future<Response> qrCode(BuildContext context) async {
    Response response = await api.getDynamicData(context, AppApi.qrCode);

    return response;
  }

  Future<Response> manageWallet(
    BuildContext context,
    Map<String, dynamic> body,
  ) async {
    Response response = await api.postDynamicFormData(
      context,
      AppApi.manageWallet,
      body,
    );

    return response;
  }
}
