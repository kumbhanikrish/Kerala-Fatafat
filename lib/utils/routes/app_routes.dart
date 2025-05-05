import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/modules/auth/view/forgot_password_screen.dart';
import 'package:kolkata_fatafat/modules/auth/view/login_screen.dart';
import 'package:kolkata_fatafat/modules/auth/view/otp_verification_screen.dart';

import 'package:kolkata_fatafat/modules/auth/view/sign_up_screen.dart';
import 'package:kolkata_fatafat/modules/auth/view/splash_screen.dart';
import 'package:kolkata_fatafat/modules/bet/view/bet_screen.dart';
import 'package:kolkata_fatafat/modules/dashboard/view/dashboard_screen.dart';
import 'package:kolkata_fatafat/modules/home/view/select_game_screen.dart';
import 'package:kolkata_fatafat/modules/home/view/slots_screen.dart';
import 'package:kolkata_fatafat/modules/bet/view/patti_screen.dart';
import 'package:kolkata_fatafat/modules/profile/view/about_us_screen.dart';
import 'package:kolkata_fatafat/modules/profile/view/bank_detail_screen.dart';
import 'package:kolkata_fatafat/modules/profile/view/change_password_screen.dart';
import 'package:kolkata_fatafat/modules/profile/view/edit_profile_screen.dart';
import 'package:kolkata_fatafat/modules/profile/view/bid_history_screen.dart';
import 'package:kolkata_fatafat/modules/profile/view/profile_screen.dart';
import 'package:kolkata_fatafat/modules/profile/view/refer_and_earn_screen.dart';
import 'package:kolkata_fatafat/modules/profile/view/support_screen.dart';
import 'package:kolkata_fatafat/modules/wallet/view/wallet_screen.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppRoutes.splashScreen: (context) => const SplashScreen(),
  AppRoutes.loginScreen: (context) => const LoginScreen(),
  AppRoutes.signUpSCreen: (context) => const SignUpSCreen(),
  AppRoutes.forgotPasswordScreen: (context) => ForgotPasswordScreen(),

  AppRoutes.dashboardScreen: (context) => DashboardScreen(),
  AppRoutes.editProfileScreen:
      (context) =>
          EditProfileScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppRoutes.changePasswordScreen: (context) => ChangePasswordScreen(),
  AppRoutes.walletScreen: (context) => WalletScreen(),
  AppRoutes.profileScreen: (context) => ProfileScreen(),
  AppRoutes.bidHistoryScreen: (context) => BidHistoryScreen(),
  AppRoutes.supportScreen: (context) => SupportScreen(),
  AppRoutes.supportScreen: (context) => SupportScreen(),
  AppRoutes.bankDetailScreen:
      (context) =>
          BankDetailScreen(data: ModalRoute.of(context)?.settings.arguments),

  AppRoutes.slotsScreen:
      (context) =>
          SlotsScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppRoutes.betScreen:
      (context) => BetScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppRoutes.otpVerificationScreen:
      (context) => OtpVerificationScreen(
        data: ModalRoute.of(context)?.settings.arguments,
      ),
  AppRoutes.aboutUsScreen: (context) => AboutUsScreen(),
  AppRoutes.pattiScreen:
      (context) =>
          PattiScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppRoutes.referAndEarnScreen:
      (context) =>
          ReferAndEarnScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppRoutes.selectGameScreen:
      (context) =>
          SelectGameScreen(data: ModalRoute.of(context)?.settings.arguments),
};
