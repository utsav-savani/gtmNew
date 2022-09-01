import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class CloseButtonWidget extends StatelessWidget {
  final int? index;
  final VoidCallback onTap;

  const CloseButtonWidget({
    this.index,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 20,
          height: 20,
          child: svgToIcon(appImagesName: AppImages.closeIcon),
        ),
      ),
    );
  }
}
