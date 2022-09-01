import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleCallsignWidget extends StatelessWidget {
  final BuildContext context;
  final int sequence;
  final bool isEditableMode;
  final TripSchedulePrePayload payload;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  final bool isLastSequence;
  final bool? isMobile;
  TripScheduleCallsignWidget({
    Key? key,
    required this.context,
    required this.sequence,
    required this.isEditableMode,
    required this.payload,
    required this.repo,
    required this.updateWidgetHandler,
    required this.isLastSequence,
    this.isMobile,
  }) : super(key: key);

  final TextEditingController _callsignController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _isMobile = isMobile ?? false;
    String _callsign = "";
    if (payload.callsign() != null && payload.callsign() != 'NULL') {
      _callsign = payload.callsign();
    }
    _callsignController.text = _callsign;
    _callsignController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _callsignController.text.length,
      ),
    );

    double _width = 132;
    if (_isMobile) _width = MediaQuery.of(context).size.width - 114;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: spacing64,
            child: label("Callsign"),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: _width,
              maxHeight: spacing44,
              minHeight: spacing44,
            ),
            child: TextFormField(
              enableInteractiveSelection: isEditableMode,
              focusNode: !isEditableMode ? AlwaysDisabledFocusNode() : null,
              controller: _callsignController,
              maxLength: 8,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                hintText: "Enter Callsign",
                counterText: '',
              ),
              inputFormatters: [
                UpperCaseTextFormatter(),
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
              ],
              onChanged: (val) async {
                if (val != "") {
                  val = val.toString();
                }
                repo.setCallsign(index: sequence - 1, callsign: val.toString());
                payload.setCallsign(val.toString());
                updateWidgetHandler();
              },
            ),
          ),
        ],
      ),
    );
  }
}
