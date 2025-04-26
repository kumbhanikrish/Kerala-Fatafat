import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/profile/cubit/profile_cubit.dart';
import 'package:kolkata_fatafat/modules/profile/model/user_model.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    User userModel = data['userModel'];

    final TextEditingController nameController = TextEditingController(
      text: userModel.name,
    );
    final TextEditingController numberController = TextEditingController(
      text: userModel.phone,
    );
    final TextEditingController emailController = TextEditingController(
      text: userModel.email,
    );
    final TextEditingController backNameController = TextEditingController(
      text: userModel.bankDetails.bankName,
    );
    final TextEditingController upiIdController = TextEditingController(
      text: userModel.bankDetails.upiId,
    );
    final TextEditingController accountNumberController = TextEditingController(
      text: userModel.bankDetails.accountNumber,
    );
    final TextEditingController IFSCodeController = TextEditingController(
      text: userModel.bankDetails.ifscCode,
    );
    final TextEditingController accountHolderNameController =
        TextEditingController(text: userModel.bankDetails.accountHolderName);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextField(hintText: 'Name', controller: nameController),
              const Gap(10),

              CustomTextField(hintText: 'Email', controller: emailController),
              const Gap(10),
              CustomTextField(hintText: 'Number', controller: numberController),
              const Gap(20),
              CustomText(text: 'UPI ID'),
              const Gap(10),
              CustomTextField(hintText: 'ID', controller: upiIdController),

              const Gap(20),
              CustomText(text: 'Back Detail'),
              const Gap(10),
              CustomTextField(
                hintText: 'Bank Name',
                controller: backNameController,
              ),
              const Gap(10),
              CustomTextField(
                hintText: 'Account Number',
                controller: accountNumberController,
              ),
              const Gap(10),
              CustomTextField(
                hintText: 'IFSC Code',
                controller: IFSCodeController,
              ),
              const Gap(10),
              CustomTextField(
                hintText: 'Account Holder Name',
                controller: accountHolderNameController,
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            text: 'Submit',
            onTap: () {
              Map<String, dynamic> body = {
                'name': nameController.text.trim(),
                'email': emailController.text.trim(),
                'phone': numberController.text.trim(),
                'bank_name': backNameController.text.trim(),
                'account_number': accountNumberController.text.trim(),
                'ifsc_code': IFSCodeController.text.trim(),
                'account_holder_name': accountHolderNameController.text.trim(),
                'upi': upiIdController.text.trim(),
              };
              profileCubit.profile(context, body: body);
            },
          ),
        ],
      ),
    );
  }
}
