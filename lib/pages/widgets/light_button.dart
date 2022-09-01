import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class LightButton extends StatelessWidget {
  final String buttonText;
  final double buttonHeight;
  final double buttonWidth;
  final bool isLight;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback onPressed;
  const LightButton(
      {Key? key,
      required this.buttonText,
      required this.buttonHeight,
      required this.buttonWidth,
      required this.isLight,
      this.buttonColor,
      this.textColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => onPressed(),
          child: Text(
            buttonText,
            style: TextStyle(
                color: isLight
                    ? textColor ?? AppColors.defaultColor
                    : Colors.white),
          ),
          style: isLight
              ? ElevatedButton.styleFrom(
                  primary: buttonColor ?? Colors.white,
                  fixedSize: Size(buttonWidth, buttonHeight),
                )
              : ElevatedButton.styleFrom(
                  fixedSize: Size(buttonWidth, buttonHeight),
                ),
        ),
      ),
    );
  }
}
