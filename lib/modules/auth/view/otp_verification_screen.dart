import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/auth/cubit/auth_cubit.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatelessWidget {
  final dynamic data;
  OtpVerificationScreen({super.key, required this.data});
  final TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    String email = data['email'];
    String name = data['name'];
    String number = data['number'];
    String pass = data['pass'];
    String rePass = data['rePass'];
    String referral = data['referral'];
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      
      textStyle: TextStyle(
        fontSize: 16,
        color: AppColor.themePrimaryColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Verification code',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            CustomText(
              text: 'We sent to the number $email',
              fontSize: 14,
              color: AppColor.themePrimary2Color,
            ),
            const Gap(30),
            Center(
              child: Pinput(
                controller: pinController,
                length: 6,
                animationCurve: Curves.easeInOut,
                defaultPinTheme: defaultPinTheme,
              ),
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Didn't receive code?",
                  color: AppColor.themePrimary2Color,
                  fontSize: 14,
                ),
                const Gap(5),
                InkWell(
                  onTap: () {
                    Map<String, dynamic> body = {'email': email};

                    authCubit.sendEmailCode(
                      context,
                      body: body,
                      name: '',
                      number: '',
                      pass: '',
                      rePass: '',
                      referral: '',
                      resend: true,
                    );
                  },
                  child: CustomText(
                    text: 'Resend code',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColor.themePrimaryColor,
                  ),
                ),
              ],
            ),
            const Gap(30),
            CustomButton(
              text: 'Verify',
              onTap: () {
                Map<String, dynamic> registerUser = {
                  "name": name,
                  "email": email,
                  "phone": number.replaceAll('+', ''),
                  "password": pass,
                  "c_password": rePass,
                  "referal_code": referral,
                };

                Map<String, dynamic> body = {
                  "email": email,
                  "code": pinController.text.trim(),
                };
                authCubit.verifyEmailCode(
                  context,
                  body: body,
                  registerBody: registerUser,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
