import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class RowStrippedWidget extends StatelessWidget {
  final String title;
  final String? details;
  final bool? isLight;
  final double? widthLabel;
  const RowStrippedWidget({
    Key? key,
    required this.title,
    this.details,
    this.isLight,
    this.widthLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _color = AppColors.whiteColor;
    if (isLight != null) _color = AppColors.lightBlue;
    return Container(
      color: _color,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            width: widthLabel ?? MediaQuery.of(context).size.width * 0.2,
            child: label(title),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("$details"),
            ),
          ),
        ],
      ),
    );
  }
}
