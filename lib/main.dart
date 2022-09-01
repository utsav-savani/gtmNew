import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gtm/bootstrap.dart';
import 'package:gtm/http_override.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown
  ]);

  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  bootstrap();
  // DO NOT USE IN PRODUCTION
  HttpOverrides.global = MyHttpOverrides();
}
