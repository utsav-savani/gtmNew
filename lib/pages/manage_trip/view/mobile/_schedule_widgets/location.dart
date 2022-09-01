import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/selectors/m_airport_selector.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleLocationWidget extends StatelessWidget {
  final BuildContext parentContext;
  final int sequence;
  final bool isEditableMode;
  final TripSchedulePrePayload payload;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  final bool? isMobile;
  final bool? showIcons;
  const TripScheduleLocationWidget({
    Key? key,
    required this.parentContext,
    required this.sequence,
    required this.isEditableMode,
    required this.payload,
    required this.repo,
    required this.updateWidgetHandler,
    this.isMobile,
    this.showIcons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isMobile = isMobile ?? false;
    bool _showIcons = showIcons ?? false;
    if (_isMobile) _showIcons = false;
    Airport? _airport = payload.airport();
    String _airportTextLabel = "";
    if (_airport != null) {
      _airportTextLabel = "${_airport.icao}/${_airport.iata}";
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (_showIcons)
            SizedBox(
              width: spacing164,
              height: spacing88,
              child: Image.asset(
                AppImages.topFlightScheduleImage,
                color: AppColors.blueGrey,
              ),
            ),
          SizedBox(
            width: spacing288,
            height: 40,
            child: TextFormField(
              controller: TextEditingController()..text = _airportTextLabel,
              enableInteractiveSelection: isEditableMode,
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () => _openLocationPopup(tripPayload: payload),
              decoration: const InputDecoration(
                labelText: "Location",
                hintText: "Select Lo2cation",
              ),
            ),
          ),
          if (_airport != null && _airport.airportCity != null)
            label("${_airport.airportCity?.city}"),
          if (_showIcons)
            SizedBox(
              width: spacing164,
              height: spacing88,
              child: Image.asset(
                AppImages.bottomFlightScheduleImage,
                color: AppColors.blueGrey,
              ),
            ),
        ],
      ),
    );
  }

  void _openLocationPopup({required TripSchedulePrePayload tripPayload}) async {
    if (!isEditableMode) return;

    showModalBottomSheet<void>(
      context: parentContext,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: MAirportSelector(
            airportSelectHandler: (Airport airport) async {
              tripPayload.setAirport(airport);
              tripPayload.setAirportId(airport.airportId);
              Navigator.pop(context);
              updateWidgetHandler();
            },
          ),
        );
      },
    );
  }
}
