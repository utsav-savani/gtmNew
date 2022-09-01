import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/selectors/m_purpose_selector.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleFlightPurposeWidget extends StatelessWidget {
  final BuildContext context;
  final int sequence;
  final bool isEditableMode;
  final TripSchedulePrePayload payload;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  final bool isLastSequence;
  final bool? isMobile;
  const TripScheduleFlightPurposeWidget({
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

  @override
  Widget build(BuildContext context) {
    // bool _isMobile = isMobile ?? false;
    FlightPurpose? _purpose = payload.purpose();
    String _purposeName = "";
    if (_purpose != null) _purposeName = _purpose.flightPurpose;
    return InkWell(
      onTap: () => _openFlightPurpose(tripPayload: payload),
      child: Container(
        decoration: drodownDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: spacing64,
                child: label("Purpose"),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: spacing120),
                child: Text(
                  _purposeName,
                  style: const TextStyle(
                    fontSize: spacing13,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.powderBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openFlightPurpose({required TripSchedulePrePayload tripPayload}) async {
    if (!isEditableMode) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: MPurposeSelector(
            purposeSelectHandler: (FlightPurpose purpose) async {
              repo.setPurposeId(
                index: sequence - 1,
                flightPurpose: purpose,
                purposeId: purpose.flightPurposeId,
              );
              Navigator.pop(context);
              updateWidgetHandler();
            },
          ),
        );
      },
    );
  }
}
