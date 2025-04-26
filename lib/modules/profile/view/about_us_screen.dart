import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About Us'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "KERALA FATAFAT",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.themePrimaryColor,
            ),
            Gap(20),
            CustomText(text: "📍 Reg. Address", fontWeight: FontWeight.bold),
            Gap(10),
            CustomTextField(
              hintText: 'Unichira, Edappally, Ernakulam, Kerala Pin - 682024',
              readOnly: true,
              fillColor: AppColor.borderColor,
              line: 2,
            ),
            Gap(20),
            CustomText(text: "📞 Contact Person", fontWeight: FontWeight.bold),
            Gap(10),
            CustomTextField(
              hintText: 'Mr. Thasreef.P',
              readOnly: true,
              fillColor: AppColor.borderColor,
            ),
          ],
        ),
      ),
    );
  }
}
