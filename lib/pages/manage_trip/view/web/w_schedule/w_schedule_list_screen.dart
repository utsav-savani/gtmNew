import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/libraries/app_alert.dart';
import 'package:gtm/_shared/libraries/app_loader.dart';
import 'package:gtm/_shared/shared.dart';
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
import 'package:gtm/pages/manage_trip/view/web/w_schedule/_partials/cancelled_sequence_drawer.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class WScheduleListScreen extends StatefulWidget {
  final TripDetail tripDetail;
  const WScheduleListScreen({required this.tripDetail, Key? key})
      : super(key: key);

  @override
  State<WScheduleListScreen> createState() => _WScheduleListScreenState();
}

class _WScheduleListScreenState extends State<WScheduleListScreen> {
  late String _guid;
  late TripDetail _tripDetail;
  bool _isLoading = false;
  List<TripSchedulePrePayload> _payload = <TripSchedulePrePayload>[];
  TripManagerScheduleRepository _tripManagerScheduleRepository =
      TripManagerScheduleRepository();

  final List<int> _showOverflightParentIndex = <int>[];

  bool _isEditableMode = false;
  bool _utc = true;

  @override
  void initState() {
    _guid = widget.tripDetail.guid!;
    _tripDetail = widget.tripDetail;
    _tripManagerScheduleRepository = TripManagerScheduleRepository();
    _loadData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _loadData() async {
    _payload = [];
    _isLoading = true;

    setState(() {});
    await _tripManagerScheduleRepository.reset();
    _payload = await _tripManagerScheduleRepository
        .getAndGenerateTripSchedulePayload(guid: _guid);
    if (_payload.length == 1) _isEditableMode = true;
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.40,
        child: const Drawer(
          child: CancelledSequenceDrawer(),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: _isLoading
            ? loadingWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          width(24),
                          label(
                            "Schedule",
                            color: AppColors.brownGrey,
                            fontSize: 24,
                          ),
                          if (!_isEditableMode && _payload.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  _isEditableMode = true;
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text("Edit"),
                                ),
                              ),
                            ),
                          if (_payload.isNotEmpty)
                            TripScheduleUTCLCLWidget(
                              repo: _tripManagerScheduleRepository,
                              utc: _utc,
                              updateWidgetHandler: (val) {
                                _utc = val;
                                _updatePayload();
                              },
                            ),
                          width(24),
                          if (_payload.isEmpty)
                            ElevatedButton(
                              onPressed: () => _addSequence(0, isBefore: false),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("Add Sequence"),
                              ),
                            ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 24.0),
                      //   child: ElevatedButton(
                      //     onPressed: () => Scaffold.of(context).openEndDrawer(),
                      //     child: const Padding(
                      //       padding: EdgeInsets.all(12.0),
                      //       child: Text("Cancelled Sequences"),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  if (_payload.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        height: spacing100,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blueGrey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text("No Schedule Found"),
                            ),
                            width(20),
                            ElevatedButton(
                              onPressed: () => _addSequence(0, isBefore: false),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("Add Sequence"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Expanded(child: _buildScheduleWidgets()),
                ],
              ),
      ),
    );
  }

  Widget _buildScheduleWidgets() {
    return ListView.builder(
      itemCount: _payload.length,
      itemBuilder: (context, i) {
        int index = i + 1;
        TripSchedulePrePayload payload = _payload[i];
        double _height = spacing164;
        String _loadWidget = DEPARTURE;
        if (index == 1) {
          _loadWidget = DEPARTURE;
        } else if (index == _payload.length) {
          _loadWidget = ARRIVAL;
        } else if (payload.split()) {
          _loadWidget = ARRIVAL;
        } else if (payload.splitPrevious()) {
          _loadWidget = DEPARTURE;
        } else {
          _loadWidget = DEPARTUREARRIVAL;
          _height = spacing300;
        }
        return Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(spacing20),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: spacing100,
                      maxHeight: _height,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: _buildInnerSectionOfEachSequence(
                      i,
                      payload,
                      _loadWidget,
                    ),
                    decoration: _boxDecoration(),
                  ),
                ),
                if (_loadWidget != ARRIVAL)
                  Positioned(
                    bottom: spacing6,
                    left: spacing6,
                    child: InkWell(
                      onTap: () {
                        if (_showOverflightParentIndex.contains(index)) {
                          _showOverflightParentIndex.remove(index);
                        } else {
                          _showOverflightParentIndex.add(index);
                        }
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          SvgPicture.asset(AppImages.overflightAddMinusImage),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (!_showOverflightParentIndex.contains(index))
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: svgToIcon(
                                      appImagesName: AppImages.addIcon,
                                      color: AppColors.whiteColor,
                                      height: 12,
                                      width: 12,
                                    ),
                                  ),
                                if (_showOverflightParentIndex.contains(index))
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                appText(
                                  "Overflight/s",
                                  color: AppColors.whiteColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            if (_loadWidget != ARRIVAL &&
                _showOverflightParentIndex.contains(index))
              _buildOverFlightSection(index, payload),
            if (index == _payload.length) _buildScheduleFormButtons(),
            if (index == _payload.length) height(100),
          ],
        );
      },
    );
  }

  Widget _buildScheduleFormButtons() {
    if (!_isEditableMode) return Container();

    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _isEditableMode = false;
              setState(() {});
            },
            child: label('Cancel', color: AppColors.redColor),
          ),
          width(24),
          TripScheduleSaveButtonWidget(
            guid: widget.tripDetail.guid!,
            isEditableMode: _isEditableMode,
            repo: _tripManagerScheduleRepository,
            updateWidgetHandler: () async {
              await AppLoader(context).show(
                title: "Loading Trip Schedule Details...",
              );
              await _loadData();
              await AppLoader(context).hide();
              _isEditableMode = false;
              setState(() {});
            },
          ),
          width(24),
        ],
      ),
    );
  }

  Widget _buildInnerSectionOfEachSequence(
    int i,
    TripSchedulePrePayload payload,
    String loadWidget,
  ) {
    switch (loadWidget) {
      case DEPARTURE:
        return _buildDepartureSection(i, payload, loadWidget);
      case ARRIVAL:
        return _buildArrivalSection(i, payload, loadWidget);
      case DEPARTUREARRIVAL:
        return _buildDepartureArrivalWidget(i, payload, loadWidget);
      default:
    }
    return Container();
  }

  Widget _buildDepartureSection(
    int i,
    TripSchedulePrePayload payload,
    String loadWidget,
  ) {
    final index = i + 1;

    bool _showIcons = index > 1 && index < _payload.length;
    if (loadWidget == DEPARTURE || loadWidget == ARRIVAL) _showIcons = false;
    return Stack(
      children: [
        _buildScheduleBgImage(fillHeight: BoxFit.fitHeight),
        Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSequenceWidget(index),
                  _buildArrivalDepartIcon(imageName: AppImages.departureIcon),
                  _buildVerticalBar(),

                  TripScheduleLocationWidget(
                    parentContext: context,
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    showIcons: _showIcons,
                  ),

                  _buildTBAWidget(index, payload, loadWidget),
                  TripScheduleETDATDETEWidget(
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    isLastSequence: _payload.length == index,
                  ),
                  // _buildDepartureInnerSection(index, payload),
                  const Spacer(),
                  _buildATCRTESection(index, payload, loadWidget: loadWidget),
                  _buildStatusSection(index, payload, loadWidget: loadWidget),
                  _buildAddDeleteSequence(index, payload),
                ],
              ),
            ),
            _buildBottomRowEachSequence(index, payload),
          ],
        ),
      ],
    );
  }

  Widget _buildDepartureArrivalWidget(
    int i,
    TripSchedulePrePayload payload,
    String loadWidget,
  ) {
    bool _split = payload.split() ?? false;

    final sequence = i + 1;
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Image.asset(
                      AppImages.scheduleWebBackgroundImage,
                      color: AppColors.blueGrey,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: Image.asset(
                      AppImages.scheduleWebBackgroundImage,
                      color: AppColors.blueGrey,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSequenceWidget(sequence),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildArrivalDepartIcon(
                            imageName: AppImages.arrivalIcon),
                        height(24),
                        _buildArrivalDepartIcon(
                          imageName: AppImages.departureIcon,
                        ),
                      ],
                    ),
                  ),
                  _buildVerticalBar(),
                  TripScheduleLocationWidget(
                    parentContext: context,
                    sequence: sequence,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    showIcons: true,
                  ),
                  width(24),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TripScheduleTBAWidget(
                            sequence: sequence,
                            isEditableMode: _isEditableMode,
                            payload: payload,
                            repo: _tripManagerScheduleRepository,
                            updateWidgetHandler: () => _updatePayload(),
                            value: payload.isETATBA() ?? false,
                            isETDTBA: false,
                            isETATBA: true,
                          ),
                          width(24),
                          TripScheduleETAATAEGTWidget(
                            sequence: sequence,
                            isEditableMode: _isEditableMode,
                            payload: payload,
                            repo: _tripManagerScheduleRepository,
                            updateWidgetHandler: () => _updatePayload(),
                            isLastSequence: _payload.length == sequence,
                          ),
                          _buildSplitWidget(sequence, payload, ARRIVAL),
                        ],
                      ),
                      height(20),
                      const Divider(
                        height: 2,
                        color: AppColors.blackColor,
                      ),
                      Row(
                        children: [
                          TripScheduleTBAWidget(
                            sequence: sequence,
                            isEditableMode: _isEditableMode,
                            payload: payload,
                            repo: _tripManagerScheduleRepository,
                            updateWidgetHandler: () => _updatePayload(),
                            value: payload.isETDTBA() ?? false,
                            isETDTBA: true,
                            isETATBA: false,
                          ),
                          width(24),
                          TripScheduleETDATDETEWidget(
                            sequence: sequence,
                            isEditableMode: _isEditableMode,
                            payload: payload,
                            repo: _tripManagerScheduleRepository,
                            updateWidgetHandler: () => _updatePayload(),
                            isLastSequence: _payload.length == sequence,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  _buildATCRTESection(sequence, payload,
                      loadWidget: loadWidget),
                  _buildStatusSection(sequence, payload,
                      loadWidget: loadWidget),
                  _buildAddDeleteSequence(sequence, payload),
                ],
              ),
            ),
            if (!_split) _buildBottomRowEachSequence(sequence, payload),
          ],
        ),
      ],
    );
  }

  Widget _buildDepartureArrivalWidget1(
    int i,
    TripSchedulePrePayload payload,
    String loadWidget,
  ) {
    bool _split = payload.split() ?? false;

    final index = i + 1;
    return Column(
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSequenceWidget(index),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildArrivalDepartIcon(imageName: AppImages.arrivalIcon),
                    height(24),
                    _buildArrivalDepartIcon(imageName: AppImages.departureIcon),
                  ],
                ),
              ),
              _buildVerticalBar(),
              TripScheduleLocationWidget(
                parentContext: context,
                sequence: index,
                isEditableMode: _isEditableMode,
                payload: payload,
                repo: _tripManagerScheduleRepository,
                updateWidgetHandler: () => _updatePayload(),
                showIcons: true,
              ),
              _buildTBAWidget(index, payload, loadWidget),
              width(24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TripScheduleETAATAEGTWidget(
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    isLastSequence: _payload.length == index,
                  ),
                  // _buildArrivalInnerSection(index, payload),
                  height(20),
                  const Divider(
                    height: 2,
                    color: AppColors.blackColor,
                  ),
                  TripScheduleETDATDETEWidget(
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    isLastSequence: _payload.length == index,
                  ),
                  // _buildDepartureInnerSection(index, payload),
                ],
              ),
              _buildSplitWidget(index, payload, loadWidget),
              const Spacer(),
              _buildATCRTESection(index, payload, loadWidget: loadWidget),
              _buildStatusSection(index, payload, loadWidget: loadWidget),
              _buildAddDeleteSequence(index, payload),
            ],
          ),
        ),
        if (!_split) _buildBottomRowEachSequence(index, payload),
      ],
    );
  }

  Widget _buildArrivalSection(
    int i,
    TripSchedulePrePayload payload,
    String loadWidget,
  ) {
    bool _split = payload.split() ?? false;
    final index = i + 1;
    return Stack(
      children: [
        _buildScheduleBgImage(fillHeight: BoxFit.fitHeight),
        Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSequenceWidget(index),
                  _buildArrivalDepartIcon(imageName: AppImages.arrivalIcon),
                  _buildVerticalBar(),
                  TripScheduleLocationWidget(
                    parentContext: context,
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    showIcons: false,
                  ),
                  _buildTBAWidget(index, payload, loadWidget),

                  TripScheduleETAATAEGTWidget(
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    isLastSequence: _payload.length == index,
                  ),
                  // _buildArrivalInnerSection(index, payload),
                  _buildSplitWidget(index, payload, loadWidget),
                  const Spacer(),
                  _buildStatusSection(index, payload, loadWidget: loadWidget),
                  _buildAddDeleteSequence(index, payload),
                ],
              ),
            ),
            if (!_split) _buildBottomRowEachSequence(index, payload),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomRowEachSequence(
    int index,
    TripSchedulePrePayload payload,
  ) {
    if (index == _payload.length) return Container();
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        border: Border(
          top: BorderSide(
            color: AppColors.powderBlue,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: spacing48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TripScheduleFlightCategoryWidget(
                    context: context,
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    isLastSequence: _payload.length == index,
                  ),
                  // _buildCategoryDropdown(
                  //   context,
                  //   tripPayload: payload,
                  // ),
                  TripScheduleFlightPurposeWidget(
                    context: context,
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    isLastSequence: _payload.length == index,
                  ),
                  // _buildPurposeDropdown(
                  //   context,
                  //   tripPayload: payload,
                  // ),

                  TripScheduleCallsignWidget(
                    context: context,
                    sequence: index,
                    isEditableMode: _isEditableMode,
                    payload: payload,
                    repo: _tripManagerScheduleRepository,
                    updateWidgetHandler: () => _updatePayload(),
                    isLastSequence: _payload.length == index,
                  ),
                  // _buildCallsignTextField(
                  //   context,
                  //   tripPayload: payload,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverFlightSection(int index, TripSchedulePrePayload payload) {
    List<TripSchedulePreOverflightPayload> _overflights = payload.overflights();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: _boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  label(
                    "Overflight/s",
                    fontSize: 16,
                  ),
                  width(30),
                  InkWell(
                    onTap: () => {
                      _addOrEditOverflight(
                        context,
                        tripPayload: payload,
                        sequence: index,
                      ),
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: underLineText(
                        child: label(
                          "Add Overflight",
                          color: AppColors.blueColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _overflights.isNotEmpty ? 172 : 0,
              child: ListView.builder(
                itemCount: _overflights.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  TripSchedulePreOverflightPayload _overflight =
                      _overflights[i];
                  return _buildOverflightListViewContainer(
                    index,
                    i,
                    _overflight,
                  );
                },
              ),
            ),
            height(24),
          ],
        ),
      ),
    );
  }

  Widget _buildOverflightListViewContainer(int parentIndex, int overflightIndex,
      TripSchedulePreOverflightPayload overflightPayload) {
    int _overflightIndex = overflightIndex + 1;
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Container(
        width: spacing320,
        decoration: _boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "No $parentIndex-$_overflightIndex",
                    style: const TextStyle(color: AppColors.blueGrey),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    AppImages.pathIcon,
                    color: AppColors.blueGrey,
                    width: 18,
                    height: 18,
                  ),
                  width(12),
                  IconButton(
                    onPressed: () async {
                      if (!_isEditableMode) return;

                      _tripManagerScheduleRepository.removeOverFlight(
                        index: parentIndex - 1,
                        overflightIndex: overflightIndex,
                      );
                      _payload = await _tripManagerScheduleRepository
                          .getUpdatedPayload();
                      setState(() {});
                    },
                    icon: SvgPicture.asset(
                      AppImages.minusIcon,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ],
              ),
              height(12),
              Row(
                children: [
                  Text(
                    "${getFlag(overflightPayload.code())}",
                    style: const TextStyle(fontSize: 32),
                  ),
                  width(12),
                  appText(
                    "${overflightPayload.countryName()}",
                    fontSize: 14,
                  ),
                ],
              ),
              height(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText("Entry Point"),
                      height(10),
                      Text(overflightPayload
                          .entryPoint()
                          .toString()
                          .toUpperCase()),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText("Exit Point"),
                      height(10),
                      Text(overflightPayload
                          .exitPoint()
                          .toString()
                          .toUpperCase()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: AppColors.powderBlue),
      borderRadius: BorderRadius.circular(spacing8),
    );
  }

  Widget _buildArrivalDepartIcon({required String imageName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: SvgPicture.asset(
            imageName,
            color: AppColors.blueGrey,
          ),
          width: spacing48,
          height: spacing36,
        ),
      ],
    );
  }

  Widget _buildSequenceWidget(index) {
    return SizedBox(
      width: 54,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Seq",
                  style: TextStyle(color: AppColors.powderBlue),
                ),
                height(8),
                Text(
                  "$index",
                  style: const TextStyle(color: AppColors.powderBlue),
                ),
              ],
            ),
          ),
          // if (index == 1 || index == _payload.length)
          _buildVerticalBar(),
        ],
      ),
    );
  }

  Widget _buildTBAWidget(
    int sequence,
    TripSchedulePrePayload payload,
    String loadWidget,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (sequence > 1 &&
              (loadWidget == ARRIVAL || loadWidget == DEPARTUREARRIVAL))
            TripScheduleTBAWidget(
              sequence: sequence,
              isEditableMode: _isEditableMode,
              payload: payload,
              repo: _tripManagerScheduleRepository,
              updateWidgetHandler: () => _updatePayload(),
              value: payload.isETATBA() ?? false,
              isETDTBA: false,
              isETATBA: true,
            ),
          if (loadWidget == DEPARTUREARRIVAL) height(40),
          if (sequence <= _payload.length &&
              [DEPARTURE, DEPARTUREARRIVAL].contains(loadWidget))
            TripScheduleTBAWidget(
              sequence: sequence,
              isEditableMode: _isEditableMode,
              payload: payload,
              repo: _tripManagerScheduleRepository,
              updateWidgetHandler: () => _updatePayload(),
              value: payload.isETDTBA() ?? false,
              isETDTBA: true,
              isETATBA: false,
            ),
        ],
      ),
    );
  }

  Widget _buildSplitWidget(
      int index, TripSchedulePrePayload payload, String loadWidget) {
    int actualIndex = index - 1;

    if (loadWidget == DEPARTURE || index == _payload.length) return Container();

    bool _split = payload.split() ?? false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          height(24),
          const Tooltip(
            message: "Split",
            child: Text(
              "Split",
              style: TextStyle(color: AppColors.blueGrey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(spacing4),
            child: Checkbox(
              value: _split,
              onChanged: (value) => _setSplit(actualIndex, value!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddDeleteSequence(int index, TripSchedulePrePayload payload) {
    int actualIndex = index - 1;
    return Container(
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _addSequence(actualIndex, isBefore: true),
              child: const Icon(
                Icons.add_rounded,
                size: spacing32,
                color: AppColors.blueGrey,
              ),
            ),
            InkWell(
              onTap: () => _removeSchedule(actualIndex),
              child: Image.asset(deleteAsset),
            ),
            InkWell(
              onTap: () => _addSequence(actualIndex, isBefore: false),
              child: const Icon(
                Icons.add_rounded,
                size: spacing32,
                color: AppColors.blueGrey,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalBar() {
    return const Padding(
      padding: EdgeInsets.all(spacing4),
      child: VerticalDivider(
        color: AppColors.powderBlue,
        width: spacing6,
        indent: spacing4,
        endIndent: spacing4,
      ),
    );
  }

  Widget _buildStatusSection(
    int index,
    TripSchedulePrePayload payload, {
    required String loadWidget,
  }) {
    return Container(
      color: AppColors.deepPurple,
      child: Column(
        children: [
          if (loadWidget == DEPARTUREARRIVAL)
            Expanded(
              child: FractionallySizedBox(
                heightFactor: 1,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    color: AppColors.draft,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("${payload.eTAStatus()}"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: FractionallySizedBox(
              heightFactor: 1,
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  color: AppColors.draft,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("${payload.eTDStatus()}"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildATCRTESection(
    int index,
    TripSchedulePrePayload payload, {
    required String loadWidget,
  }) {
    int actualIndex = index - 1;
    if (loadWidget == ARRIVAL) return Container();
    return Column(
      children: [
        if (loadWidget == DEPARTUREARRIVAL)
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: spacing124,
            ),
          ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => _setATCRTEDisplay(
                  index: actualIndex,
                  value: !payload.atcrteDisplay(),
                ),
                child: FractionallySizedBox(
                  heightFactor: 1,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Container(
                      color: AppColors.blueGrey,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("ATC RTE"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (payload.atcrteDisplay())
                _buildAtcrteTextField(
                  context,
                  tripPayload: payload,
                  loadWidget: loadWidget,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAtcrteTextField(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    required String loadWidget,
  }) {
    String _atcrte = "";
    if (tripPayload.atcrte() != null && tripPayload.atcrte() != 'NULL') {
      _atcrte = tripPayload.atcrte();
    }
    return Container(
      color: AppColors.whiteColor,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: loadWidget == DEPARTUREARRIVAL
              ? 124
              : MediaQuery.of(context).size.height,
          maxWidth: 400,
          minWidth: 40,
        ),
        child: TextFormField(
          controller: TextEditingController()..text = _atcrte,
          enableInteractiveSelection: _isEditableMode,
          focusNode: !_isEditableMode ? AlwaysDisabledFocusNode() : null,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: "Enter ATC Route",
            counterText: '',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(12),
          ),
          onChanged: (val) async {
            if (val != "") {
              val = val.toString();
            }
            tripPayload.setATCRTE(val.toString());
          },
        ),
      ),
    );
  }

  void _addSequence(int index, {required bool isBefore}) async {
    if (!_isEditableMode && _payload.isNotEmpty) return;
    if (_payload.isEmpty) _isEditableMode = true;
    _tripManagerScheduleRepository.addSchedule(
      index: index,
      isBefore: isBefore,
      tripDetail: widget.tripDetail,
    );
    _payload = await _tripManagerScheduleRepository.getUpdatedPayload();
    setState(() {});
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

  void _addOrEditOverflight(
    BuildContext context, {
    required TripSchedulePrePayload tripPayload,
    TripSchedulePreOverflightPayload? tripSchedulePreOverflightPayload,
    required int sequence,
  }) {
    if (!_isEditableMode) return;
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
              Navigator.pop(context);
              _updatePayload();
            },
          ),
        );
      },
    );
  }

  void _setSplit(int index, bool value) {
    if (_isEditableMode) {
      _tripManagerScheduleRepository.splitSchedule(
        index: index,
        split: value,
        tripDetail: _tripDetail,
      );
      _updatePayload();
    }
  }

  void _setATCRTEDisplay({required int index, required bool value}) {
    _tripManagerScheduleRepository.setATCRTEDisplay(index: index, value: value);
    _updatePayload();
  }

  _updatePayload() async {
    _payload = await _tripManagerScheduleRepository.getUpdatedPayload();
    setState(() {});
  }

  Widget _buildScheduleBgImage({
    double? top,
    double? bottom,
    BoxFit? fillHeight,
  }) {
    return Positioned(
      right: 0,
      top: top ?? 0,
      bottom: bottom ?? 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Image.asset(
          AppImages.scheduleWebBackgroundImage,
          color: AppColors.blueGrey,
          fit: fillHeight,
        ),
      ),
    );
  }
}
