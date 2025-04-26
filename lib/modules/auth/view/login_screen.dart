
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/auth/cubit/auth_cubit.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_image.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColor.themePrimaryColor),
    );

    ChangePassCubit changePassCubit = BlocProvider.of<ChangePassCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30),
            Align(
              child: Image.asset(AppImage.appLogo, height: 30.h, width: 30.h),
            ),
            ////////
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Login to your Account',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  const Gap(30),
                  CustomTextField(
                    hintText: 'Email',
                    controller: emailController,
                    prefixIcon: CustomTextFiledImage(image: AppImage.email),
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
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomTextButton(
                      text: 'Forgot the Password?',
                      onPressed: () async {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgotPasswordScreen,
                        );
                      },
                      color: AppColor.themePrimaryColor,
                    ),
                  ),
                  const Gap(30),
                  CustomButton(
                    text: 'Login',
                    onTap: () async {
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
                      } else if (passwordController.text.isEmpty) {
                        customToast(
                          context,
                          text: 'Please enter your password',
                          animatedSnackBarType: AnimatedSnackBarType.error,
                        );
                      } else {
                        authCubit.login(
                          context,
                          email: emailController.text.trim(),
                          pass: passwordController.text.trim(),
                        );
                      }
                    },
                  ),
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomText(
                        text: 'Already have an account?',
                        color: AppColor.themePrimary2Color,
                        fontSize: 14,
                      ),
                      const Gap(5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.signUpSCreen);
                        },
                        child: const CustomText(
                          text: 'Create Account',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
