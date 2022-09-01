import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';

class GTMSquareLogoWidget extends StatelessWidget {
  const GTMSquareLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.gtmLogoSquareImage,
      fit: BoxFit.fitHeight,
    );
  }
}
