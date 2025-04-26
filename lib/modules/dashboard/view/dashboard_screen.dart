import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/modules/money/view/add_money_screen.dart';
import 'package:kolkata_fatafat/modules/money/view/withdrawal_screen.dart';
import 'package:kolkata_fatafat/modules/result/view/result_screen.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_luncher.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:kolkata_fatafat/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:kolkata_fatafat/modules/home/view/home_screen.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_image.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final List<Widget> pages = [
    HomeScreen(),
    AddMoneyScreen(),
    WithdrawalScreen(),
    ResultScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    BottomNavCubit bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: CustomAppBar(
            centerTitle: false,
            title:
                currentIndex == 0
                    ? 'Home'
                    : currentIndex == 1
                    ? 'Add Money'
                    : currentIndex == 2
                    ? 'Withdrawal'
                    : 'Result',
            leading: CustomTextFiledImage(
              height: 24,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.profileScreen);
              },
              width: 24,
              color: AppColor.themePrimary2Color,
              image: AppImage.menu,
            ),

            actions: [
              InkWell(
                splashColor: AppColor.borderColor,
                highlightColor: AppColor.borderColor,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.walletScreen);
                },
                child: SvgPicture.asset(
                  AppImage.wallet,
                  color: AppColor.themePrimary2Color,
                ),
              ),
              Gap(20),

              InkWell(
                splashColor: AppColor.borderColor,
                highlightColor: AppColor.borderColor,
                onTap: () async {
                  String phoneNumber = await localDataSaver.getPhoneNumber();

                  launchDialer(phoneNumber);
                },
                child: SvgPicture.asset(
                  AppImage.call,

                  color: AppColor.themePrimary2Color,
                ),
              ),
              Gap(20),
              InkWell(
                onTap: () async {
                  String wpNumber = await localDataSaver.getWpNumber();

                  launchWhatsApp('+91$wpNumber', 'Hello');
                },
                child: SvgPicture.asset(AppImage.whatsapp, height: 24),
              ),
              Gap(24),
            ],
          ),
          body: pages[currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color:
                      AppColor
                          .borderColor, // white shadow with some transparency
                  offset: Offset(0, -1), // upward shadow
                  blurRadius: 80,
                  spreadRadius: 10,
                ),
              ],
              border: Border(
                top: BorderSide(width: 0.1, color: AppColor.whiteColor),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SalomonBottomBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  bottomNavCubit.updateIndex(index);
                },
                items: [
                  SalomonBottomBarItem(
                    icon: SvgPicture.asset(
                      AppImage.home,
                      color: AppColor.themePrimaryColor,
                      height: 24,
                    ),
                    title: CustomText(text: 'Home', fontSize: 12),
                    selectedColor: AppColor.themePrimary2Color,
                    unselectedColor: AppColor.themePrimaryColor,
                  ),
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AppImage.addMoney,

                      color: AppColor.themePrimaryColor,

                      height: 24,
                    ),
                    title: CustomText(text: 'Add Money', fontSize: 12),

                    selectedColor: AppColor.themePrimary2Color,
                    unselectedColor: AppColor.themePrimaryColor,
                  ),
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      'assets/image/withdrawal.png',
                      color: AppColor.themePrimaryColor,

                      height: 24,
                    ),
                    unselectedColor: AppColor.themePrimaryColor,
                    title: CustomText(text: 'Withdrawal', fontSize: 12),

                    selectedColor: AppColor.themePrimary2Color,
                  ),
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AppImage.result,

                      height: 24,
                      color: AppColor.themePrimaryColor,
                    ),
                    unselectedColor: AppColor.themePrimaryColor,
                    title: CustomText(text: 'Result', fontSize: 12),

                    selectedColor: AppColor.themePrimary2Color,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
