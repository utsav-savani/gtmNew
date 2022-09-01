import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleETAATAEGTWidget extends StatelessWidget {
  final int sequence;
  final bool isEditableMode;
  final TripSchedulePrePayload payload;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  final bool isLastSequence;
  final bool? isMobile;
  const TripScheduleETAATAEGTWidget({
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
    double _egtWidth = spacing78;
    if (_isMobile) _egtWidth = spacing78;
    final MaskTextInputFormatter _etgTimeMaskFormatter = MaskTextInputFormatter(
        mask: '####:##', filter: {"#": RegExp(r'[0-9]')});
    int actualIndex = sequence - 1;
    String? eta = payload.eta();
    if (eta != null) {
      eta = convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
        eta,
        isUTC: true,
      );
    }
    eta ??= "";
    String _label = "ETA";
    String? _isATATime;
    String? _fieldValue = eta;
    if (payload.aTATime() != null) {
      _label = "ATA";
      _isATATime = payload.aTATime();
      if (_isATATime != null) {
        _fieldValue = convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
          _isATATime,
          isUTC: true,
        );
      }
    }
    String? _fieldValueUTC;
    if (payload.etaLocal() != null) {
      _fieldValueUTC = eta;
      _fieldValue = convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
        payload.etaLocal(),
        isUTC: false,
      );
    }
    bool _isEGTDisabled = payload.isETATBA() ?? false;
    if (!isEditableMode) _isEGTDisabled = true;

    bool _split = payload.split() ?? false;
    if (_split) _isEGTDisabled = true;
    if (isLastSequence) _isEGTDisabled = true;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                appText(_label),
                width(4),
                if (_label == "ETA")
                  InkWell(
                    onTap: () => _setETAToATA(actualIndex),
                    child: svgToIcon(appImagesName: AppImages.infoIcon),
                  ),
                width(60),
                if (_isATATime != null && _isATATime != "null")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      label("ETA"),
                      width(8),
                      label(eta, color: AppColors.charcoalGrey),
                      InkWell(
                        onTap: () => _setATAToETA(actualIndex),
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
                readOnly: true,
                controller: TextEditingController()..text = _fieldValue,
                enableInteractiveSelection: _split,
                focusNode: _split || !isEditableMode
                    ? AlwaysDisabledFocusNode()
                    : null,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: AppColors.lightGreyBlue,
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  border: const OutlineInputBorder(),
                  hintText: 'dd/mm/yyyy',
                  labelText: '',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 2,
                    ),
                    child: SvgPicture.asset(AppImages.calendarIcon),
                  ),
                ),
                onTap: () async {
                  if (payload.isETATBA() || !isEditableMode) return;
                  String? _etaa = payload.eta();
                  if (payload.aTATime() != null) _etaa = payload.aTATime();
                  if (_etaa == null) {
                    DateTime? etaAddOneHour =
                        await repo.getInitialDateForETA(index: actualIndex);
                    if (etaAddOneHour != null) {
                      _etaa = etaAddOneHour.toString();
                    }
                  }
                  DateTime? initialDateTime =
                      _etaa != null ? DateTime.parse(_etaa) : null;
                  final int hour =
                      _etaa != null ? DateTime.parse(_etaa).hour : 0;
                  final int minute =
                      _etaa != null ? DateTime.parse(_etaa).minute : 0;
                  var date = await AppHelper().pickDateTime(
                    context,
                    use24Hr: true,
                    initialDate: initialDateTime,
                    initialTime: TimeOfDay(
                      hour: hour,
                      minute: minute,
                    ),
                  );
                  _setETA(actualIndex, date.toString());
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            label("EGT"),
            height(4),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: _egtWidth),
              child: CustomTextFormField(
                isEditableMode: _isEGTDisabled,
                focusNode: _isEGTDisabled ? AlwaysDisabledFocusNode() : null,
                label: "",
                value: payload.etg() ?? "",
                hintText: 'hhhh:mm',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: <TextInputFormatter>[
                  _etgTimeMaskFormatter,
                ],
                onChanged: (value) => _setEGTChangedHandler(actualIndex, value),
              ),
            ),
            //MARK: This is to bring both the fields in same alignment, UTC to local time will be displayed in the above field
            label(""),
          ],
        ),
      ],
    );
  }

  void _setETA(int index, String eta) {
    if (isEditableMode) {
      repo.setETA(index: index, eta: eta);
      _updatePayload();
    }
  }

  void _setETAToATA(int index) {
    if (isEditableMode) {
      repo.setETAToATA(index: index);
      _updatePayload();
    }
  }

  void _setATAToETA(int index) {
    if (isEditableMode) {
      repo.setATAToETA(index: index);
      _updatePayload();
    }
  }

  void _setEGTChangedHandler(index, value) {
    if (isEditableMode && value.length == 7) {
      repo.setETG(index: index, etg: value);
      _updatePayload();
    }
  }

  void _updatePayload() {
    updateWidgetHandler();
  }
}
