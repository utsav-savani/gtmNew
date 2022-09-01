import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleTBAWidget extends StatelessWidget {
  final int sequence;
  final bool isEditableMode;
  final TripSchedulePrePayload payload;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  final bool isETDTBA;
  final bool isETATBA;
  final bool value;
  final bool? isMobile;
  const TripScheduleTBAWidget({
    Key? key,
    required this.sequence,
    required this.isEditableMode,
    required this.payload,
    required this.repo,
    required this.updateWidgetHandler,
    required this.isETDTBA,
    required this.isETATBA,
    required this.value,
    this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = sequence - 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Tooltip(
          message: toBeAnnouncedBreif,
          child: Text(
            toBeAnnounced,
            style: TextStyle(color: AppColors.blueGrey),
          ),
        ),
        Checkbox(
          value: value,
          onChanged: (value) => updateValue(index, value!),
        ),
      ],
    );
  }

  void updateValue(index, value) {
    if (isETDTBA) {
      _setETDTBA(index, value);
    } else if (isETATBA) {
      _setETATBA(index, value);
    }
  }

  void _setETDTBA(int index, bool value) {
    if (isEditableMode) {
      repo.setETDTBA(index: index, value: value);
      _updatePayload();
    }
  }

  void _setETATBA(int index, bool value) {
    if (isEditableMode) {
      repo.setETATBA(index: index, value: value);
      _updatePayload();
    }
  }

  void _updatePayload() {
    updateWidgetHandler();
  }
}
