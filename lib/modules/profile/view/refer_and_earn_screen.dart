import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class ReferAndEarnScreen extends StatelessWidget {
  final dynamic data;
  const ReferAndEarnScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    String referralCode = data['referralCode'];
    return Scaffold(
      backgroundColor: AppColor.referralBG,
      appBar: CustomAppBar2(title: '', backgroundColor: AppColor.referralBG),

      body: Column(
        children: <Widget>[
          Image.asset(AppImage.referImage),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2, color: AppColor.borderColor),
                  ),
                  padding: EdgeInsets.all(12),

                  child: Column(
                    children: [
                      CustomText(
                        text: 'INVITE FRIEND & WIN BIG',
                        color: AppColor.referralTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      Gap(5),
                      CustomText(
                        text:
                            'Every share cash prize@1k to 10k cash prize. Chance for winning (Mobile,TV,Fridge,Laptop,A.C.,Bike,Maruti,Etc)',
                        color: AppColor.referralTextColor,
                        fontSize: 14,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Gap(20),
                DottedBorder(
                  color: AppColor.borderColor,
                  strokeWidth: 2,
                  dashPattern: [6, 3],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.referralTextColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              CustomText(
                                text: 'Your referral code',
                                color: AppColor.themePrimary2Color.withOpacity(
                                  0.5,
                                ),
                                fontSize: 12,
                              ),
                              Gap(5),
                              CustomText(
                                text: referralCode,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColor.whiteColor,
                              ),
                            ],
                          ),
                          Gap(24),

                          Container(
                            height: 50,
                            width: 1,
                            color: AppColor.themePrimaryColor.withOpacity(0.2),
                          ),
                          Gap(24),

                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: referralCode),
                              );
                            },
                            child: CustomText(
                              text: 'Copy\nCode',
                              fontSize: 12,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(20),

                CustomText(
                  text: 'Share your Referral Code via',
                  fontWeight: FontWeight.bold,
                  color: AppColor.whiteColor,
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.greenColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    splashColor: AppColor.borderColor,
                    highlightColor: AppColor.borderColor,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      final String text =
                          'Sign up for an account and we both get Rs.100 to Rs.1000 free wallet cash. Use this below Code : $referralCode';
                      final String link = 'https://i.diawi.com/BH4yPP';

                      Share.share(
                        '$text\n\n$link',
                        subject: 'Kerala Fatafat APK',
                      );
                      // try {
                      //   final byteData = await rootBundle.load(
                      //     'assets/image/kerala-fatafat.apk',
                      //   );

                      //   // Get temporary directory
                      //   final tempDir = await getTemporaryDirectory();
                      //   final file = File(
                      //     '${tempDir.path}/kerala-fatafat.apk',
                      //   );

                      //   // Write the APK to temp file
                      //   await file.writeAsBytes(
                      //     byteData.buffer.asUint8List(),
                      //   );

                      //   // Share the APK with text
                      //   await Share.shareXFiles(
                      //     [
                      //       XFile(
                      //         file.path,
                      //         mimeType:
                      //             'application/vnd.android.package-archive',
                      //       ),
                      //     ],
                      //     text:
                      //         'Hey! Try out this awesome app.\nUse referral code: 123ABC',
                      //   );
                      // } catch (e) {
                      //   log('Error sharing APK: $e');
                      // }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppImage.outlineWhatsApp,
                            height: 24,
                            color: AppColor.whiteColor,
                          ),
                          Gap(10),
                          CustomText(
                            text: 'Share',
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Stack(
      //   children: [
      //     Column(
      //       children: [
      //         Expanded(
      //           flex: 2,
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: AppColor.themePrimaryColor,555
      //               borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(30),
      //                 bottomRight: Radius.circular(30),
      //               ),
      //             ),
      //             child: Center(
      //               child: Padding(
      //                 padding: const EdgeInsets.only(top: 10, bottom: 30),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: <Widget>[
      //                     Padding(
      //                       padding: const EdgeInsets.symmetric(horizontal: 80),
      //                       child: CustomText(
      //                         text: 'SHARE AND EARN',
      //                         color: AppColor.whiteColor,
      //                         fontSize: 24,
      //                         fontWeight: FontWeight.w600,
      //                         textAlign: TextAlign.center,
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 20.h,
      //                       child: Lottie.asset(AppImage.gift),
      //                     ),

      //                     Padding(
      //                       padding: const EdgeInsets.symmetric(horizontal: 40),
      //                       child: CustomText(
      //                         text:
      //                             'Every share cash prize@1k to 10k cash prize.Chance for winning (Mobile,TV,Fridge,Laptop,A.C.,Bike,Maruti,Etc)',
      //                         color: AppColor.whiteColor,
      //                         textAlign: TextAlign.center,
      //                         fontSize: 14,
      //                       ),
      //                     ),

      // DottedBorder(
      //   color: AppColor.borderColor,
      //   strokeWidth: 2,
      //   dashPattern: [6, 3],
      //   borderType: BorderType.RRect,
      //   radius: Radius.circular(12),
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: AppColor.borderColor,
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(
      //         horizontal: 24,
      //         vertical: 10,
      //       ),
      //       child: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: <Widget>[
      //           Column(
      //             children: <Widget>[
      //               CustomText(
      //                 text: 'Your referral code',
      //                 color: AppColor.themePrimary2Color
      //                     .withOpacity(0.5),
      //                 fontSize: 12,
      //               ),
      //               Gap(5),
      //               CustomText(
      //                 text: referralCode,
      //                 fontSize: 24,
      //                 fontWeight: FontWeight.bold,
      //                 color: AppColor.whiteColor,
      //               ),
      //             ],
      //           ),
      //           Gap(24),

      //           Container(
      //             height: 50,
      //             width: 1,
      //             color: AppColor.themePrimaryColor
      //                 .withOpacity(0.2),
      //           ),
      //           Gap(24),

      //           InkWell(
      //             onTap: () {
      //               Clipboard.setData(
      //                 ClipboardData(text: referralCode),
      //               );
      //             },
      //             child: CustomText(
      //               text: 'Copy\nCode',
      //               fontSize: 12,
      //               color: AppColor.whiteColor,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

      // CustomText(
      //   text: 'Share your Referral Code via',
      //   fontWeight: FontWeight.bold,
      //   color: AppColor.whiteColor,
      // ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),

      //         Expanded(
      //           flex: 1,
      //           child: Padding(
      //             padding: const EdgeInsets.all(24),
      //             child: Column(
      //               children: <Widget>[
      // Container(
      //   decoration: BoxDecoration(
      //     color: AppColor.greenColor,
      //     borderRadius: BorderRadius.circular(30),
      //   ),
      //   child: InkWell(
      //     splashColor: AppColor.borderColor,
      //     highlightColor: AppColor.borderColor,
      //     borderRadius: BorderRadius.circular(30),
      //     onTap: () async {
      //       final String text =
      //           'Sign up for an account and we both get Rs.100 to Rs.1000 free wallet cash. Use this below Code : $referralCode';
      //       final String link = 'https://i.diawi.com/BH4yPP';

      //       Share.share(
      //         '$text\n\n$link',
      //         subject: 'Kerala Fatafat APK',
      //       );
      //       // try {
      //       //   final byteData = await rootBundle.load(
      //       //     'assets/image/kerala-fatafat.apk',
      //       //   );

      //       //   // Get temporary directory
      //       //   final tempDir = await getTemporaryDirectory();
      //       //   final file = File(
      //       //     '${tempDir.path}/kerala-fatafat.apk',
      //       //   );

      //       //   // Write the APK to temp file
      //       //   await file.writeAsBytes(
      //       //     byteData.buffer.asUint8List(),
      //       //   );

      //       //   // Share the APK with text
      //       //   await Share.shareXFiles(
      //       //     [
      //       //       XFile(
      //       //         file.path,
      //       //         mimeType:
      //       //             'application/vnd.android.package-archive',
      //       //       ),
      //       //     ],
      //       //     text:
      //       //         'Hey! Try out this awesome app.\nUse referral code: 123ABC',
      //       //   );
      //       // } catch (e) {
      //       //   log('Error sharing APK: $e');
      //       // }
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 14),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           SvgPicture.asset(
      //             AppImage.outlineWhatsApp,
      //             height: 24,
      //             color: AppColor.whiteColor,
      //           ),
      //           Gap(10),
      //           CustomText(
      //             text: 'Share',
      //             color: AppColor.whiteColor,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 16,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),

      //     CustomIconButton(
      //       icon: Icons.arrow_back_rounded,
      //       color: AppColor.whiteColor,
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
