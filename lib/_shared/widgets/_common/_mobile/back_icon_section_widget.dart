import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';

class BackIconSectionWidget extends StatelessWidget {
  const BackIconSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: svgToIcon(
          appImagesName: AppImages.backIcon,
          width: 22,
          height: 22,
        ),
      ),
    );
  }
}
