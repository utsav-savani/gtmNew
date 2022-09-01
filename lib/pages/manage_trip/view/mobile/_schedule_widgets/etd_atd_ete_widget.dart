import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleETDATDETEWidget extends StatelessWidget {
  final int sequence;
  final bool isEditableMode;
  final TripSchedulePrePayload payload;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  final bool isLastSequence;
  final bool? isMobile;
  const TripScheduleETDATDETEWidget({
    Key? key,
    required this.sequence,
    required this.isEditableMode,
    required this.payload,
    required this.repo,
    required this.updateWidgetHandler,
    required this.isLastSequence,
    this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isMobile = isMobile ?? false;
    double _dateWidth = spacing200;
    if (_isMobile) _dateWidth = spacing180;
    double _eteWidth = spacing78;
    if (_isMobile) _eteWidth = spacing68;
    final MaskTextInputFormatter _eteTimeMaskFormatter =
        MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
    int actualIndex = sequence - 1;
    String? etd = payload.etd();
    if (etd != null) {
      etd = convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
        etd,
        isUTC: true,
      );
    }
    etd ??= "";
    String _label = "ETD";
    String? _isATDTime;
    String? _fieldValue = etd;
    String? _fieldValueUTC;
    if (payload.etdLocal() != null) {
      _fieldValueUTC = etd;
      _fieldValue = convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
        payload.etdLocal(),
        isUTC: false,
      );
    }
    if (payload.aTDTime() != null) {
      _isATDTime = payload.aTDTime();
      _label = "ATD";
      if (_isATDTime != null) {
        _fieldValue = convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
          _isATDTime,
          isUTC: true,
        );
      }
    }
    bool _isETEDisabled = payload.isETDTBA() ?? false;

    String? _etee = payload.ete() ?? "";
    if (!isEditableMode || isLastSequence) {
      _etee == "";
      _isETEDisabled = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    appText(_label),
                    width(4),
                    if (_label == "ETD")
                      InkWell(
                        onTap: () {
                          if (isEditableMode) {
                            repo.setETDToATD(index: actualIndex);
                            updateWidgetHandler();
                          }
                        },
                        child: svgToIcon(
                          appImagesName: AppImages.infoIcon,
                        ),
                      ),
                    width(100),
                    if (_isATDTime != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          label("ETD"),
                          width(8),
                          label(etd, color: AppColors.charcoalGrey),
                          InkWell(
                            onTap: () {
                              if (isEditableMode) {
                                repo.setATDToETD(index: actualIndex);
                                updateWidgetHandler();
                              }
                            },
                            child: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                  ],
                ),
                height(4),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: _dateWidth),
                  child: TextFormField(
                    controller: TextEditingController()..text = _fieldValue,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        color: AppColors.lightGreyBlue,
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      border: const OutlineInputBorder(),
                      hintText: 'mm/dd/yyyy HH:mm',
                      labelText: '',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 4,
                        ),
                        child: SvgPicture.asset(AppImages.calendarIcon),
                      ),
                    ),
                    onTap: () async {
                      if (!isEditableMode) return;
                      if (payload.isETDTBA()) return;
                      String? _etdd = payload.etd();
                      if (payload.aTDTime() != null) {
                        _etdd = payload.aTDTime();
                      }
                      if (_etdd == null) {
                        DateTime? etdAddOneHour =
                            await repo.getInitialDateForETD(index: actualIndex);
                        if (etdAddOneHour != null) {
                          _etdd = etdAddOneHour.toString();
                        }
                      }
                      final DateTime initialDateTime = _etdd != null
                          ? DateTime.parse(_etdd)
                          : DateTime.now();
                      final int hour =
                          _etdd != null ? DateTime.parse(_etdd).hour : 0;
                      final int minute =
                          _etdd != null ? DateTime.parse(_etdd).minute : 0;
                      var date = await AppHelper().pickDateTime(
                        context,
                        use24Hr: true,
                        initialDate: initialDateTime,
                        initialTime: TimeOfDay(
                          hour: hour,
                          minute: minute,
                        ),
                      );
                      if (isEditableMode) {
                        repo.setETD(index: actualIndex, etd: date.toString());
                      }
                      updateWidgetHandler();
                    },
                  ),
                ),
                label("$_fieldValueUTC"),
              ],
            ),
            width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                label("ETE"),
                height(4),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: _eteWidth),
                  child: CustomTextFormField(
                    isEditableMode: _isETEDisabled,
                    focusNode:
                        _isETEDisabled ? AlwaysDisabledFocusNode() : null,
                    label: "",
                    hintText: "hh:mm",
                    value: _etee,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: <TextInputFormatter>[
                      _eteTimeMaskFormatter
                    ],
                    onChanged: (value) => _setETEChangedHandler(
                      actualIndex,
                      value,
                    ),
                  ),
                ),
                const Text(""),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _setETEChangedHandler(index, value) {
    if (isEditableMode && value.length == 5) {
      repo.setETE(index: index, ete: value);
      _updatePayload();
    }
  }

  void _updatePayload() {
    updateWidgetHandler();
  }
}
