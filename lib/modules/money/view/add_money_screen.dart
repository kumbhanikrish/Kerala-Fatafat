import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/money/cubit/money_cubit.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_image.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController transactionIdController = TextEditingController();
  final TextEditingController uploadScreenshotsController =
      TextEditingController();

  String qrCode = '';

  @override
  Widget build(BuildContext context) {
    MoneyCubit moneyCubit = BlocProvider.of<MoneyCubit>(context);
    ScreenshotCubit screenshotCubit = BlocProvider.of<ScreenshotCubit>(context);
    screenshotCubit.removeImage();
    moneyCubit.init();
    amountController.clear();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BlocBuilder<MoneyCubit, MoneyState>(
              builder: (context, state) {
                if (state is QrCodeLoaded) {
                  qrCode = state.qrCode;
                }
                return qrCode.isEmpty
                    ? Column(
                      children: <Widget>[
                        CustomTextField(
                          hintText: 'Amount Rs.',
                          controller: amountController,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                        ),

                        Gap(30),

                        CustomButton(
                          text: 'Next',
                          onTap: () {
                            if (amountController.text.isNotEmpty) {
                              moneyCubit.qrCode(context);
                            }
                          },
                        ),
                      ],
                    )
                    : SizedBox();
              },
            ),

            Gap(30),
            BlocBuilder<MoneyCubit, MoneyState>(
              builder: (context, state) {
                if (state is! QrCodeLoaded) {
                  return Container();
                } else {
                  qrCode = state.qrCode;
                  return Column(
                    children: [
                      CustomCachedImage(
                        imageUrl: qrCode,
                        height: 40.h,
                        width: 100.w,
                      ),
                      // Container(
                      // height: 30.h,
                      // width: 100.w,

                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: NetworkImage(qrCode),
                      //       fit: BoxFit.fill,
                      //     ),
                      //   ),
                      // ),
                      Gap(30),
                      CustomTextField(
                        hintText: 'Transaction Id',
                        controller: transactionIdController,
                      ),
                      Gap(10),
                      CustomTextField(
                        hintText: 'Upload Screenshots',
                        readOnly: true,
                        fillColor: AppColor.borderColor,
                        onTap: () {
                          screenshotCubit.pickImage();
                        },
                        controller: uploadScreenshotsController,
                      ),

                      BlocBuilder<ScreenshotCubit, File?>(
                        builder: (context, selectedImage) {
                          return (selectedImage?.path ?? '').isEmpty
                              ? Container()
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    Image.file(
                                      File(selectedImage?.path ?? ''),
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: InkWell(
                                        splashColor: AppColor.borderColor,
                                        highlightColor: AppColor.borderColor,
                                        onTap: () {
                                          screenshotCubit.removeImage();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: AppColor.themePrimary2Color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                        },
                      ),

                      Gap(30),

                      BlocBuilder<ScreenshotCubit, File?>(
                        builder: (context, selectedImage) {
                          return CustomButton(
                            text: 'Add Money',
                            onTap: () async {
                              Map<String, dynamic> body = {
                                'photo': await MultipartFile.fromFile(
                                  selectedImage?.path ?? '',
                                  filename: "file.jpg",
                                ),
                                'type': 'deposit',
                                'amount': amountController.text.trim(),
                                'transaction_id':
                                    transactionIdController.text.trim(),
                              };
                              moneyCubit.manageWallet(context, body: body).then(
                                (e) {
                                  if (e.statusCode == 200) {
                                    screenshotCubit.removeImage();
                                    moneyCubit.init();

                                    amountController.clear();
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
