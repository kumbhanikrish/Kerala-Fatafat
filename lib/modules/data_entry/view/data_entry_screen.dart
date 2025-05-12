import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/data_entry/cubit/data_entry_cubit.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class DataEntryScreen extends StatefulWidget {
  final dynamic data;
  const DataEntryScreen({super.key, this.data});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController noController = TextEditingController();
    final List<String> letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    String changeLetters = '';
    int totalMember = 0;
    ChangeBorder2Cubit changeBorder2Cubit = BlocProvider.of<ChangeBorder2Cubit>(
      context,
    );
    DataEntryCubit dataEntryCubit = BlocProvider.of<DataEntryCubit>(context);
    changeBorder2Cubit.init();

    dataEntryCubit.totalGetEntry(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColor.transparentColor),
    );

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar2(
        backgroundColor: AppColor.blueColor,
        title: 'Counter',
        textColor: AppColor.whiteColor,

        leading: CustomIconButton(
          icon: Icons.refresh,
          onPressed: () {
            dataEntryCubit.totalGetEntry(context);
          },
          color: AppColor.whiteColor,
        ),
        actions: [
          CustomTextButton(
            text: 'Clear',
            color: AppColor.whiteColor,
            onPressed: () {
              changeBorder2Cubit.init();
              noController.clear();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Person No.',
                      fillColor: AppColor.grey100Color,
                      borderColor: AppColor.grey100Color,
                      keyboardType: TextInputType.number,
                      controller: noController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                          4,
                        ), // Enforce 4-character limit
                      ],
                      inputColor: AppColor.blackColor,

                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColor.themePrimary2Color,
                        ),
                        onPressed: () {
                          noController.clear();
                        },
                      ),
                    ),
                  ),
                  Gap(10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.blueColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, AppRoutes.qrScannerScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Icon(
                          Icons.qr_code_scanner_outlined,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20),

              BlocBuilder<ChangeBorder2Cubit, ChangeBorder2State>(
                builder: (context, state) {
                  if (state is ChangeBorder2Loaded) {
                    changeLetters = state.changeLetters;
                  }
                  return GridView.builder(
                    itemCount: letters.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        splashColor: AppColor.borderColor,
                        highlightColor: AppColor.borderColor,
                        onTap: () {
                          changeBorder2Cubit.changeBorderValue(
                            changeLetters: letters[index],
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.blue100Color,

                            border: Border.all(
                              width: 5,
                              color:
                                  changeLetters == letters[index]
                                      ? AppColor.blueColor
                                      : AppColor.transparentColor,
                            ),
                          ),
                          child: Center(
                            child: CustomText(
                              text: letters[index],
                              color: AppColor.blueColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Gap(20),

              BlocBuilder<ChangeBorder2Cubit, ChangeBorder2State>(
                builder: (context, state) {
                  if (state is ChangeBorder2Loaded) {
                    changeLetters = state.changeLetters;
                  }
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColor.blueColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (noController.text.trim().isEmpty) {
                          customToast(
                            context,
                            text: 'Please Enter Person No.',

                            animatedSnackBarType: AnimatedSnackBarType.error,
                          );
                        } else if (changeLetters.isEmpty) {
                          customToast(
                            context,
                            text: 'Please Select Section',

                            animatedSnackBarType: AnimatedSnackBarType.error,
                          );
                        } else {
                          await dataEntryCubit.getEntry(
                            context,
                            sNumber:
                                '${noController.text.trim()}$changeLetters',
                          );

                          changeBorder2Cubit.init();
                          noController.clear();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: CustomText(
                            text: 'Add',
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Gap(20),

              BlocBuilder<DataEntryCubit, DataEntryState>(
                builder: (context, state) {
                  if (state is DataEntryLoaded) {
                    totalMember = state.totalMember;
                  }
                  return Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: AppColor.themePrimary3Color,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Total Member',
                            fontSize: 18,
                            color: AppColor.greyColor,
                          ),
                          Gap(10),
                          CustomText(
                            text: totalMember.toString(),
                            fontSize: 32,
                            color: AppColor.blueColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Gap(20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppColor.themePrimary3Color,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: InkWell(
                  onTap: () {
                    dataEntryCubit.getExtraEntry(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: CustomText(
                        text: 'Add 1 Extra Member',
                        color: AppColor.greyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
