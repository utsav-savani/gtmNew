import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppAlert {
  static show(
    context, {
    required String body,
    String? title,
    String? buttonText,
    VoidCallback? buttonTextCallback,
    String? extraButtonText,
    VoidCallback? extraButtonTextCallback,
  }) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title ?? "Error Occured"),
      content: Text(body),
      actions: <Widget>[
        if (extraButtonText != null)
          CupertinoDialogAction(
            child: Text(extraButtonText),
            onPressed: () {
              Navigator.pop(context);
              if (extraButtonTextCallback != null) extraButtonTextCallback();
            },
          ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(buttonText ?? "Okay"),
          onPressed: () {
            Navigator.pop(context);
            if (buttonTextCallback != null) buttonTextCallback();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
