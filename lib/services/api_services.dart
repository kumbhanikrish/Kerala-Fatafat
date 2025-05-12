import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kolkata_fatafat/local_data/local_data_sever.dart';
import 'package:kolkata_fatafat/main.dart';

import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';

LocalDataSaver dataSaver = LocalDataSaver();

class ApiServices {
  final Dio dio = Dio();

  Map<String, dynamic> params = {};

  Future getDynamicData(BuildContext context, String url) async {
    log("Url :: $url");
    final token = await dataSaver.getAuthToken();

    log('tokentokentoken ::$token');

    try {
      await EasyLoading.show();

      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            "Content-device": "application/json",
            "Authorization": "Bearer $token",
            'Accept': 'application/json',
          },
        ),
      );
      log("response.statusCode :: ${response.statusCode}");
      log("response.data :: ${response.data}");

      if (response.statusCode == 200) {
        await EasyLoading.dismiss();

        return response;
      }
    } on DioException catch (e) {
      await EasyLoading.dismiss();

      log("DioException :: ${e.response?.data} , ${e.response?.statusCode}");

      if (e.response?.statusCode == 401) {
        await localDataSaver.setAuthToken('');
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginScreen,
          (route) => false,
        );
      }
      final errorData = e.response?.data['data'];
      showValidationErrors(context, responseBody: jsonEncode(errorData));
    } catch (e) {
      await EasyLoading.dismiss();

      log("Error :: $e");
    }
  }

  Future postDynamicData(
    BuildContext context,
    String url,
    Map<String, dynamic> params,
  ) async {
    log("params :: $params");
    log("Url :: $url");
    final token = await dataSaver.getAuthToken();

    try {
      await EasyLoading.show();

      Response response = await dio.post(
        url,
        data: params,
        options: Options(
          headers: {
            "Content-device": "application/json",
            "Authorization": "Bearer $token",
            'Accept': 'application/json',
          },
        ),
      );
      log("statusCode ::${response.statusCode}");
      log("response.data :: ${response.data}");

      if (response.statusCode == 200) {
        await EasyLoading.dismiss();
        return response;
      }
    } on DioException catch (e) {
      await EasyLoading.dismiss();
      if (e.response?.statusCode == 401) {
        await localDataSaver.setAuthToken('');
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginScreen,
          (route) => false,
        );
      }

      log("DioException :: ${e.response?.data} , ${e.response?.statusCode}");
      final errorData = e.response?.data['data'];
      final messages = e.response?.data['messages'];

      log('errorData ::$errorData');
      showValidationErrors(
        context,
        responseBody: jsonEncode(errorData ?? messages),
      );
    } catch (e) {
      await EasyLoading.dismiss();

      log("Error :: $e");
    }
  }

  Future deleteDynamicData(
    BuildContext context,
    String url,
    Map<String, dynamic> params,
  ) async {
    log("params :: $params");
    log("Url :: $url");
    final token = await dataSaver.getAuthToken();

    try {
      await EasyLoading.show();

      final Response response = await dio.delete(
        url,
        data: params,
        options: Options(
          headers: {
            "Content-device": "application/json",
            "Authorization": "Bearer $token",
            'Accept': 'application/json',
          },
        ),
      );
      log("response.statusCode :: ${response.statusCode}");
      log("response.data :: ${response.data}");

      if (response.statusCode == 200) {
        await EasyLoading.dismiss();
        return response;
      }
    } on DioException catch (e) {
      await EasyLoading.dismiss();

      if (e.response?.statusCode == 401) {
        await localDataSaver.setAuthToken('');
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginScreen,
          (route) => false,
        );
      }
      final errorData = e.response?.data['data'];
      showValidationErrors(context, responseBody: jsonEncode(errorData));
      log("DioException :: ${e.response?.data} , ${e.response?.statusCode}");
    } catch (e) {
      await EasyLoading.dismiss();

      log("Error :: $e");
    }
  }

  Future postDynamicFormData(
    BuildContext context,
    String url,
    Map<String, dynamic> body,
  ) async {
    log('postDynamicFormData ::$url');
    log('bodybodybodybodybody ::$body');
    final token = await dataSaver.getAuthToken();

    FormData formData = FormData.fromMap(
      body,
      //   {
      //   "name": "John Doe",
      //   "email": "john.doe@example.com",
      //   "age": 25,
      // "file": await MultipartFile.fromFile(
      //   "path/to/file.jpg",
      //   filename: "file.jpg",
      // ), // Optional file upload
      // }
    );

    try {
      await EasyLoading.show();
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Content-device": "application/json",
            "Authorization": "Bearer $token",
            'Accept': 'application/json',
          },
        ),
      );

      log("response.statusCode :: ${response.statusCode}");
      log("response.data :: ${response.data}");

      if (response.statusCode == 200) {
        await EasyLoading.dismiss();

        return response;
      }
    } on DioException catch (e) {
      log('eeeee ::${e.response}');
      await EasyLoading.dismiss();

      if (e.response?.statusCode == 401) {
        await localDataSaver.setAuthToken('');
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginScreen,
          (route) => false,
        );
      }
      final errorData = e.response?.data['data'];
      showValidationErrors(context, responseBody: jsonEncode(errorData));
      log("DioException :: ${e.response?.data} , ${e.response?.statusCode}");
    } catch (e) {
      await EasyLoading.dismiss();

      log("Exception: $e");
    }
  }
}
