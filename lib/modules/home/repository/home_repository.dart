import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/utils/constant/api_constant.dart';

class HomeRepository {
  Future<Response> homeGameRepository(BuildContext context) async {
    Response response = await api.getDynamicData(context, AppApi.games);

    return response;
  }

  Future<Response> gamesSlotsRepository(
    BuildContext context, {
    required int gameId,
  }) async {
    Response response = await api.getDynamicData(
      context,
      '$baseUrl/game/$gameId/slots',
    );

    return response;
  }

  Future<Response> homeBanners(BuildContext context) async {
    Response response = await api.getDynamicData(context, AppApi.homeBanners);

    return response;
  }
}
