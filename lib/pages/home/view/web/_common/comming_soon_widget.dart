import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/utils/app_images.dart';

class ComingSoonWidget extends StatelessWidget {
  final double width;
  final double height;
  const ComingSoonWidget({required this.width, required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AppImages.comingSoonIcon,
        //color: AppColors.greenRaw,
      ),
    );
  }
}
