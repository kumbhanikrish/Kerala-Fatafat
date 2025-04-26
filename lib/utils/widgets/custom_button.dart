import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  final Color? textColor;
  final Color? borderColor;
  final void Function() onTap;
  final EdgeInsetsGeometry? padding;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBorder(
      borderSize: 1,
      glowSize: 5,
      gradientColors: [
        AppColor.themePrimaryColor,
        AppColor.themePrimaryColor,
        AppColor.themePrimaryColor,
        AppColor.themePrimaryColor,
      ],
      // animationProgress: currentProgress,
      borderRadius: BorderRadius.circular(30),

      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColor.themePrimaryColor,
          border: Border.all(
            color: borderColor ?? AppColor.themePrimaryColor,
            width: 1,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(30),
        ),
        child: InkWell(
          splashColor: AppColor.borderColor,
          highlightColor: AppColor.borderColor,
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
            child: Center(
              child: CustomText(
                text: text,
                color: textColor ?? AppColor.backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final void Function() onPressed;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontSize = 14,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
        text: text,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final Color? color;
  final double? size;
  const CustomIconButton({
    super.key,
    required this.icon,
    this.color,
    required this.onPressed,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color ?? AppColor.blackColor,
      onPressed: onPressed,
      icon: Icon(icon, size: size),
    );
  }
}
