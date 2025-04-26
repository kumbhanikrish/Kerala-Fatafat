import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final Color? tileColor;
  final String leadingImage;
  final void Function()? onTap;
  final Color? leadingColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? trailing;
  final Color? textColor;
  final FontWeight? fontWeight;
  final Widget? subtitle;
  final double? fontSize;
  final double? height;
  const CustomListTile({
    super.key,
    required this.text,
    required this.leadingImage,
    this.onTap,
    this.subtitle,
    this.contentPadding,
    this.height,
    this.leadingColor,
    this.trailing,
    this.tileColor,
    this.textColor,
    this.fontWeight,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColor.borderColor,
      highlightColor: AppColor.borderColor,
      borderRadius: BorderRadius.circular(12),

      child: ListTile(
        tileColor: tileColor,
        contentPadding: contentPadding ?? EdgeInsets.zero,
        leading:
            leadingImage.isEmpty
                ? null
                : SvgPicture.asset(
                  leadingImage,
                  color: leadingColor ?? AppColor.themePrimary2Color,
                  height: height ?? 20,
                ),
        trailing:
            trailing ??
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: AppColor.themePrimaryColor,
            ),
        title: CustomText(
          text: text,
          fontSize: fontSize ?? 14,
          color: textColor ?? AppColor.themePrimary2Color,

          fontWeight: fontWeight ?? FontWeight.w400,
        ),
        subtitle: subtitle,
      ),
    );
  }
}
