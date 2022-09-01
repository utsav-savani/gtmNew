import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';

class AppHelper {
  static final AppHelper _appHelper = AppHelper._internal();

  factory AppHelper() {
    return _appHelper;
  }

  AppHelper._internal();

  num convertKgToLbs(num kg) => kg * 2.205;
  num convertLbsToKg(num lbs) => lbs / 2.205;

  void showSnackBar(
    BuildContext context, {
    String? message,
    SnackBarAction? snackBarAction,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      CustomWidgets().buildSnackBar(
        context,
        message: message ?? '',
        snackBarAction: snackBarAction,
      ),
    );
  }

  Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
  }) async {
    return await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      initialDate: initialDate ?? DateTime.now(),
    );
  }

  Future<TimeOfDay?> pickTime(BuildContext context,
      {TimeOfDay? initialTime, bool use24Hr = false}) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: use24Hr),
          child: child ?? Container(),
        );
      },
    );
  }

  Future<DateTime?> pickDateTime(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    TimeOfDay? initialTime,
    bool use24Hr = false,
  }) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      initialDate: initialDate ?? DateTime.now(),
    );
    TimeOfDay? time;
    if (date != null) {
      time = await pickTime(
        context,
        initialTime: initialTime ?? TimeOfDay.now(),
        use24Hr: use24Hr,
      );
    }
    if (date != null && time != null) {
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }
    return initialDate;
  }

  void showDateRangePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 280,
            width: 512,
            child: CustomWidgets().buildDataRangePicker(),
          ),
        );
      },
    );
  }

  Future<bool> isUserLoggedIn() async {
    AuthenticationRepository authRepo = AuthenticationRepository();
    return authRepo.isUserLoggedIn();
  }

  Future<String> getAccessToken() async {
    AuthenticationRepository authRepo = AuthenticationRepository();
    return authRepo.getAccessToken();
  }
}
