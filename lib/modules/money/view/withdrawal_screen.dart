import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/money/cubit/money_cubit.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MoneyCubit moneyCubit = BlocProvider.of<MoneyCubit>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            CustomTextField(
              hintText: 'Amount Rs.',
              controller: amountController,
              maxLength: 5,

              keyboardType: TextInputType.number,
            ),
            Gap(30),
            CustomButton(
              text: 'Withdrawal',
              onTap: () async {
                if (amountController.text.isEmpty) {
                  customToast(
                    context,
                    text: 'Please enter withdrawal amount',
                    animatedSnackBarType: AnimatedSnackBarType.error,
                  );
                } else if (int.parse(amountController.text) < 100) {
                  customToast(
                    context,
                    text: 'Maximum withdrawal amount is ₹100',
                    animatedSnackBarType: AnimatedSnackBarType.error,
                  );
                } else {
                  Map<String, dynamic> body = {
                    'type': 'withdrawal',
                    'amount': amountController.text.trim(),
                  };
                  await moneyCubit.manageWallet(context, body: body);

                  amountController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
