import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/helpers/asset_names.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/_shared/widgets/_common/widget_size.dart';
import 'package:gtm/enums/device_screen_type.dart';
import 'package:gtm/utils/ui_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomWidgets {
  static final CustomWidgets _customWidgets = CustomWidgets._internal();

  factory CustomWidgets() {
    return _customWidgets;
  }

  CustomWidgets._internal();

  SnackBar buildSnackBar(BuildContext context,
      {String message = '', SnackBarAction? snackBarAction}) {
    switch (getDeviceType(MediaQuery.of(context))) {
      case DeviceScreenType.mobile:
        return _buildMobileSnackBar(context,
            message: message, snackBarAction: snackBarAction);
      case DeviceScreenType.tablet:
        return _buildWebSnackBar(context,
            message: message, snackBarAction: snackBarAction);
      case DeviceScreenType.desktop:
        return _buildWebSnackBar(context,
            message: message, snackBarAction: snackBarAction);
    }
  }

  Widget buildUTCToLocalSwitch(
      {bool value = false, required ValueChanged<bool> onChanged}) {
    return SizedBox(
      width: spacing128,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("LCL"),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
          const Text("UTC"),
        ],
      ),
    );
  }

  SnackBar _buildMobileSnackBar(BuildContext context,
      {String message = '', SnackBarAction? snackBarAction}) {
    return SnackBar(
      content: Text(message),
      action: snackBarAction,
    );
  }

  SnackBar _buildWebSnackBar(BuildContext context,
      {String message = '', SnackBarAction? snackBarAction}) {
    return SnackBar(
      content: Text(message),
      action: snackBarAction,
      margin: EdgeInsets.only(
          left: 10, bottom: 10, right: MediaQuery.of(context).size.width - 400),
    );
  }

  Widget buildUASLogo() {
    return SvgPicture.asset(Assets.uasLogoSvg);
  }

  Widget buildGTMLogoHorizontal() {
    return Image.asset(Assets.gtmLogoHorizontalPng);
  }

  Widget buildGTMLogoVertical() {
    return Image.asset(Assets.gtmLogoVerticalPng);
  }

  Widget buildGTMWelcomeLogo() {
    return Image.asset(Assets.gtmLogoWelcomePng);
  }

  Widget buildGTMWelcomeLogoSvg(
      {required double width, required double height}) {
    return svgToIcon(
      appImagesName: Assets.gtmLogoWelcomeSvg,
      width: width,
      height: height,
    );
  }

  Widget buildGTMWordLogo() {
    return Image.asset(Assets.gtmWordLogoPng);
  }

  Widget buildRobotHandImage() {
    return Image.asset(Assets.robotHandPng);
  }

  Widget buildHorizontalLine({double? height, Color? color}) {
    return Container(
      height: height,
      color: color,
    );
  }

  Widget buildConstrainedTextFormField(TextFormField textField,
      {double maxWidth = 280}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: textField,
    );
  }

  Widget buildConstrainedTextField(TextField textField,
      {double maxWidth = 280}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: textField,
    );
  }

  Widget buildDataRangePicker() {
    return SfDateRangePicker(
      selectionMode: DateRangePickerSelectionMode.range,
      enableMultiView: true,
      viewSpacing: 20,
      showActionButtons: true,
      selectionShape: DateRangePickerSelectionShape.rectangle,
      headerStyle: const DateRangePickerHeaderStyle(
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget buildDropdown<T>({
    String label = '',
    String hint = '',
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    T? value,
    bool selectFirstValue = false,
    FormFieldValidator<T>? validator,
    double? maxWidth = 280,
    bool enabled = true,
  }) {
    T? _currentSelectedValue = value;
    if (selectFirstValue) {
      if (value == null) {
        if (items.isNotEmpty) {
          _currentSelectedValue = items.first.value;
        }
      }
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? double.infinity,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return FormField<T>(
            validator: validator,
            builder: (FormFieldState<T> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                ),
                isEmpty: _currentSelectedValue == null,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    isExpanded: true,
                    value: _currentSelectedValue,
                    isDense: true,
                    onChanged: enabled
                        ? (val) {
                            setState(() {
                              _currentSelectedValue = val;
                            });
                            onChanged(val);
                          }
                        : null,
                    items: items,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildDropdownSelector<T>({
    String label = '',
    String hint = '',
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    T? value,
    bool selectFirstValue = false,
    FormFieldValidator<T>? validator,
    double? maxWidth = 280,
    bool enabled = true,
  }) {
    T? _currentSelectedValue = value;
    if (selectFirstValue) {
      if (value == null) {
        if (items.isNotEmpty) {
          _currentSelectedValue = items.first.value;
        }
      }
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? double.infinity,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return FormField<T>(
            validator: validator,
            builder: (FormFieldState<T> state) {
              return InputDecorator(
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                  label: Text(label),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: hint,
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                isEmpty: _currentSelectedValue == null,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    isExpanded: true,
                    value: _currentSelectedValue,
                    isDense: true,
                    onChanged: enabled
                        ? (val) {
                            setState(() {
                              _currentSelectedValue = val;
                            });
                            onChanged(val);
                          }
                        : null,
                    items: items,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildCircularProgress() {
    return const CircularProgressIndicator();
  }

  Widget buildCircularProgressSmall({Color color = Colors.white}) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(color: color),
    );
  }
}
