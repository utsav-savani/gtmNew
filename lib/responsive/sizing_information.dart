import 'package:flutter/material.dart';
import 'package:gtm/enums/device_screen_type.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size? localWidgetSize;

  SizingInformation({this.deviceScreenType = DeviceScreenType.desktop, this.screenSize = const Size(0, 0), this.localWidgetSize = const Size(0, 0)});
}
