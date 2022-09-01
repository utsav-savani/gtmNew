import 'package:flutter/material.dart';
import 'package:gtm/enums/device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQueryData){
   double deviceWidth = mediaQueryData.size.shortestSide;

   if(deviceWidth > 900){
       return DeviceScreenType.desktop;
   }

   if(deviceWidth > 600){
       return DeviceScreenType.tablet;
   }

   return DeviceScreenType.mobile;

}