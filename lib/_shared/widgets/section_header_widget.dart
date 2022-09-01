import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class SectionHeaderWidget extends StatelessWidget {
  final Widget child;
  final Padding? padding;
  const SectionHeaderWidget({Key? key, required this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.defaultColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            color: AppColors.blueGrey,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: padding ??
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: child,
          ),
    );
  }
}
