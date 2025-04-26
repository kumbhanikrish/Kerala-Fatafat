import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kolkata_fatafat/modules/profile/cubit/profile_cubit.dart';
import 'package:kolkata_fatafat/modules/profile/model/bid_history_model.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_banner.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class BidHistoryScreen extends StatefulWidget {
  const BidHistoryScreen({super.key});

  @override
  State<BidHistoryScreen> createState() => _BidHistoryScreenState();
}

class _BidHistoryScreenState extends State<BidHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    profileCubit.userBid(context);
    List<BidHistoryModel> bidHistoryList = [];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.profileScreen,
          (route) => false,
        );
        return false; // prevent default back behavior
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Play & Bid History',
          leading: CustomIconButton(
            icon: Icons.arrow_back_rounded,

            color: AppColor.themePrimary2Color,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.profileScreen,
                (route) => false,
              );
            },
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is BidHistoryLoaded) {
                bidHistoryList = state.bidHistoryList;
              }
              return bidHistoryList.isEmpty
                  ? Center(
                    child: CustomText(
                      text: 'Bet history Not found!!!',
                      color: AppColor.greyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                  : ListView.separated(
                    itemCount: bidHistoryList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Gap(20);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      BidHistoryModel bidHistoryModel =
                          (bidHistoryList.reversed.toList())[index];
                      return Stack(
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: DateFormat(
                                            'dd-MM-yyyy',
                                          ).format(bidHistoryModel.createdAt),

                                          color: AppColor.greyColor,
                                        ),
                                        Gap(10),
                                        CustomText(
                                          text: bidHistoryModel.timeSlot,
                                          color: AppColor.themePrimary2Color,
                                        ),
                                        Gap(10),

                                        CustomText(
                                          text: 'Rs.${bidHistoryModel.amount}',
                                          color: AppColor.themePrimaryColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24,
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            bidHistoryModel.winStatus == 'win'
                                                ? AppColor.greenColor
                                                : bidHistoryModel.winStatus ==
                                                    'loss'
                                                ? AppColor.redColor
                                                : AppColor.amberColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 8,
                                      ),
                                      child: CustomText(
                                        text: bidHistoryModel.digit.toString(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right:
                                BannerLocation.topEnd == BannerLocation.topEnd
                                    ? -24
                                    : null,
                            top:
                                BannerLocation.topEnd == BannerLocation.topEnd
                                    ? 18
                                    : null,
                            child: CustomBanner(
                              text: bidHistoryModel.winStatus ?? 'Pending',
                              color:
                                  bidHistoryModel.winStatus == 'win'
                                      ? AppColor.greenColor
                                      : bidHistoryModel.winStatus == 'loss'
                                      ? AppColor.redColor
                                      : AppColor.themePrimaryColor,
                              textColor: AppColor.whiteColor,
                            ),
                          ),
                        ],
                      );
                    },
                  );
            },
          ),
        ),
      ),
    );
  }
}
