import 'dart:developer';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kolkata_fatafat/modules/money/repository/money_repository.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';

part 'money_state.dart';

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit() : super(MoneyInitial());

  MoneyRepository moneyRepository = MoneyRepository();

  Future qrCode(BuildContext context) async {
    final Response response = await moneyRepository.qrCode(context);

    if (response.statusCode == 200) {
      log('sddgggdf :;${response.data['date']}');
      emit(QrCodeLoaded(qrCode: response.data['date'] ?? ''));
    }
  }

  Future<Response> manageWallet(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    final Response response = await moneyRepository.manageWallet(context, body);

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, AppRoutes.walletScreen);
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.success,
      );
    } else {
      customToast(
        context,
        text: response.data['message'],
        animatedSnackBarType: AnimatedSnackBarType.error,
      );
    }

    return response;
  }

  init() {
    emit(MoneyInitial());
  }
}

class ScreenshotCubit extends Cubit<File?> {
  ScreenshotCubit() : super(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      emit(File(image.path)); // Emit selected image
    }
  }

  void removeImage() {
    emit(null);
  }
}
