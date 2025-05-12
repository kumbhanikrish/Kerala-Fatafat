// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/modules/auth/repository/auth_repository.dart';
import 'package:kolkata_fatafat/modules/auth/view/splash_screen.dart';
import 'package:kolkata_fatafat/modules/profile/model/user_model.dart';

import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/initial/initial_state.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository authRepository = AuthRepository();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<Response> login(
    BuildContext context, {
    required String email,
    required String pass,
  }) async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    Map<String, dynamic> loginBody = {
      "email": email,
      "password": pass,
      "fcm_token": token,
    };
    Response response = await authRepository.loginRepository(
      context,
      body: loginBody,
    );

    if (response.statusCode == 200) {
      // await localDataSaver.setUserId(response.data['data']['u_id']);
      // await localDataSaver.setUserName(response.data['data']['name']);
      await localDataSaver.setAuthToken(response.data['data']['token'] ?? '');
      await localDataSaver.setPhoneNumber(
        response.data['data']['system']['phone_number'] ?? '',
      );
      await localDataSaver.setWpNumber(
        response.data['data']['system']['wp_phone_number'] ?? '',
      );

      User user = User.fromJson(response.data['data']['user']);

      log('useruser ::${user.bankDetails.upiId}');
      await localDataSaver.setUserData(user);

      await EasyLoading.dismiss();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.dashboardScreen,
        (route) => false,
      );

      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
      return response;
    } else {
      await EasyLoading.dismiss();

      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );
      //
      return response;
    }
  }

  Future<Response> logout(BuildContext context) async {
    Response response = await authRepository.logout(context);

    if (response.statusCode == 200) {
      //
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (route) => false,
      );
      allStateInitial(context);
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
      return response;
    } else {
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );
      //
      return response;
    }
  }

  Future<Response> register(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await authRepository.register(context, body: body);

    if (response.statusCode == 200) {
      log('idisdfhsh ::${response.data['data']['token']}');
      await localDataSaver.setAuthToken(response.data['data']['token'] ?? '');

      Navigator.pushNamed(context, AppRoutes.loginScreen);

      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
      return response;
    } else {
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );
      //
      return response;
    }
  }

  Future<Response> forgotPassword(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await authRepository.forgotPassword(
      context,
      body: body,
    );

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (route) => false,
      );

      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
      return response;
    } else {
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );

      return response;
    }
  }

  Future<Response> changePassword(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await authRepository.changePassword(
      context,
      body: body,
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
      return response;
    } else {
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );

      return response;
    }
  }

  Future<Response> versionCheck(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await authRepository.versionCheck(context, body: body);

    if (response.data['needs_update'] == true) {
      customUpdateAlertPopUp(context);
      return response;
    } else {
      String authToken = await localDataSaver.getAuthToken();

      log('authTokenauthToken ::$authToken');
      if (authToken.isEmpty) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginScreen,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashboardScreen,
          (route) => false,
        );
      }

      return response;
    }

    // if (response.statusCode == 200) {
    //   customToast(
    //     context,
    //     text: response.data['message'],
    //     animatedSnackBarType: AnimatedSnackBarType.success,
    //   );
    //   return response;
    // } else {
    //   customToast(
    //     context,
    //     text: response.data['message'],
    //     animatedSnackBarType: AnimatedSnackBarType.error,
    //   );

    //   return response;
    // }
  }

  Future<Response> verifyEmailCode(
    BuildContext context, {
    required Map<String, dynamic> body,
    required Map<String, dynamic> registerBody,
  }) async {
    Response response = await authRepository.verifyEmailCode(
      context,
      body: body,
    );

    if (response.statusCode == 200) {
      register(context, body: registerBody);

      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
      return response;
    } else {
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );

      return response;
    }
  }

  Future<Response> sendEmailCode(
    BuildContext context, {
    required Map<String, dynamic> body,
    required String name,
    required String number,
    required String pass,
    required String rePass,

    required String referral,
    bool resend = false,
  }) async {
    Response response = await authRepository.sendEmailCode(context, body: body);

    if (response.statusCode == 200) {
      if (resend == false) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.otpVerificationScreen,
          arguments: {
            'email': body['email'],

            'name': name,

            'number': number,
            'pass': pass,
            'rePass': rePass,
            'referral': referral,
          },
          (route) => false,
        );
      }

      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
      return response;
    } else {
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );

      return response;
    }
  }

  init() {
    emit(AuthInitial());
  }
}

class ChangePassCubit extends Cubit<bool> {
  ChangePassCubit() : super(false);
  changeValue() {
    emit(!state);
  }

  init() {
    emit(false);
  }
}

class ChangePass2Cubit extends Cubit<bool> {
  ChangePass2Cubit() : super(false);
  changeValue() {
    emit(!state);
  }

  init() {
    emit(false);
  }
}
