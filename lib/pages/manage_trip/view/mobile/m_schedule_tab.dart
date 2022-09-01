import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/libraries/app_alert.dart';
import 'package:gtm/_shared/libraries/app_loader.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/trip_status_card_widget.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_partials/m_add_overflight_widget.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/callsign_widget.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/eta_ata_egt_widget.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/etd_atd_ete_widget.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/flight_category_widget.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/flight_purpose_widget.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/location.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/save_button.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/switch_icon_widget.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_schedule_widgets/tba_widget.dart';
import 'package:gtm/pages/widgets/trip_accordion.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class MScheduleTab extends StatefulWidget {
  final TripDetail tripDetail;

  const MScheduleTab({Key? key, required this.tripDetail}) : super(key: key);

  @override
  State<MScheduleTab> createState() => _MScheduleTabState();
}

class _MScheduleTabState extends State<MScheduleTab> {
  late String _guid;
  late TripDetail _tripDetail;
  bool _isLoading = false;
  bool _utc = true;
  TripManagerScheduleRepository _tripManagerScheduleRepository =
      TripManagerScheduleRepository();
  List<TripSchedulePrePayload> _payload = <TripSchedulePrePayload>[];

  bool _isEditableMode = false;

  @override
  void initState() {
    _tripDetail = widget.tripDetail;
    _guid = widget.tripDetail.guid!;
    _tripManagerScheduleRepository = TripManagerScheduleRepository();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getAllScheduleData();
    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _getAllScheduleData() async {
    _isLoading = true;
    setState(() {});

    await _tripManagerScheduleRepository.reset();
    _payload = await _tripManagerScheduleRepository
        .getAndGenerateTripSchedulePayload(guid: _guid);
    _isEditableMode = false;
    if (_payload.length == 1) _isEditableMode = true;
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return loadingWidget();
    return SafeArea(
      child: OnTapHideKeyBoard(
        child: Column(
          children: [
            SizedBox(
              height: 62,
              child: _buildTripInfoWidget(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    TripSchedulePrePayload _tripPayload = _payload[index];
                    int sequence = index + 1;
                    return _buildTripSequenceWidget(
                      context,
                      tripPayload: _tripPayload,
                      sequence: sequence,
                    );
                  },
                  itemCount: _payload.length,
                ),
              ),
            ),
            if (_isEditableMode) _buildFormButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTripInfoWidget() {
    return Card(
      child: MergeSemantics(
        child: ListTile(
          contentPadding: null,
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label("Trip Id"),
                  height(4),
                  Text(
                    "${_tripDetail.tripNumber}".toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.charcoalGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.6,
                    ),
                  ),
                  height(2),
                ],
              ),
              width(20),
              if (!_isEditableMode)
                InkWell(
                  onTap: () => setState(() {
                    _isEditableMode = true;
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: underLineText(
                        child: label("Edit", color: AppColors.deepSkyBlue)),
                  ),
                ),
              if (_isEditableMode)
                InkWell(
                  onTap: () => setState(() {
                    _isEditableMode = false;
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: label("Cancel", color: AppColors.redColor),
                  ),
                ),
            ],
          ),
          trailing: TripScheduleUTCLCLWidget(
            repo: _tripManagerScheduleRepository,
            utc: _utc,
            updateWidgetHandler: (val) {
              _utc = val;
              _updatePayload();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTripSequenceWidget(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required int sequence,
  }) {
    Airport? _airport = tripPayload.airport();
    String _airportTextLabel = "";
    if (_airport != null) {
      _airportTextLabel = "${_airport.icao}/${_airport.iata}";
    }
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: TripAccordion(
        visualDensity: -3,
        titleWidget: _buildAccordionHeading(
          heading: _airportTextLabel,
          sequence: sequence,
          tripStatus: "${tripPayload.eTAStatus()}",
        ),
        listTileColor: AppColors.defaultColor,
        titleColor: AppColors.whiteColor,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: _buildTripScheduleDetailWidget(
            context,
            tripPayload: tripPayload,
            sequence: sequence,
          ),
        ),
      ),
    );
  }

  Widget _buildAccordionHeading({
    required String heading,
    required int sequence,
    required String tripStatus,
  }) {
    int index = sequence - 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Seq-$sequence / $heading",
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: spacing13,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TripStatusCardWidget(tripStatuss: tripStatus),
            InkWell(
              onTap: () => _removeSchedule(index),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: svgToIcon(
                  appImagesName: AppImages.minusIcon,
                  width: spacing20,
                  height: spacing20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTripScheduleDetailWidget(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required int sequence,
  }) {
    int index = sequence - 1;
    bool isLastSequence = sequence == _payload.length;
    bool _showArrivalWidget = true;
    if (sequence == 1) _showArrivalWidget = false;
    bool _showDepartureWidget = true;
    if (_payload.length > 1 && sequence == _payload.length) {
      _showDepartureWidget = false;
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              height(16),
              _buildLocationWidget(
                context,
                tripPayload: tripPayload,
                index: index,
              ),
              if (_showArrivalWidget) height(16),
              if (_showArrivalWidget)
                _buildArrivalWidget(
                  context,
                  payload: tripPayload,
                  sequence: sequence,
                ),
              if (_showDepartureWidget) height(16),
              if (_showDepartureWidget)
                _buildDepartureWidget(
                  context,
                  payload: tripPayload,
                  sequence: sequence,
                ),
            ],
          ),
        ),
        const Divider(
          color: AppColors.powderBlue,
        ),
        Container(
          color: AppColors.deepLavender,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: isLastSequence
                ? Container()
                : Column(
                    children: [
                      TripScheduleFlightCategoryWidget(
                        context: context,
                        sequence: sequence,
                        isEditableMode: _isEditableMode,
                        payload: tripPayload,
                        repo: _tripManagerScheduleRepository,
                        updateWidgetHandler: () => _updatePayload(),
                        isLastSequence: _payload.length == index,
                        isMobile: true,
                      ),
                      // _buildCategoryDropdown(
                      //   context,
                      //   tripPayload: tripPayload,
                      // ),
                      height(8),
                      TripScheduleFlightPurposeWidget(
                        context: context,
                        sequence: sequence,
                        isEditableMode: _isEditableMode,
                        payload: tripPayload,
                        repo: _tripManagerScheduleRepository,
                        updateWidgetHandler: () => _updatePayload(),
                        isLastSequence: _payload.length == index,
                        isMobile: true,
                      ),
                      // _buildPurposeDropdown(
                      //   context,
                      //   tripPayload: tripPayload,
                      // ),
                      height(8),
                      TripScheduleCallsignWidget(
                        context: context,
                        sequence: sequence,
                        isEditableMode: _isEditableMode,
                        payload: tripPayload,
                        repo: _tripManagerScheduleRepository,
                        updateWidgetHandler: () => _updatePayload(),
                        isLastSequence: _payload.length == index,
                        isMobile: true,
                      ),
                      // _buildCallsignTextField(
                      //   context,
                      //   tripPayload: tripPayload,
                      // ),
                      height(8),
                      _buildAtcrteTextField(
                        context,
                        tripPayload: tripPayload,
                        sequence: sequence,
                      ),
                    ],
                  ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAddSequenceButton(
                context,
                tripPayload: tripPayload,
                sequence: sequence,
              ),
              if (!isLastSequence)
                _buildAddOverflightButton(
                  context,
                  tripPayload: tripPayload,
                  sequence: sequence,
                ),
            ],
          ),
        ),
        if (tripPayload.overflights().length > 0)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label(
                  "Overflight/s",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                height(12),
                _buildOverflightsListWidget(
                  context,
                  tripPayload: tripPayload,
                  sequence: sequence,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLocationWidget(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required int index,
  }) {
    Airport? _airport = tripPayload.airport();
    String _airportName = "";
    if (_airport != null) {
      _airportName = _airport.name;
    }
    bool _split = tripPayload.split() ?? false;
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: Column(
            children: [
              const Icon(
                Icons.location_pin,
                color: AppColors.blueGrey,
                size: 24,
              ),
              label("LOC")
            ],
          ),
        ),
        width(8),
        Expanded(
          child: TripScheduleLocationWidget(
            parentContext: context,
            sequence: index,
            isEditableMode: _isEditableMode,
            payload: tripPayload,
            repo: _tripManagerScheduleRepository,
            updateWidgetHandler: () => _updatePayload(),
            showIcons: false,
            isMobile: true,
          ),
        ),
        width(8),
        SizedBox(
          width: 54,
          child: Row(
            children: const [
              // SizedBox(
              //   width: 28,
              //   height: 28,
              //   child: Checkbox(
              //     value: _split,
              //     onChanged: (value) =>
              //         _setSplit(index, value!), //  <-- leading Checkbox
              //   ),
              // ),
              // label("Split"),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildArrivalWidget(
    BuildContext context, {
    required TripSchedulePrePayload payload,
    required int sequence,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: Column(
            children: [
              svgToIcon(
                appImagesName: AppImages.arrivalIcon,
                color: AppColors.blueGrey,
              ),
              label("ARR")
            ],
          ),
        ),
        width(8),
        TripScheduleETAATAEGTWidget(
          sequence: sequence,
          isEditableMode: _isEditableMode,
          payload: payload,
          repo: _tripManagerScheduleRepository,
          updateWidgetHandler: () => _updatePayload(),
          isLastSequence: _payload.length == sequence,
          isMobile: true,
        ),
        width(4),
        SizedBox(
          width: spacing48,
          child: TripScheduleTBAWidget(
            sequence: sequence,
            isEditableMode: _isEditableMode,
            payload: payload,
            repo: _tripManagerScheduleRepository,
            updateWidgetHandler: () => _updatePayload(),
            value: payload.isETATBA() ?? false,
            isETDTBA: false,
            isETATBA: true,
          ),
        )
      ],
    );
  }

  Widget _buildDepartureWidget(
    BuildContext context, {
    required TripSchedulePrePayload payload,
    required int sequence,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: Column(
            children: [
              svgToIcon(
                appImagesName: AppImages.departureIcon,
                color: AppColors.blueGrey,
              ),
              label("DEP")
            ],
          ),
        ),
        width(8),
        TripScheduleETDATDETEWidget(
          sequence: sequence,
          isEditableMode: _isEditableMode,
          payload: payload,
          repo: _tripManagerScheduleRepository,
          updateWidgetHandler: () => _updatePayload(),
          isLastSequence: _payload.length == sequence,
          isMobile: true,
        ),
        width(4),
        SizedBox(
          width: spacing48,
          child: TripScheduleTBAWidget(
            sequence: sequence,
            isEditableMode: _isEditableMode,
            payload: payload,
            repo: _tripManagerScheduleRepository,
            updateWidgetHandler: () => _updatePayload(),
            value: payload.isETDTBA() ?? false,
            isETDTBA: true,
            isETATBA: false,
          ),
        )
      ],
    );
  }

  // Widget _buildCategoryDropdown(
  //   BuildContext context, {
  //   required TripSchedulePrePayload tripPayload,
  // }) {
  //   FlightCategory? _category = tripPayload.flightCategory();
  //   String _categoryName = "";
  //   if (_category != null) _categoryName = _category.category;
  //   return InkWell(
  //     onTap: () => _openFlightCategory(tripPayload: tripPayload),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: AppColors.powderBlue),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             SizedBox(
  //               width: spacing64,
  //               child: label("Category"),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 _categoryName,
  //                 style: const TextStyle(
  //                   fontSize: spacing13,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ),
  //             const Icon(
  //               Icons.keyboard_arrow_down_outlined,
  //               color: AppColors.powderBlue,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildPurposeDropdown(
  //   BuildContext context, {
  //   required TripSchedulePrePayload tripPayload,
  // }) {
  //   FlightPurpose? _purpose = tripPayload.purpose();
  //   String _purposeName = "";
  //   if (_purpose != null) _purposeName = _purpose.flightPurpose;
  //   return InkWell(
  //     onTap: () => _openFlightPurpose(tripPayload: tripPayload),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: AppColors.powderBlue),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             SizedBox(
  //               width: spacing64,
  //               child: label("Purpose"),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 _purposeName,
  //                 style: const TextStyle(
  //                   fontSize: spacing13,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ),
  //             const Icon(
  //               Icons.keyboard_arrow_down_outlined,
  //               color: AppColors.powderBlue,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildCallsignTextField(
  //   BuildContext context, {
  //   required TripSchedulePrePayload tripPayload,
  // }) {
  //   String _callsign = "";
  //   if (tripPayload.callsign() != null && tripPayload.callsign() != 'NULL') {
  //     _callsign = tripPayload.callsign();
  //   }
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(color: AppColors.powderBlue),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           SizedBox(
  //             width: spacing64,
  //             child: label("Callsign"),
  //           ),
  //           Expanded(
  //             child: TextFormField(
  //               enableInteractiveSelection: _isEditableMode,
  //               focusNode: !_isEditableMode ? AlwaysDisabledFocusNode() : null,
  //               controller: TextEditingController()..text = _callsign,
  //               maxLength: 8,
  //               textCapitalization: TextCapitalization.characters,
  //               decoration: const InputDecoration(
  //                 hintText: "Enter Callsign",
  //                 counterText: '',
  //               ),
  //               onChanged: (val) async {
  //                 if (val != "") {
  //                   val = val.toString();
  //                 }
  //                 tripPayload.setCallsign(val.toString());
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAtcrteTextField(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required int sequence,
  }) {
    String _atcrte = "";
    if (tripPayload.atcrte() != null && tripPayload.atcrte() != 'NULL') {
      _atcrte = tripPayload.atcrte();
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.powderBlue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: spacing64,
              child: label("ATCRTE"),
            ),
            Expanded(
              child: TextFormField(
                controller: TextEditingController()..text = _atcrte,
                enableInteractiveSelection: _isEditableMode,
                focusNode: !_isEditableMode ? AlwaysDisabledFocusNode() : null,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: "Enter ATC Route",
                  counterText: '',
                ),
                onChanged: (val) async {
                  if (val != "") {
                    val = val.toString();
                  }
                  tripPayload.setATCRTE(val.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddSequenceButton(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required int sequence,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.deepLavender,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
        ),
      ),
      onPressed: () => _openAddSequenceActionSheet(
        context,
        tripPayload: tripPayload,
        sequence: sequence,
      ),
      child: const Text("Add Sequence"),
    );
  }

  Widget _buildAddOverflightButton(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required int sequence,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.deepLavender,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
        ),
      ),
      onPressed: () async {
        _addOrEditOverflight(
          context,
          tripPayload: tripPayload,
          sequence: sequence,
        );
      },
      child: const Text("Add Overflight"),
    );
  }

  Widget _buildOverflightsListWidget(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required int sequence,
  }) {
    List<TripSchedulePreOverflightPayload> _overflights =
        tripPayload.overflights();
    return SizedBox(
      height: 88,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _overflights.length,
        itemBuilder: (BuildContext context, int overflightIndex) {
          TripSchedulePreOverflightPayload _overflightPayload =
              _overflights[overflightIndex];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.powderBlue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Spacer(),
                        label(
                          "No. $sequence-${_overflightPayload.sequenceNum()}",
                        ),
                        height(8),
                        Text(
                          getFlag("${_overflightPayload.code()}"),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                      ],
                    ),
                    width(12),
                    Column(
                      children: [
                        const Spacer(),
                        svgToIcon(
                          appImagesName: AppImages.pathIcon,
                          width: 24,
                          height: 24,
                        ),
                        height(8),
                        label("${_overflightPayload.countryName()}"),
                        const Spacer(),
                      ],
                    ),
                    width(24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            label("Ent. Point", color: AppColors.powderBlue),
                            width(8),
                            label(
                              _overflightPayload
                                  .entryPoint()
                                  .toString()
                                  .toUpperCase(),
                              color: AppColors.blueGrey,
                            ),
                          ],
                        ),
                        height(8),
                        Row(
                          children: [
                            label("Ext. Point", color: AppColors.powderBlue),
                            width(8),
                            label(
                              _overflightPayload
                                  .exitPoint()
                                  .toString()
                                  .toUpperCase(),
                              color: AppColors.blueGrey,
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    width(36),
                    InkWell(
                      onTap: () => _openOverFlightActionSheet(
                        context,
                        tripPayload: tripPayload,
                        tripSchedulePreOverflightPayload: _overflightPayload,
                        sequence: sequence,
                        overflightIndex: overflightIndex,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: svgToIcon(appImagesName: AppImages.menuDotsIcon),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openOverFlightActionSheet(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required TripSchedulePreOverflightPayload tripSchedulePreOverflightPayload,
    required int sequence,
    required int overflightIndex,
  }) {
    int index = sequence - 1;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Overflight/s Actions'),
        actions: <CupertinoActionSheetAction>[
          if (tripSchedulePreOverflightPayload.overflightId() != null)
            CupertinoActionSheetAction(
              onPressed: () async {
                _addOrEditOverflight(
                  context,
                  tripPayload: tripPayload,
                  tripSchedulePreOverflightPayload:
                      tripSchedulePreOverflightPayload,
                  sequence: sequence,
                );
              },
              child: const Text('Edit'),
            ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              _tripManagerScheduleRepository.removeOverFlight(
                index: index,
                overflightIndex: overflightIndex,
              );
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _openAddSequenceActionSheet(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required int sequence,
  }) {
    if (!_isEditableMode) return;
    int index = sequence - 1;
    Airport? _airport = tripPayload.airport();
    String? airportLabel;
    if (_airport != null) {
      airportLabel = "/ ${_airport.iata} - ${_airport.icao}";
    }

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Adding Sequence'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              _tripManagerScheduleRepository.addSchedule(
                index: index,
                isBefore: true,
                tripDetail: _tripDetail,
              );
              Navigator.pop(context);
              setState(() {});
            },
            child: underLineText(
              child: label(
                "Before",
                color: AppColors.deepSkyBlue,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: label("Seq-$sequence $airportLabel"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              _tripManagerScheduleRepository.addSchedule(
                index: index,
                isBefore: false,
                tripDetail: _tripDetail,
              );
              Navigator.pop(context);
              setState(() {});
            },
            child: underLineText(
              child: label(
                "After",
                color: AppColors.deepSkyBlue,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _addOrEditOverflight(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    TripSchedulePreOverflightPayload? tripSchedulePreOverflightPayload,
    required int sequence,
  }) {
    int index = sequence - 1;
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return SizedBox(
          child: MAddOverflightWidget(
              index: index,
              tripManagerScheduleRepository: _tripManagerScheduleRepository,
              tripSchedulePrePayload: tripPayload,
              overflightPayload: tripSchedulePreOverflightPayload,
              overflightSaveHandler: () async {
                if (tripSchedulePreOverflightPayload != null &&
                    tripSchedulePreOverflightPayload.overflightId() != null) {
                  //MARK:- This is to hide action items, its only for edit extra navigator pop
                  Navigator.pop(context);
                }
                _setStateHandler();
              }),
        );
      },
    );
  }

  Widget _buildFormButtons() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TripScheduleSaveButtonWidget(
          guid: widget.tripDetail.guid!,
          isEditableMode: _isEditableMode,
          repo: _tripManagerScheduleRepository,
          updateWidgetHandler: () async {
            await AppLoader(context).show(
              title: "Loading Trip Schedule Details...",
            );
            await _getAllScheduleData();
            await AppLoader(context).hide();
            _isEditableMode = false;
            setState(() {});
          },
        ),
      ),
    );
  }

  void _removeSchedule(int index) async {
    if (!_isEditableMode) return;
    await AppAlert.show(
      context,
      title: "Are you sure?",
      body: "You want to remove the sequence",
      extraButtonText: "Cancel",
      buttonTextCallback: () async {
        await _tripManagerScheduleRepository.removeSchedule(
          index: index,
        );
        setState(() {});
        return;
      },
    );
  }

  _updatePayload() async {
    _payload = await _tripManagerScheduleRepository.getUpdatedPayload();
    setState(() {});
  }

  void _setStateHandler() async {
    Navigator.pop(context);
    setState(() {});
  }
}
