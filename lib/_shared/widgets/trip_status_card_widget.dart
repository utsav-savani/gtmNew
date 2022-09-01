import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class TripStatusCardWidget extends StatelessWidget {
  final String tripStatuss;
  const TripStatusCardWidget({Key? key, required this.tripStatuss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.lightBlueGrey;
    Color textColor = AppColors.whiteColor;
    if (tripStatuss.toUpperCase() == 'DRAFT') {
      color = AppColors.palePeach;
      textColor = AppColors.charcoalGrey;
    }
    if (tripStatuss.toUpperCase() == 'COMPLETED') {
      color = AppColors.greenish;
    }
    if (tripStatuss.toUpperCase() == 'INPROGRESS') {
      color = AppColors.apricot;
    }
    if (tripStatuss.toUpperCase() == 'CANCELLED') {
      color = AppColors.redColor;
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
        child: Text(
          tripStatuss,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
