// import 'package:country_code_picker/country_code_picker.dart';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kolkata_fatafat/modules/bet/cubit/bet_cubit.dart';
import 'package:kolkata_fatafat/modules/home/cubit/game_slot_cubit.dart';
import 'package:kolkata_fatafat/modules/home/cubit/home_cubit.dart';
import 'package:kolkata_fatafat/modules/money/cubit/money_cubit.dart';
import 'package:kolkata_fatafat/modules/profile/cubit/profile_cubit.dart';
import 'package:kolkata_fatafat/modules/result/cubit/result_cubit.dart';
import 'package:kolkata_fatafat/modules/wallet/cubit/wallet_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:kolkata_fatafat/local_data/local_data_sever.dart';
import 'package:kolkata_fatafat/modules/auth/cubit/auth_cubit.dart';

import 'package:kolkata_fatafat/modules/dashboard/cubit/dashboard_cubit.dart';

import 'package:kolkata_fatafat/services/api_services.dart';
import 'package:kolkata_fatafat/utils/routes/app_routes.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';

void configLoading() {
  EasyLoading.instance
    ..backgroundColor = AppColor.borderColor
    ..indicatorColor = AppColor.themePrimaryColor
    ..textColor = AppColor.themePrimaryColor
    ..progressColor = AppColor.themePrimaryColor
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    ..dismissOnTap = false;
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

ApiServices api = ApiServices();

LocalDataSaver localDataSaver = LocalDataSaver();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.requestPermission();

  // Init local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // FirebaseMessaging.instance.getInitialMessage().then((message) {

  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((message) {

  // });
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColor.themePrimaryColor),
  );
  runApp(const MyApp());
  configLoading();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling background message: ${message.messageId}");

  showNotification(message);
}

void showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? 'No Title',
    message.notification?.body ?? 'No Body',
    platformDetails,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📲 Foreground Message Received');
      showNotification(message);
    });
    handleMessageNavigation(RemoteMessage message) {
      final screen = message.data['screen'];

      log('screen');
      // if (screen == 'offers') {
      //   navigatorKey.currentState?.pushNamed('/offersScreen');
      // } else if (screen == 'profile') {
      //   navigatorKey.currentState?.pushNamed('/profileScreen');
      // }
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('🔁 App opened from background via notification');
      handleMessageNavigation(message);
    });

    return SafeArea(
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MultiBlocProvider(
            providers: providers,
            child: MaterialApp(
              navigatorKey: navigatorKey,

              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                dialogTheme: DialogTheme(
                  backgroundColor: AppColor.backgroundColor,
                  surfaceTintColor: AppColor.backgroundColor,
                ),

                appBarTheme: AppBarTheme(
                  backgroundColor: AppColor.backgroundColor,
                  surfaceTintColor: AppColor.backgroundColor,
                  iconTheme: IconThemeData(color: AppColor.themePrimary2Color),
                ),
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: AppColor.backgroundColor,
                  surfaceTintColor: AppColor.backgroundColor,
                ),
                scaffoldBackgroundColor: AppColor.backgroundColor,
                bottomAppBarTheme: BottomAppBarTheme(
                  color: AppColor.backgroundColor,
                  surfaceTintColor: AppColor.backgroundColor,
                ),
              ),
              routes: appRoutes,
              builder: EasyLoading.init(),
            ),
          );
        },
      ),
    );
  }
}

dynamic providers = [
  BlocProvider(create: (context) => AuthCubit()),
  BlocProvider(create: (context) => ChangePassCubit()),
  BlocProvider(create: (context) => ChangePass2Cubit()),
  BlocProvider(create: (context) => BottomNavCubit()),
  BlocProvider(create: (context) => HomeCubit()),
  BlocProvider(create: (context) => GameSlotCubit()),
  BlocProvider(create: (context) => ChangeBorderCubit()),
  BlocProvider(create: (context) => BetCubit()),
  BlocProvider(create: (context) => MoneyCubit()),
  BlocProvider(create: (context) => ScreenshotCubit()),
  BlocProvider(create: (context) => WalletCubit()),
  BlocProvider(create: (context) => ProfileCubit()),
  BlocProvider(create: (context) => ResultCubit()),
];
