import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class DataTableText extends StatelessWidget {
  const DataTableText({Key? key, required this.valueText}) : super(key: key);

  final String valueText;
  final double? textSizeDefault = spacing14;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Padding(
          padding: const EdgeInsets.all(spacing6),
          child: Text(
            valueText,
            // style: TextStyle(fontSize: textSizeDefault),
          ),
        ));
  }
}
