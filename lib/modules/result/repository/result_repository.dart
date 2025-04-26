import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/utils/constant/api_constant.dart';

class ResultRepository {
  Future<Response> result(BuildContext context, {required String page}) async {
    Response response = await api.getDynamicData(
      context,
      '${AppApi.result}$page',
    );

    return response;
  }
}
