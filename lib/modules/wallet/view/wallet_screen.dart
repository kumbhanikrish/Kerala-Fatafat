import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kolkata_fatafat/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:kolkata_fatafat/modules/wallet/cubit/wallet_cubit.dart';
import 'package:kolkata_fatafat/modules/wallet/model/wallet_model.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_banner.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WalletCubit>(context).wallet(context);
    BottomNavCubit bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);

    WalletModel walletModel = WalletModel(walletBalance: '', transactions: []);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Wallet',
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
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              if (state is WalletLoaded) {
                walletModel = state.walletModel;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColor.themePrimaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Available Balance',
                            color: AppColor.whiteColor,
                          ),
                          Gap(10),
                          BlocBuilder<WalletCubit, WalletState>(
                            builder: (context, state) {
                              return CustomText(
                                text: 'Rs.${walletModel.walletBalance}',
                                color: AppColor.backgroundColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 32,
                              );
                            },
                          ),
                          Gap(24),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  splashColor: AppColor.borderColor,
                                  highlightColor: AppColor.borderColor,
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.dashboardScreen,
                                      (route) => false,
                                    );
                                    bottomNavCubit.updateIndex(1);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: AppColor.borderColor,
                                      ),
                                      Gap(5),
                                      CustomText(
                                        text: 'Add Fund',

                                        color: AppColor.whiteColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                height: 30,
                                width: 1,
                                color: AppColor.backgroundColor.withOpacity(
                                  0.2,
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  splashColor: AppColor.borderColor,
                                  highlightColor: AppColor.borderColor,
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.dashboardScreen,
                                      (route) => false,
                                    );
                                    bottomNavCubit.updateIndex(2);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.arrow_downward_rounded,
                                        color: AppColor.borderColor,
                                      ),

                                      CustomText(
                                        text: 'Withdraw',
                                        color: AppColor.whiteColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(24),
                  CustomText(
                    text: 'Latest Transactions',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                  Gap(24),
                  walletModel.transactions.isEmpty
                      ? Center(
                        child: CustomText(
                          text: 'Transactions Not found!!!',
                          color: AppColor.greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: walletModel.transactions.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Gap(20);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          Transaction transaction =
                              (walletModel.transactions.reversed
                                  .toList())[index];
                          return Stack(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppColor.themePrimary3Color,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text:
                                                      transaction.type[0]
                                                          .toUpperCase() +
                                                      transaction.type
                                                          .substring(1)
                                                          .toLowerCase(),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),

                                                if (transaction.type != 'bet' &&
                                                    transaction.type !=
                                                        'win') ...[
                                                  Gap(5),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      CustomText(
                                                        text: 'ID : ',

                                                        color:
                                                            AppColor
                                                                .themePrimaryColor,
                                                      ),
                                                      Expanded(
                                                        child: CustomText(
                                                          text:
                                                              transaction
                                                                  .transactionId,
                                                          color:
                                                              AppColor
                                                                  .themePrimary2Color,
                                                        ),
                                                      ),
                                                      Gap(10),
                                                    ],
                                                  ),
                                                ],

                                                Gap(5),
                                                Row(
                                                  children: <Widget>[
                                                    CustomText(
                                                      text: 'Date : ',

                                                      color:
                                                          AppColor
                                                              .themePrimaryColor,
                                                    ),
                                                    CustomText(
                                                      text: DateFormat(
                                                        'dd-MM-yyyy HH:mm',
                                                      ).format(
                                                        transaction.createdAt,
                                                      ),

                                                      color:
                                                          AppColor
                                                              .themePrimary2Color,
                                                    ),
                                                  ],
                                                ),
                                                Gap(5),

                                                if (transaction.status ==
                                                    'reject') ...[
                                                  Gap(5),

                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      CustomText(
                                                        text: 'Reason : ',

                                                        color:
                                                            AppColor.redColor,
                                                      ),
                                                      Expanded(
                                                        child: CustomText(
                                                          text:
                                                              transaction.note,

                                                          color:
                                                              AppColor
                                                                  .red100Color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          CustomText(
                                            text:
                                                transaction.type ==
                                                            'withdrawal' ||
                                                        transaction.type ==
                                                            'bet'
                                                    ? '- ₹${transaction.amount}'
                                                    : '+ ₹${transaction.amount}',
                                            color:
                                                transaction.type ==
                                                            'withdrawal' ||
                                                        transaction.type ==
                                                            'bet'
                                                    ? AppColor.redColor
                                                    : AppColor.greenColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          Gap(25),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right:
                                        BannerLocation.topEnd ==
                                                BannerLocation.topEnd
                                            ? -24
                                            : null,
                                    top:
                                        BannerLocation.topEnd ==
                                                BannerLocation.topEnd
                                            ? 20
                                            : null,
                                    child: CustomBanner(
                                      text:
                                          transaction.status[0].toUpperCase() +
                                          transaction.status
                                              .substring(1)
                                              .toLowerCase(),
                                      color:
                                          transaction.status == 'pending'
                                              ? AppColor.themePrimaryColor
                                              : transaction.status == 'approve'
                                              ? AppColor.greenColor
                                              : AppColor.redColor,
                                      textColor: AppColor.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
