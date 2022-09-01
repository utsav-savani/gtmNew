import 'package:flutter/material.dart';
import 'package:gtm/theme/app_colors.dart';

scafoldErrorMessage(message, context) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

scafoldSuccessMessage(message, context) {
  final snackBar = SnackBar(
    backgroundColor: AppColors.greenish,
    content: Text(message),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
