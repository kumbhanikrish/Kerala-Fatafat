import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/utils/constant/api_constant.dart';

class ProfileRepository {
  Future<Response> profile(
    BuildContext context, {

    required Map<String, dynamic> body,
  }) async {
    Response response = await api.postDynamicFormData(
      context,
      AppApi.profile,
      body,
    );

    return response;
  }

  Future<Response> sendMessage(
    BuildContext context, {
    required String message,
  }) async {
    Response response = await api.postDynamicData(
      context,
      '${AppApi.sendMessage}$message',
      {},
    );

    return response;
  }

  Future<Response> chat(BuildContext context) async {
    Response response = await api.getDynamicData(context, AppApi.chat);

    return response;
  }

  Future<Response> userBid(BuildContext context) async {
    Response response = await api.getDynamicData(context, AppApi.userBid);

    return response;
  }
}
