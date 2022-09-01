import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/airport_requirement_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/airport_requirement_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/flight_requirement_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/flight_requirement_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class WAirportFlightRequirementsPopup extends StatefulWidget {
  final TripServiceModalType type;
  final int airportID;
  final int countryID;

  const WAirportFlightRequirementsPopup(
      {required this.type, this.airportID = 0, this.countryID = 0, Key? key})
      : assert(
            !(type == TripServiceModalType.LOCATION &&
                airportID == 0 &&
                countryID == 0),
            'Cannot load $type modal without airportID and countryID'),
        assert(!(type == TripServiceModalType.OVERFLY && countryID == 0),
            'Cannot load $type modal without countryID'),
        super(key: key);

  @override
  State<WAirportFlightRequirementsPopup> createState() =>
      _WAirportFlightRequirementsPopupState();
}

class _WAirportFlightRequirementsPopupState
    extends State<WAirportFlightRequirementsPopup> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: () {
        if (widget.type == TripServiceModalType.LOCATION) {
          return Column(
            children: [
              _buildDialogHeading(heading: 'Airport and Flight Requirements'),
              Expanded(child: _buildAirportRequirement()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildDialogHeading(
                  heading: 'Flight Requirements - Country name'),
              Expanded(child: _buildFlightRequirement()),
            ],
          );
        }
      }(),
    );
  }

  void fetchPopupData() {
    if (widget.type == TripServiceModalType.OVERFLY) {
      fetchCountryFlightRequirement();
    } else {
      fetchAirportDetails();
      fetchAirportFlightRequirement();
    }
  }

  void fetchAirportDetails() {
    AirportRequirementBloc airportRequirementBloc =
        BlocProvider.of<AirportRequirementBloc>(context);
    airportRequirementBloc
        .add(FetchAirportRequirement(airportID: widget.airportID));
  }

  void fetchAirportFlightRequirement() {
    FlightRequirementBloc flightRequirementBloc =
        BlocProvider.of<FlightRequirementBloc>(context);
    flightRequirementBloc.add(
        FetchFlightRequirement(type: widget.type, countryID: widget.airportID));
  }

  void fetchCountryFlightRequirement() {
    FlightRequirementBloc flightRequirementBloc =
        BlocProvider.of<FlightRequirementBloc>(context);
    flightRequirementBloc.add(
        FetchFlightRequirement(type: widget.type, countryID: widget.countryID));
  }

  Widget _buildAirportRequirement() {
    return BlocBuilder<AirportRequirementBloc, AirportRequirementState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchAirportRequirementStatus.initial:
          case FetchAirportRequirementStatus.loading:
            return _buildCircularProgressBar();
          case FetchAirportRequirementStatus.success:
            return Accordion(
              children: [
                _buildAirport(
                    airportDetailRequirement: state.airportDetailRequirement),
                AccordionSection(
                  header: _buildAccordionHeading(heading: 'Flight Requirement'),
                  headerBackgroundColor: AppColors.paleGrey,
                  rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                  flipRightIconIfOpen: true,
                  content: _buildFlightRequirement(),
                ),
              ],
            );
          case FetchAirportRequirementStatus.failure:
            return _buildNoData();
        }
      },
    );
  }

  AccordionSection _buildAirport(
      {required AirportDetailRequirement airportDetailRequirement}) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'Airport Details'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Airport Name',
                  content: airportDetailRequirement.name ?? '')),
          _buildOneItemRow(
              item1: const RowItem(heading: 'Type/Restrictions', content: '')),
          _buildFourColumnStatusWidget(
            item1: StatusItem(
                heading: 'Civil',
                status: airportDetailRequirement.civil ?? false),
            item2: StatusItem(
                heading: 'Slots',
                status: airportDetailRequirement.slots ?? false),
            item3: StatusItem(
                heading: 'US Southern AOE',
                status: airportDetailRequirement.uSSouthernAOE ?? false),
            item4: StatusItem(
                heading: 'PPR', status: airportDetailRequirement.ppr ?? false),
          ),
          _buildFourColumnStatusWidget(
            item1: StatusItem(
                heading: 'Military',
                status: airportDetailRequirement.military ?? false),
            item2: StatusItem(
                heading: 'H24', status: airportDetailRequirement.h24 ?? false),
            item3: StatusItem(
                heading: 'US Lngd-Rights',
                status: airportDetailRequirement.uSLngdRights ?? false),
            item4: StatusItem(
                heading: 'Customs',
                status: airportDetailRequirement.customs ?? false),
          ),
          _buildFourColumnStatusWidget(
            item1: StatusItem(
                heading: 'AOE/INTL',
                status: airportDetailRequirement.aoe ?? false),
            item2: StatusItem(
                heading: 'US Pre-Clear',
                status: airportDetailRequirement.uSPreClear ?? false),
            item3: StatusItem(
                heading: 'UAS Supervisory Svc',
                status: airportDetailRequirement.uASSupervisorySvc ?? false),
            item4: const StatusItem(heading: '', status: false),
          ),
          _buildThreeItemRow(
            item1: RowItem(
                heading: 'ICAO Code',
                content: airportDetailRequirement.icao ?? ''),
            item2: RowItem(
                heading: 'IATA Code',
                content: airportDetailRequirement.iata ?? ''),
            item3: RowItem(
                heading: 'Country',
                content: airportDetailRequirement.country?.name ?? ''),
          ),
          _buildThreeItemRow(
            item1: RowItem(
                heading: 'City',
                content: airportDetailRequirement.airportCity?.city ?? ''),
            item2: RowItem(
                heading: 'Alternative',
                content: () {
                  if (airportDetailRequirement.alternatives != null) {
                    return airportDetailRequirement.alternatives!.join('\n');
                  } else {
                    return 'Not Available';
                  }
                }()),
            item3: RowItem(
                heading: 'Elevation',
                content: airportDetailRequirement.elevation?.toString() ?? ''),
          ),
          _buildThreeItemRow(
            item1: RowItem(
                heading: 'Latitude',
                content: airportDetailRequirement.latitude ?? ''),
            item2: RowItem(
                heading: 'Longitude',
                content: airportDetailRequirement.longitude ?? ''),
          ),
          _buildRunwayInformation(
              runwayInformation:
                  airportDetailRequirement.runwayInformation ?? []),
          _buildRunwaySurface(),
          Accordion(children: [
            _buildTimeZone(airportDetailRequirement),
            _buildATCFrequencies(airportDetailRequirement),
            _buildOperatingHours(airportDetailRequirement),
            _buildCategories(airportDetailRequirement),
            _buildRunwayFacilities(airportDetailRequirement),
            _buildFuelDetails(airportDetailRequirement),
            _buildGeneralRemarks(airportDetailRequirement),
            _buildDepartureProcedure(airportDetailRequirement),
            _buildArrivalProcedure(airportDetailRequirement),
            _buildCargoFlights(airportDetailRequirement),
          ]),
        ],
      ),
    );
  }

  Widget _buildRunwayInformation(
      {List<RunwayInformation> runwayInformation = const []}) {
    if (runwayInformation.isEmpty) {
      return _buildOneItemRow(
          item1: const RowItem(heading: 'Runway Information'));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOneItemRow(item1: const RowItem(heading: 'Runway Information')),
          ListView.builder(
            shrinkWrap: true,
            itemCount: runwayInformation.length,
            itemBuilder: (context, index) {
              RunwayInformation info = runwayInformation[index];
              return _buildFourItemRow(
                item1: RowItem(heading: 'RWY ID', content: info.rWYID),
                item2:
                    RowItem(heading: 'Length(FT)', content: info.runwayLength),
                item3: RowItem(heading: 'Width(FT)', content: info.runwayWidth),
                item4: RowItem(heading: 'Length(FT)', content: info.pCN),
              );
            },
          ),
        ],
      );
    }
  }

  Widget _buildRunwaySurface({String runwaySurface = ''}) {
    if (runwaySurface.isEmpty) {
      return _buildOneItemRow(item1: const RowItem(heading: 'Runway Surface'));
    } else {
      // TODO to be discussed with Safi
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOneItemRow(item1: const RowItem(heading: 'Runway Surface')),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 0,
            itemBuilder: (context, index) {
              RunwayInformation info =
                  const RunwayInformation(airportId: 0, airportRunwayInfoId: 0);
              return _buildFourItemRow(
                item1: RowItem(heading: 'RWY ID', content: info.rWYID),
                item2:
                    RowItem(heading: 'Length(FT)', content: info.runwayLength),
                item3: RowItem(heading: 'Width(FT)', content: info.runwayWidth),
                item4: RowItem(heading: 'Length(FT)', content: info.pCN),
              );
            },
          ),
        ],
      );
    }
  }

  AccordionSection _buildTimeZone(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'TIME ZONE'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: Column(
        children: [
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Time Zone',
                  content: airportDetailRequirement.timezone)),
          _buildTwoItemRow(
              item1: RowItem(
                  heading: 'Local Time',
                  content: airportDetailRequirement.drivingTime),
              item2: RowItem(
                  heading: 'UTC Time',
                  content: airportDetailRequirement.taxiTime)),
          _buildTwoItemRow(
            item1: RowItem(
                heading: 'UTC Offset',
                content: airportDetailRequirement.dSTOffset),
            item2: RowItem(
                heading: 'DST',
                content:
                    (airportDetailRequirement.isDST ?? false) ? 'Yes' : 'No'),
          ),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Notes',
                  content: airportDetailRequirement.timezoneNote)),
        ],
      ),
    );
  }

  AccordionSection _buildATCFrequencies(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'ATC FREQUENCIES'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildThreeItemRow(
            item1: RowItem(
                heading: 'Tower', content: airportDetailRequirement.tower),
            item2: RowItem(
                heading: 'Tower 1', content: airportDetailRequirement.tower1),
            item3: RowItem(
                heading: 'Ground', content: airportDetailRequirement.ground),
          ),
          _buildThreeItemRow(
            item1: RowItem(
                heading: 'Ground 1', content: airportDetailRequirement.ground1),
            item2: RowItem(
                heading: 'Clearance',
                content: airportDetailRequirement.clearance),
            item3: RowItem(
                heading: 'ATIS', content: airportDetailRequirement.aTIS),
          ),
        ],
      ),
    );
  }

  AccordionSection _buildOperatingHours(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'OPERATING HOURS'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTwoItemRow(
            item1: RowItem(
              heading: 'Airport Hours',
              content: airportDetailRequirement.airportFromHours,
            ),
            item2: RowItem(
                heading: 'Tower Hours',
                content: airportDetailRequirement.towerFromHours),
          ),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Notes',
                  content: airportDetailRequirement.operatingHoursNote))
        ],
      ),
    );
  }

  AccordionSection _buildCategories(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'CATEGORIES'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTwoItemRow(
            item1: RowItem(
                heading: 'Noise Category',
                content: airportDetailRequirement.noiseCategory),
            item2: RowItem(
                heading: 'Airport Reference Code',
                content: airportDetailRequirement.referenceCode),
          ),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Fire Category',
                  content: airportDetailRequirement.fireCategory?.toString())),
          _buildStatusItem(
              statusText: 'Fire Category Upgrade',
              isPass: airportDetailRequirement.isFireCategoryUpgrade),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Notes',
                  content: airportDetailRequirement.fireCategoryNote)),
        ],
      ),
    );
  }

  AccordionSection _buildRunwayFacilities(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'RUNWAY FACILITIES'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTwoItemRow(
            item1: RowItem(
                heading: 'Runway lights',
                content: airportDetailRequirement.runwayLights),
            item2: RowItem(
                heading: 'Approach lights',
                content: airportDetailRequirement.approachLights),
          ),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Approaches',
                  content: (airportDetailRequirement.runwayApproaches ?? [])
                      .join('\n'))),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Notes',
                  content: airportDetailRequirement.runwayFacilitiesNote)),
        ],
      ),
    );
  }

  AccordionSection _buildFuelDetails(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'FUEL DETAILS'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFiveColumnStatusWidget(
            item1: StatusItem(
                heading: 'JET A1', status: airportDetailRequirement.jetA1),
            item2: StatusItem(
                heading: 'JET A', status: airportDetailRequirement.jetA),
            item3: StatusItem(
                heading: 'JET B', status: airportDetailRequirement.jetB),
            item4: StatusItem(
                heading: 'AVGAS', status: airportDetailRequirement.aVGas),
            item5: StatusItem(
                heading: 'TS1', status: airportDetailRequirement.tS1),
          ),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Fuel Restrictions',
                  content: airportDetailRequirement.fuelRestrictions))
        ],
      ),
    );
  }

  AccordionSection _buildGeneralRemarks(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'GENERAL REMARKS'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: _buildOneItemRow(
          item1: RowItem(
              heading: 'Notes',
              content: airportDetailRequirement.generalRemarks)),
    );
  }

  AccordionSection _buildDepartureProcedure(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'DEPARTURE PROCEDURE'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: _buildOneItemRow(
          item1: const RowItem(heading: 'Notes', content: 'No Data')),
    );
  }

  AccordionSection _buildArrivalProcedure(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'ARRIVAL PROCEDURE'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: _buildOneItemRow(
          item1: const RowItem(heading: 'Notes', content: 'No Data')),
    );
  }

  AccordionSection _buildCargoFlights(
      AirportDetailRequirement airportDetailRequirement) {
    return AccordionSection(
      header: _buildAccordionHeading(heading: 'CARGO FLIGHTS'),
      headerBackgroundColor: AppColors.paleGrey,
      rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flipRightIconIfOpen: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'General Remarks',
                  content: airportDetailRequirement.generalRemarksCargo)),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Cargo Restrictions',
                  content: airportDetailRequirement.generalRemarksCargo)),
        ],
      ),
    );
  }

  Widget _buildFlightRequirement() {
    return BlocBuilder<FlightRequirementBloc, FlightRequirementState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchFlightRequirementStatus.initial:
          case FetchFlightRequirementStatus.loading:
            return _buildCircularProgressBar();
          case FetchFlightRequirementStatus.success:
            return ListView.builder(
              itemBuilder: (context, index) {
                CountryAirportRequirement countryAirportRequirement =
                    state.countryAirportRequirement[index];
                return _buildFlightRequirementChildrenContent(
                    countryFlightRequirement: countryAirportRequirement);
              },
              itemCount: state.countryAirportRequirement.length,
            );
          case FetchFlightRequirementStatus.failure:
            return _buildNoData();
        }
      },
    );
  }

  List<AccordionSection> _buildFlightRequirementChildren(
      {required List<CountryAirportRequirement> flightRequirement}) {
    return flightRequirement.map((e) {
      CountryAirportRequirement countryFlightRequirement = e;
      return AccordionSection(
        header: _buildFlightRequirementHeading(
            country: countryFlightRequirement.through ?? ''),
        isOpen: true,
        contentBorderColor: Colors.transparent,
        headerBackgroundColor: const Color(0xffc5cde4),
        headerBackgroundColorOpened: const Color(0xffc5cde4),
        content: _buildFlightRequirementChildrenContent(
            countryFlightRequirement: countryFlightRequirement),
      );
    }).toList();
  }

  Widget _buildFlightRequirementChildrenContent(
      {required CountryAirportRequirement countryFlightRequirement}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Flight Category',
                  content:
                      (countryFlightRequirement.flightCategories?.join('\n')) ??
                          '')),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Services',
                  content:
                      (countryFlightRequirement.services?.join('\n')) ?? '')),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Through',
                  content: countryFlightRequirement.through ?? '')),
          _buildStatusWidget(
              fplMatch: countryFlightRequirement.fplMatch ?? false,
              specific: countryFlightRequirement.reqSpecPermit ?? false,
              documentsRequired: countryFlightRequirement.docsRequired ?? false,
              online: countryFlightRequirement.isOnline ?? false),
          _buildTwoItemRow(
            item1: RowItem(
                heading: 'Lead Time',
                content: countryFlightRequirement.leadTime ?? ''),
            item2: RowItem(
                heading: 'Permit Validity',
                content: countryFlightRequirement.permValidity ?? ''),
          ),
          _buildOneItemRow(
              item1: const RowItem(heading: 'Required', content: 'No Data')),
          _buildOneItemRow(
              item1: RowItem(
                  heading: 'Notes',
                  content: countryFlightRequirement.notes ?? '')),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildDialogHeading({required String heading}) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.paleGrey,
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              heading,
              style:
                  const TextStyle(color: AppColors.charcoalGrey, fontSize: 16),
            ),
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: Color(0xffc5cde4),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildStatusWidget(
      {required bool fplMatch,
      required bool specific,
      required bool documentsRequired,
      required bool online}) {
    return _buildFourColumnStatusWidget(
        item1: StatusItem(heading: 'FPL Match', status: fplMatch),
        item2: StatusItem(heading: 'SPECIFIC', status: specific),
        item3: StatusItem(
            heading: 'Documents Required', status: documentsRequired),
        item4: StatusItem(heading: 'Online', status: online),
        bgColor: AppColors.paleGrey);
  }

  Widget _buildFourColumnStatusWidget(
      {StatusItem item1 = const StatusItem(),
      StatusItem item2 = const StatusItem(),
      StatusItem item3 = const StatusItem(),
      StatusItem item4 = const StatusItem(),
      Color bgColor = Colors.transparent}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(7)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: item1.heading != ''
                    ? _buildStatusItem(
                        statusText: item1.heading, isPass: item1.status)
                    : Container(),
              ),
              Expanded(
                flex: 2,
                child: item2.heading != ''
                    ? _buildStatusItem(
                        statusText: item2.heading, isPass: item2.status)
                    : Container(),
              ),
              Expanded(
                flex: 2,
                child: item3.heading != ''
                    ? _buildStatusItem(
                        statusText: item3.heading, isPass: item3.status)
                    : Container(),
              ),
              Expanded(
                flex: 2,
                child: item4.heading != ''
                    ? _buildStatusItem(
                        statusText: item4.heading, isPass: item4.status)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFiveColumnStatusWidget(
      {StatusItem item1 = const StatusItem(),
      StatusItem item2 = const StatusItem(),
      StatusItem item3 = const StatusItem(),
      StatusItem item4 = const StatusItem(),
      StatusItem item5 = const StatusItem(),
      Color bgColor = Colors.transparent}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(7)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: item1.heading != ''
                    ? _buildStatusItem(
                        statusText: item1.heading, isPass: item1.status)
                    : Container(),
              ),
              Expanded(
                flex: 2,
                child: item2.heading != ''
                    ? _buildStatusItem(
                        statusText: item2.heading, isPass: item2.status)
                    : Container(),
              ),
              Expanded(
                flex: 2,
                child: item3.heading != ''
                    ? _buildStatusItem(
                        statusText: item3.heading, isPass: item3.status)
                    : Container(),
              ),
              Expanded(
                flex: 2,
                child: item4.heading != ''
                    ? _buildStatusItem(
                        statusText: item4.heading, isPass: item4.status)
                    : Container(),
              ),
              Expanded(
                flex: 2,
                child: item5.heading != ''
                    ? _buildStatusItem(
                        statusText: item5.heading, isPass: item5.status)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem({required String statusText, required bool? isPass}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isPass ?? false)
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.jadeGreen,
          )
        else
          const Icon(
            Icons.cancel,
            color: AppColors.redColor,
          ),
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              statusText,
              style:
                  const TextStyle(color: AppColors.charcoalGrey, fontSize: 13),
            ))
      ],
    );
  }

  Widget _buildOneItemRow({
    RowItem item1 = const RowItem(),
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item1.heading),
          ),
          Expanded(
            flex: 6,
            child: _buildContentText(content: item1.content),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoItemRow({
    RowItem item1 = const RowItem(),
    RowItem item2 = const RowItem(),
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item1.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item1.content),
          ),
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item2.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item2.content),
          ),
        ],
      ),
    );
  }

  Widget _buildThreeItemRow({
    RowItem item1 = const RowItem(),
    RowItem item2 = const RowItem(),
    RowItem item3 = const RowItem(),
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item1.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item1.content),
          ),
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item2.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item2.content),
          ),
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item3.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item3.content),
          ),
        ],
      ),
    );
  }

  Widget _buildFourItemRow({
    RowItem item1 = const RowItem(),
    RowItem item2 = const RowItem(),
    RowItem item3 = const RowItem(),
    RowItem item4 = const RowItem(),
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item1.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item1.content),
          ),
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item2.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item2.content),
          ),
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item3.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item3.content),
          ),
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading: item4.heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content: item4.content),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionHeading({required String heading}) {
    return Text(
      heading,
      style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 14),
    );
  }

  Widget _buildFlightRequirementHeading({required String country}) {
    if (widget.type == TripServiceModalType.LOCATION) {
      return Text(
        country + '- Flight Requirement',
        style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 14),
      );
    } else {
      return Text(
        country,
        style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 14),
      );
    }
  }

  Widget _buildHeading({required String countryName, VoidCallback? onPressed}) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.paleGrey,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeadingText(heading: countryName),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: Color(0xffc5cde4),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildHeadingText({required String heading}) {
    String colon = heading != '' ? ':' : '';
    return Text(
      heading + colon,
      style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 14),
    );
  }

  Widget _buildContentText({required String? content}) {
    return Text(
      () {
        if (content == null) {
          return 'Not Available';
        }
        if (content == '') {
          return 'Not Available';
        }
        return content;
      }(),
      style: const TextStyle(color: AppColors.brownGrey, fontSize: 14),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.powderBlue,
    );
  }

  Widget _buildNoData() {
    return Center(
      child: Text('noDataFound'.translate()),
    );
  }

  Widget _buildCircularProgressBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void didChangeDependencies() {
    fetchPopupData();
    super.didChangeDependencies();
  }
}

class StatusItem {
  final bool? status;
  final String heading;

  const StatusItem({this.status, this.heading = ''});
}

class RowItem {
  final String heading;
  final String? content;

  const RowItem({this.heading = '', this.content});
}
