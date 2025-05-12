import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/utils/constant/api_constant.dart';

class DataEntryRepository {
  Future<Response> totalGetEntry(BuildContext context) async {
    Response response = await api.getDynamicData(
      context,
      '$baseUrl/total-gate-entry',
    );

    return response;
  }

  Future<Response> getExtraEntry(BuildContext context) async {
    Response response = await api.postDynamicData(
      context,
      '$baseUrl/gate-entry-extra',
      {},
    );

    return response;
  }

  Future<Response> getEntry(
    BuildContext context, {
    required String sNumber,
  }) async {
    Response response = await api.postDynamicData(
      context,
      '$baseUrl/gate-entry',
      {"s_number": sNumber},
    );

    return response;
  }
}
