import 'package:flutter/material.dart';
import 'package:gtm/responsive/sizing_information.dart';
import 'package:gtm/utils/ui_utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, SizingInformation sizingInformation) builder;

  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      SizingInformation sizingInformation = SizingInformation(
        deviceScreenType: getDeviceType(mediaQueryData),
        screenSize: mediaQueryData.size,
        localWidgetSize: Size(constraints.maxWidth,constraints.maxHeight)
      );
      return builder(context, sizingInformation);
    },);
  }
}
