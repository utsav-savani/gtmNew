import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtm/_shared/constants/string_constants.dart';
import 'package:gtm/_shared/extensions/string_extension.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:jiffy/jiffy.dart';
export 'package:gtm/theme/app_colors.dart';
export 'package:gtm/_shared/utils/app_images.dart';
import 'package:intl/intl.dart';
import 'package:timezone/browser.dart' as tz;

SizedBox height(double height) {
  return SizedBox(height: height);
}

SizedBox width(double width) {
  return SizedBox(width: width);
}

String today() {
  return Jiffy().format("yyyy-MM-dd");
}

String yesterday() {
  return Jiffy().subtract(days: 1).format("yyyy-MM-dd");
}

String next7Days() {
  return Jiffy().add(days: 7).format("yyyy-MM-dd");
}

String next30Days() {
  return Jiffy().add(days: 30).format("yyyy-MM-dd");
}

String currentMonthStartDate() {
  return Jiffy().startOf(Units.MONTH).format("yyyy-MM-dd");
}

String currentMonthEndDate() {
  return Jiffy().endOf(Units.MONTH).format("yyyy-MM-dd");
}

String previousMonthStartDate() {
  return Jiffy().subtract(months: 1).startOf(Units.MONTH).format("yyyy-MM-dd");
}

String previousMonthEndDate() {
  return Jiffy().subtract(months: 1).endOf(Units.MONTH).format("yyyy-MM-dd");
}

String systemDefinedFormat(DateTime date) {
  return Jiffy(date).format("yyyy-MM-dd");
}

String getDateTimeUsingTimezone({
  required String timezone,
  required String date,
}) {
  return "";
}

String timezoneToLocalTime({required DateTime time, required String timezone}) {
  var qdetroit = tz.getLocation(timezone);
  return tz.TZDateTime.from(time, qdetroit).toString();
}

String convertDateYYYYMMDDStringToHumanReadableFormat(
  String date, {
  bool? isUTC,
}) {
  if (date == "Invalid date" || date == "null") return "";
  var inputFormat = DateFormat('yyyy-MM-dd');
  var date1 = inputFormat.parse(date);

  var outputFormat = DateFormat('yyyy-MM-dd');
  var date2 = outputFormat.format(date1);
  var res = Jiffy(date2).format("MMM dd yyyy");
  String _utc = "";
  if (isUTC != null) {
    _utc = isUTC ? "Z" : "L";
  }
  return "$res $_utc";
}

String convertDateStringToHumanReadableFormat(
  String date, {
  bool? isUTC,
}) {
  if (date == "Invalid date" || date == "null" || date.isEmpty) return "";
  var inputFormat = DateFormat('dd/MM/yyyy');
  var date1 = inputFormat.parse(date);

  var outputFormat = DateFormat('yyyy-MM-dd');
  var date2 = outputFormat.format(date1);
  var res = Jiffy(date2).format("MMM dd yyyy");
  String _utc = "";
  if (isUTC != null) {
    _utc = isUTC ? "Z" : "L";
  }
  return "$res $_utc";
}

String convertDateToHumanReadableFormat(DateTime date) {
  return Jiffy(date).format("MMM dd yyyy");
}

String convertDateYYYYMMDDToHumanReadableFormat(String date) {
  if (date == "Invalid date" || date == "null" || date.isEmpty) return "";
  var inputFormat = DateFormat('yyyy-MM-dd');
  var date1 = inputFormat.parse(date);
  return Jiffy(date1).format("MMM dd yyyy");
}

//HH:MM dd-MMM-yyyy
String convertDateTimeStringToHumanReadableFormat(
  String date, {
  bool? isUTC,
}) {
  if (date == "Invalid date" || date == "null") return "";
  var inputFormat = DateFormat('HH:MM dd-MMM-yyyy');
  var date1 = inputFormat.parse(date);

  var outputFormat = DateFormat('yyyy-MM-dd HH:MM');
  var date2 = outputFormat.format(date1);
  var res = Jiffy(date2).format("MMM dd yyyy HH:MM");
  String _utc = "";
  if (isUTC != null) {
    _utc = isUTC ? "Z" : "L";
  }
  return "$res $_utc";
}

//2022-12-12 01:00:00"
String convertDateTimeYYYYMMDDHHMMStringToHumanReadableFormat(
  String date, {
  bool? isUTC,
}) {
  if (date == "Invalid date" || date == "null" || date.isEmpty) return "";
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  var date1 = inputFormat.parse(date);

  var outputFormat = DateFormat('yyyy-MM-dd HH:mm');
  var date2 = outputFormat.format(date1);
  var res = Jiffy(date2).format("MMM dd yyyy HH:mm");
  String _utc = "";
  if (isUTC != null) {
    _utc = isUTC ? "Z" : "L";
  }
  return "$res $_utc";
}

//2022-12-12 01:00:00"
String convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
  String date, {
  bool isUTC = false,
  String? timezone,
}) {
  if (date == "Invalid date" || date == "null" || date.isEmpty) return "";
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  var date1 = inputFormat.parse(date);

  if (timezone != null && !isUTC) {
    date1 = convertUTCToLocalUsingTimezone(date, timezone: timezone);
  }

  var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  var date2 = outputFormat.format(date1);
  var res = Jiffy(date2).format("MMM dd yyyy HH:mm");
  String _utc = "";
  _utc = isUTC ? "Z" : "L";
  return "$res $_utc";
}

String convertDateTimeToHumanReadableFormat(String date) {
  if (date.isEmpty || date == 'null') return '';
  return Jiffy(date).format("MMM dd yyyy HH:MM");
}

String convertYYMMDDToDDMMYYYYFormat(String date) {
  return Jiffy(date).format("dd/MM/yyyy HH:MM");
}

String convertYYMMDDToMMDDYYYYFormat(String date) {
  return Jiffy(date).format("MM/dd/yyyy HH:MM");
}

DateTime convertUTCToLocalUsingTimezone(String utcTime, {String? timezone}) {
  if (timezone != null) {
    var qdetroit = tz.getLocation(timezone);
    var parsedDate = DateTime.parse(utcTime + 'Z');
    return tz.TZDateTime.from(parsedDate, qdetroit);
  } else {
    DateTime dateTime = DateTime.parse(utcTime);
    return dateTime.add(DateTime.parse(utcTime).timeZoneOffset);
  }
}

Text label(
  String str, {
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  if (str == "null" || str == "") {
    return const Text("");
  }
  return Text(
    str,
    style: TextStyle(
      color: color ?? AppColors.blueGrey,
      fontSize: fontSize ?? 13,
      fontWeight: fontWeight,
    ),
  );
}

Text text(str, {TextStyle? textStyle}) {
  return Text(
    translate(str),
    style: textStyle,
  );
}

Text appText(
  str, {
  TextStyle? textStyle,
  fontSize,
  color,
  fontWeight,
  textAlign,
  overflow,
}) {
  return Text(
    str, //MARK: as soon as we are ready to translate, start integrate here, it will take effect in all places translate(str)
    textAlign: textAlign ?? TextAlign.left,
    overflow: overflow ?? TextOverflow.ellipsis,
    style: textStyle ??
        TextStyle(
          fontSize: fontSize != null ? fontSize.toDouble() : 14,
          color: color ?? AppColors.blueGrey,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
  );
}

Text textValue(value, {TextStyle? textStyle, fontSize, color, fontFamily}) {
  return Text(
    value,
    style: textStyle ??
        TextStyle(
          fontSize: fontSize ?? 14,
          color: color ?? AppColors.blueGrey,
          fontFamily: fontFamily ?? GoogleFonts.lato().fontFamily,
        ),
  );
}

String arrayToCommaSeperated({required List<dynamic> arr}) {
  return arr.join(", ");
}

String translate(str) {
  return str.toString().translate();
}

String toCamleCase(String? str) {
  if (str != null) {
    return str[0].toUpperCase() + str.substring(1).toLowerCase();
  } else {
    return '';
  }
}

Widget loadingWidget({Color? color}) {
  return Center(
    child: CircularProgressIndicator(
      color: color ?? AppColors.defaultColor,
    ),
  );
}

Widget errorWidget() {
  return const Center(
    child: Text(' Error Occurred'),
  );
}

Widget emptyStateWidget({String? text}) {
  return Center(child: Text(text ?? 'No Data found'));
}

Widget noDataFoundWidget({String? text}) {
  return Center(child: Text(text ?? 'No Data found'));
}

Color colorFromTripStatus(String? tripStatus) {
  switch (tripStatus?.toLowerCase()) {
    case 'draft':
      return AppColors.draft;
    case 'inprogress':
      return AppColors.inProgress;
    case 'completed':
    case 'confirmed':
      return AppColors.completd;
    case 'cancelled':
      return AppColors.cancelled;
    case 'total':
      return AppColors.total;
    default:
      return AppColors.whiteColor;
  }
}

Color getStatusColor(String text) {
  switch (text.toUpperCase()) {
    case DRAFT:
      return AppColors.draft;
    case INPROGRESS:
      return AppColors.inProgress;
    case COMPLETED:
      return AppColors.jadeGreen;
    case CANCELLED:
      return AppColors.cancelled;
    case NEW:
      return AppColors.coolBlue;
    case OPEN:
    case PFB:
      return AppColors.open;
    case CLOSED:
      return AppColors.closed;
    default:
      return AppColors.total;
  }
}

SvgPicture svgToIcon({
  required String appImagesName,
  Color? color,
  double? height,
  double? width,
}) {
  return SvgPicture.asset(
    appImagesName,
    color: color,
    width: width ?? 16,
    height: height ?? 16,
  );
}

Widget underLineText({required Widget child, Color? color}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 2),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: color ?? AppColors.deepSkyBlue,
          width: 1.0,
        ),
      ),
    ),
    child: child,
  );
}

BoxDecoration drodownDecoration() {
  return BoxDecoration(
    border: Border.all(color: AppColors.powderBlue),
    borderRadius: BorderRadius.circular(12),
  );
}

typedef StringCallback = void Function(String val);
typedef BoolCallback = void Function(bool val);
typedef IntCallback = void Function(int val);
