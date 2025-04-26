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

class SignUpSCreen extends StatefulWidget {
  const SignUpSCreen({super.key});

  @override
  State<SignUpSCreen> createState() => _SignUpSCreenState();
}

class _SignUpSCreenState extends State<SignUpSCreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController numberController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ChangePassCubit changePassCubit = BlocProvider.of<ChangePassCubit>(context);
    ChangePass2Cubit changePass2Cubit = BlocProvider.of<ChangePass2Cubit>(
      context,
    );
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    changePassCubit.init();
    changePass2Cubit.init();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Create your Account',
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              const Gap(30),
              CustomTextField(
                hintText: 'Name',
                controller: nameController,
                prefixIcon: CustomTextFiledImage(image: AppImage.user),
              ),
              const Gap(10),
              CustomTextField(
                hintText: 'Email',
                controller: emailController,
                prefixIcon: CustomTextFiledImage(image: AppImage.email),
              ),
              const Gap(10),
              CustomTextField(
                hintText: 'Number',
                controller: numberController,
                prefixIcon: CustomTextFiledImage(image: AppImage.call),
              ),

              const Gap(10),
              BlocBuilder<ChangePassCubit, bool>(
                builder: (context, isHidden) {
                  return CustomTextField(
                    hintText: 'Password',
                    isPassword: !isHidden,
                    prefixIcon: CustomTextFiledImage(image: AppImage.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        !isHidden ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.themePrimary2Color,
                      ),
                      onPressed: () {
                        changePassCubit.changeValue();
                      },
                    ),
                    controller: passwordController,
                  );
                },
              ),
              const Gap(10),
              BlocBuilder<ChangePass2Cubit, bool>(
                builder: (context, isHidden2) {
                  return CustomTextField(
                    hintText: 'Re-Password',
                    prefixIcon: CustomTextFiledImage(image: AppImage.lock),
                    isPassword: !isHidden2,
                    suffixIcon: IconButton(
                      icon: Icon(
                        !isHidden2 ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.themePrimary2Color,
                      ),
                      onPressed: () {
                        changePass2Cubit.changeValue();
                      },
                    ),
                    controller: rePasswordController,
                  );
                },
              ),

              Gap(10),
              CustomTextField(
                hintText: 'Referral Code',
                controller: referralCodeController,
                prefixIcon: CustomTextFiledImage(image: AppImage.referralCode),
              ),
              const Gap(30),
              CustomButton(
                text: 'Sign up',
                onTap: () {
                  if (nameController.text.isEmpty) {
                    customToast(
                      context,
                      text: 'Please enter your name',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (emailController.text.isEmpty) {
                    customToast(
                      context,
                      text: 'Please enter your email',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (!emailRegex.hasMatch(emailController.text)) {
                    customToast(
                      context,
                      text: 'Please enter a valid email',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (numberController.text.isEmpty) {
                    customToast(
                      context,
                      text: 'Please enter your number',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (numberController.text.length < 10) {
                    customToast(
                      context,
                      text: 'Please enter a valid number',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (passwordController.text.isEmpty) {
                    customToast(
                      context,
                      text: 'Please enter your password',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (passwordController.text !=
                      rePasswordController.text) {
                    customToast(
                      context,
                      text: 'Passwords do not match',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else {
                    Map<String, dynamic> body = {
                      'email': emailController.text.trim(),
                    };

                    authCubit.sendEmailCode(
                      context,
                      body: body,
                      name: nameController.text.trim(),
                      number: numberController.text.trim(),
                      pass: passwordController.text.trim(),
                      rePass: rePasswordController.text.trim(),
                      referral: referralCodeController.text.trim(),
                    );
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
