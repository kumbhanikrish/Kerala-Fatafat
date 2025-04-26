import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/auth/cubit/auth_cubit.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_image.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController conformPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    ChangePassCubit changePassCubit = BlocProvider.of<ChangePassCubit>(context);
    ChangePass2Cubit changePass2Cubit = BlocProvider.of<ChangePass2Cubit>(
      context,
    );
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    changePass2Cubit.init();
    changePassCubit.init();
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomText(
                text: 'Change password',
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
                controller: oldPasswordController,
                hintText: 'Old Password',
                prefixIcon: CustomTextFiledImage(image: AppImage.lock),
              ),
              const Gap(10),
              BlocBuilder<ChangePassCubit, bool>(
                builder: (context, isHidden) {
                  return CustomTextField(
                    hintText: 'New Password',
                    isPassword: !isHidden,
                    prefixIcon: CustomTextFiledImage(image: AppImage.lock),
                    suffixIcon: CustomIconButton(
                      icon: !isHidden ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.themePrimary2Color,
                      onPressed: () {
                        changePassCubit.changeValue();
                      },
                    ),
                    controller: newPasswordController,
                  );
                },
              ),
              const Gap(10),
              BlocBuilder<ChangePass2Cubit, bool>(
                builder: (context, isHidden2) {
                  return CustomTextField(
                    hintText: 'Conform Password',
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
                    controller: conformPasswordController,
                  );
                },
              ),
              const Gap(30),
              CustomButton(
                text: 'Submit',
                onTap: () async {
                  if (oldPasswordController.text.isEmpty) {
                    customToast(
                      context,
                      text: 'Please enter old password',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (newPasswordController.text.isEmpty) {
                    customToast(
                      context,
                      text: 'Please enter your password',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else if (newPasswordController.text !=
                      conformPasswordController.text) {
                    customToast(
                      context,
                      text: 'Passwords do not match',
                      animatedSnackBarType: AnimatedSnackBarType.error,
                    );
                  } else {
                    Map<String, dynamic> body = {
                      'current_password': oldPasswordController.text.trim(),
                      'new_password': newPasswordController.text.trim(),
                      'new_password_confirmation':
                          conformPasswordController.text.trim(),
                    };
                    authCubit.changePassword(context, body: body);
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
