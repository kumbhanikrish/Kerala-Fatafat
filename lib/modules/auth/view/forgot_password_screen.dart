import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/auth/cubit/auth_cubit.dart';
import 'package:kolkata_fatafat/modules/auth/view/login_screen.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_image.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Forgot password',
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              const Gap(5),
              CustomText(
                text: 'Enter the number to recover the password',
                fontSize: 14,
                color: AppColor.themePrimary2Color,
              ),
              const Gap(30),
              CustomTextField(
                prefixIcon: CustomTextFiledImage(image: AppImage.email),

                hintText: 'Email',
                controller: emailController,
              ),

              const Gap(30),
              CustomButton(
                text: 'Send',
                onTap: () {
                  if (emailController.text.isEmpty) {
                    customToast(
                      context,
                      text: 'Please enter your number',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (!emailRegex.hasMatch(emailController.text)) {
                    customToast(
                      context,
                      text: 'Please enter a valid email',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else {
                    Map<String, dynamic> body = {
                      "email": emailController.text.trim(),
                    };

                    authCubit.forgotPassword(context, body: body);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
