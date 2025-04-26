import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/profile/model/user_model.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';

class BankDetailScreen extends StatelessWidget {
  final dynamic data;
  const BankDetailScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    BankDetails bankDetails = data['bankDetails'];

    final TextEditingController backNameController = TextEditingController(
      text: bankDetails.bankName,
    );
    final TextEditingController accountNumberController = TextEditingController(
      text: bankDetails.accountNumber,
    );
    final TextEditingController IFSCodeController = TextEditingController(
      text: bankDetails.ifscCode,
    );
    final TextEditingController accountHolderNameController =
        TextEditingController(text: bankDetails.accountHolderName);
    final TextEditingController upiIdController = TextEditingController(
      text: bankDetails.upiId,
    );
    return Scaffold(
      appBar: CustomAppBar(title: 'Bank Details'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            CustomTextField(
              hintText: 'Bank Name',
              readOnly: true,
              text: bankDetails.bankName.isEmpty ? '' : 'Bank Name',

              controller: backNameController,
            ),
            const Gap(10),
            CustomTextField(
              hintText: 'Account Number',
              readOnly: true,
              text: bankDetails.accountNumber.isEmpty ? '' : 'Account Number',

              controller: accountNumberController,
            ),
            const Gap(10),
            CustomTextField(
              hintText: 'IFSC Code',
              readOnly: true,
              text: bankDetails.ifscCode.isEmpty ? '' : 'IFSC Code',

              controller: IFSCodeController,
            ),
            const Gap(10),
            CustomTextField(
              hintText: 'Account Holder Name',
              text:
                  bankDetails.accountHolderName.isEmpty
                      ? ''
                      : 'Account Holder Name',

              readOnly: true,
              controller: accountHolderNameController,
            ),
            const Gap(10),

            CustomTextField(
              hintText: 'UPI ID',
              text: bankDetails.upiId.isEmpty ? '' : 'UPI ID',

              readOnly: true,
              controller: upiIdController,
            ),
          ],
        ),
      ),
    );
  }
}
