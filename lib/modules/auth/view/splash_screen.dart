import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/auth/cubit/auth_cubit.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async {
      AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version;

      Map<String, dynamic> body = {
        "platform": "android",
        "current_version": version,
      };

      authCubit.versionCheck(context, body: body);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(AppImage.appLogo)));
  }
}

customUpdateAlertPopUp(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,

    builder: (context) {
      return Dialog(
        backgroundColor: AppColor.transparentColor,
        insetPadding: EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.borderColor,
            border: Border.all(color: AppColor.themePrimaryColor, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomText(
                text: 'Update Available',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              Gap(5),
              CustomText(
                text:
                    'Your app version is outdated. Please visit our website and download the latest version.',
                color: AppColor.amber100Color,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}
