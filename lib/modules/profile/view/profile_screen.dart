import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/modules/auth/cubit/auth_cubit.dart';
import 'package:kolkata_fatafat/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:kolkata_fatafat/modules/profile/model/user_model.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_list_tile.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    BottomNavCubit bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        leading: CustomIconButton(
          icon: Icons.arrow_back_rounded,

          color: AppColor.themePrimary2Color,
          onPressed: () {
            bottomNavCubit.updateIndex(0);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.dashboardScreen,
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<User>(
            future: localDataSaver.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final userModel = snapshot.data!;

                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.themePrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: userModel.name,
                                  fontWeight: FontWeight.w900,
                                  color: AppColor.whiteColor,
                                ),
                                CustomText(
                                  text: userModel.phone,
                                  fontSize: 14,
                                  color: AppColor.whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: userModel.email,
                                  fontSize: 14,
                                  color: AppColor.whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            splashColor: AppColor.borderColor,
                            highlightColor: AppColor.borderColor,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.editProfileScreen,

                                arguments: {'userModel': userModel},
                              );
                            },
                            child: SvgPicture.asset(
                              AppImage.edit,
                              color: AppColor.backgroundColor,
                            ),
                          ),
                          const Gap(10),
                        ],
                      ),
                    ),

                    const Gap(30),
                    CustomListTile(
                      text: 'Wallet',
                      leadingImage: AppImage.wallet,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.walletScreen);
                      },
                    ),

                    const Gap(5),
                    CustomListTile(
                      text: 'Change Password',
                      leadingImage: AppImage.changePassword,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.changePasswordScreen,
                        );
                      },
                    ),
                    const Gap(5),

                    CustomListTile(
                      text: 'Play & Bid history',
                      leadingImage: AppImage.history,
                      height: 30,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bidHistoryScreen,
                        );
                      },
                    ),
                    const Gap(5),
                    CustomListTile(
                      text: 'Bank Details',
                      leadingImage: AppImage.bank,

                      height: 30,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bankDetailScreen,
                          arguments: {'bankDetails': userModel.bankDetails},
                        );
                      },
                    ),
                    const Gap(5),
                    CustomListTile(
                      text: 'Support',
                      leadingImage: AppImage.support,
                      height: 30,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.supportScreen);
                      },
                    ),

                    const Gap(5),
                    CustomListTile(
                      text: 'Refer and Earn',
                      leadingImage: AppImage.referAndEarn,
                      height: 30,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.referAndEarnScreen,
                          arguments: {'referralCode': userModel.referralCode},
                        );
                      },
                    ),

                    const Gap(5),
                    CustomListTile(
                      text: 'About Us',
                      leadingImage: AppImage.about,
                      height: 30,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.aboutUsScreen);
                      },
                    ),

                    const Gap(5),
                    CustomListTile(
                      text: 'Log Out',
                      leadingImage: AppImage.logout,
                      leadingColor: AppColor.redColor,
                      onTap: () {
                        authCubit.logout(context);
                      },
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CustomText(
                    text: 'No Data Found!!!',
                    color: AppColor.whiteColor,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
