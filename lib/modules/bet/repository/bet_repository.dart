import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/utils/constant/api_constant.dart';

class BetRepository {
  Future<Response> betRepository(
    BuildContext context, {
    required int gameId,
    required Map<String, dynamic> body,
  }) async {
    Response response = await api.postDynamicData(
      context,
      '$baseUrl/game/$gameId/bets',
      body,
    );

    return response;
  }

}
