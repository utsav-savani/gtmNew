import 'package:flutter/material.dart';
import 'package:gtm/enums/device_screen_type.dart';
import 'package:gtm/responsive/responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout({Key? key, required this.mobile, required this.tablet, required this.desktop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      switch(sizingInformation.deviceScreenType){
        case DeviceScreenType.mobile:
          return mobile;
        case DeviceScreenType.tablet:
          return tablet;
        case DeviceScreenType.desktop:
          return desktop;
        default:
          return mobile;
      }
    });
  }
}
