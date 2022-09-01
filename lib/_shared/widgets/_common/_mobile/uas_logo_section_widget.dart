import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UASLogoSectionWidget extends StatefulWidget {
  final Color? color;
  const UASLogoSectionWidget({Key? key, this.color}) : super(key: key);

  @override
  State<UASLogoSectionWidget> createState() => _UASLogoSectionWidgetState();
}

class _UASLogoSectionWidgetState extends State<UASLogoSectionWidget> {
  String? _version;
  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        svgToIcon(
          appImagesName: AppImages.uasLogoIcon,
          width: 82,
          height: 32,
          color: widget.color ?? AppColors.brownGrey,
        ),
        height(12),
        appText(
          "$_version",
          textStyle: TextStyle(
            color: widget.color ?? AppColors.brownGrey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
