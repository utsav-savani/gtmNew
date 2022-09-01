import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? buttonColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final Color? textColor;
  final String buttonText;
  final Color? borderColor;
  const AppButton({
    required this.buttonText,
    required this.onTap,
    this.textColor,
    this.buttonColor,
    this.borderRadius,
    this.borderColor,
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: height ?? 48,
      width: width ?? 224,
      decoration: BoxDecoration(
        color: buttonColor ?? AppColors.defaultColor,
        borderRadius: BorderRadius.circular(
          borderRadius ?? buttonsCornerSize,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: appText(
            buttonText,
            color: textColor ?? AppColors.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
