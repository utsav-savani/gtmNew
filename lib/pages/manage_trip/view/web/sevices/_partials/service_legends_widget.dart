import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class TripServiceLegends extends StatelessWidget {
  const TripServiceLegends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildLegendWidget(text: "Recommended", color: AppColors.turquoiseBlue),
        width(24),
        _buildLegendWidget(
          text: "New",
          color: AppColors.coolBlue,
        ),
        width(24),
        _buildLegendWidget(text: "In-Progress", color: AppColors.apricot),
        width(24),
        _buildLegendWidget(text: "Confirmed", color: AppColors.jadeGreen),
        // width(24),
        // _buildLegendWidget(text: "Canceled", color: AppColors.redColor),
        width(12),
      ],
    );
  }

  Widget _buildLegendWidget({required String text, required Color color}) {
    return Row(
      children: [
        Container(
          width: spacing20,
          height: spacing20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(spacing12),
          ),
        ),
        width(6),
        appText(text, color: color),
      ],
    );
  }
}
