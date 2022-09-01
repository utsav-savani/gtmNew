import 'package:easy_localization/easy_localization.dart';

extension AppString on String {
  String translate() => this.tr();

  String capitalize() =>
      length > 0 ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}" : "";

  String camelCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}
