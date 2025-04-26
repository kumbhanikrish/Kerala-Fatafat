import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';

import 'package:kolkata_fatafat/utils/constant/api_constant.dart';

class AuthRepository {
  Future<Response> loginRepository(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async { 
    Response response = await api.postDynamicFormData(
      context,
      AppApi.login,
      body,
    );

    return response;
  }

  Future<Response> logout(BuildContext context) async {
    Response response = await api.postDynamicData(context, AppApi.logout, {});

    return response;
  }

  Future<Response> register(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await api.postDynamicFormData(
      context,
      AppApi.register,
      body,
    );

    return response;
  }

  Future<Response> forgotPassword(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await api.postDynamicFormData(
      context,
      AppApi.forgotPassword,
      body,
    );

    return response;
  }

  Future<Response> changePassword(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await api.postDynamicFormData(
      context,
      AppApi.changePassword,
      body,
    );

    return response;
  }

  Future<Response> verifyEmailCode(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await api.postDynamicFormData(
      context,
      AppApi.verifyEmailCode,
      body,
    );

    return response;
  }

  Future<Response> sendEmailCode(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await api.postDynamicData(
      context,
      AppApi.sendEmailCode,
      body,
    );

    return response;
  }
}
