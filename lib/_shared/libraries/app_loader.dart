import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';

class AppLoader {
  final BuildContext context;
  AppLoader(this.context);

  show({required String title}) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const CircularProgressIndicator(),
              width(12),
              Text(title),
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  hide() {
    Navigator.pop(context);
  }
}
