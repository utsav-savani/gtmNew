import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utilities {
  // if anything to add inside class
}

AppBar basicAppBar(String text) {
  return AppBar(
    elevation: 0,
    title: Text(text),
  );
}

AppBar basicAppBarWithActions({
  required String text,
  List<Widget>? widgets,
}) {
  return AppBar(
    elevation: 0,
    title: Text(text),
    actions: widgets,
  );
}

SizedBox formButton(
  context, {
  required String buttonLabel,
  VoidCallback? onTap,
  Color? color,
}) {
  return SizedBox(
    height: 42,
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(),
      child: Text(buttonLabel),
      onPressed: () => {if (onTap != null) onTap()},
    ),
  );
}

getFlag(String countryCode) {
  try {
    if (countryCode.isEmpty || countryCode == '') return '';
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  } catch (e) {
    return '';
  }
}

// versionNumber prefix
String versionNumberPrefix = "v0.";
String versionNumber = "";
// buildVersionNumber
Future<String> getVersionNumber() async {
  return await rootBundle.loadString('assets/versionNumber.txt');
}
