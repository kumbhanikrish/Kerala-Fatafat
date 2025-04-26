import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async {
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(AppImage.appLogo)));
  }
}
