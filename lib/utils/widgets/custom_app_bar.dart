import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? fontSize;
  final bool? centerTitle;
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.fontSize,
    this.centerTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.borderColor, // white shadow with some transparency
            offset: Offset(0, -1), // upward shadow
            blurRadius: 80,
            spreadRadius: 10,
          ),
        ],
        border: Border(
          bottom: BorderSide(width: 0.1, color: AppColor.whiteColor),
        ),
      ),
      child: AppBar(
        title: CustomText(
          text: title,
          color: AppColor.themePrimary2Color,
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? 18,
        ),
        bottom: bottom,
        leading: leading,
        actions: actions,
        automaticallyImplyLeading: true,
        centerTitle: centerTitle ?? true,
        iconTheme: IconThemeData(color: AppColor.themePrimary2Color),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? fontSize;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? textColor;
  const CustomAppBar2({
    super.key,
    required this.title,
    this.leading,
    this.textColor,
    this.actions,
    this.bottom,
    this.fontSize,
    this.backgroundColor,
    this.centerTitle,
  });
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(100, 1000),
      child: AppBar(
        backgroundColor: backgroundColor,
        title: CustomText(
          text: title,
          color: textColor ?? AppColor.themePrimary2Color,
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? 18,
        ),
        bottom: bottom,
        leading: leading,
        actions: actions,
        automaticallyImplyLeading: true,
        centerTitle: centerTitle ?? true,
        iconTheme: IconThemeData(color: AppColor.themePrimary2Color),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
