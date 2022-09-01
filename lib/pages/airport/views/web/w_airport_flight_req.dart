import 'package:airport_repository/airport_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';
import 'package:gtm/pages/countries/bloc/flight_requirements/country_flight_requirements_bloc.dart';

class WAirportFlightRequirements extends StatefulWidget {
  const WAirportFlightRequirements({Key? key, required this.airport})
      : super(key: key);
  final Airport airport;

  @override
  State<WAirportFlightRequirements> createState() =>
      _WAirportFlightRequirementsState();
}

class _WAirportFlightRequirementsState
    extends State<WAirportFlightRequirements> {
  ScrollController mainListController = ScrollController();
  int rowsPerPage = 100;
  List<FlightRequirement> _flightRequirementsList = [];
  List<String> tableColumns = [
    'Flight Category',
    'Services',
    'Through',
    'Lead Time',
    'Permit Validity',
    'Required'
  ];
  List<double> tableColumnsWidth = [0, 0, 100, 100, 100, 100];

  @override
  void didChangeDependencies() {
    fetchFlightRequirements();
    super.didChangeDependencies();
  }

  fetchFlightRequirements() {
    CountryFlightRequirementsBloc countryFlightRequirements =
        BlocProvider.of<CountryFlightRequirementsBloc>(context);
    countryFlightRequirements
        .add(FetchFlightRequirements(widget.airport.countryId ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CountryFlightRequirementsBloc,
          CountryFlightRequirementState>(
        listener: (context, state) {
          if (state.status == FetchFlightRequirementsStatus.success) {
            if (state.flightRequirements != null) {}
          }
        },
        child: BlocBuilder<CountryFlightRequirementsBloc,
            CountryFlightRequirementState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            if (state.status == FetchFlightRequirementsStatus.loading) {
              return loadingWidget();
            }
            if (state.status == FetchFlightRequirementsStatus.initial) {}
            if (state.status == FetchFlightRequirementsStatus.success) {
              if (state.flightRequirements != null &&
                  state.flightRequirements!.isNotEmpty) {
                //_currentPage = state.flightRequirements!.length;
                _flightRequirementsList = state.flightRequirements!;
              }
            }
            _flightRequirementsList.sort((a, b) {
              return a.flightCategories![0]
                  .toLowerCase()
                  .compareTo(b.flightCategories![0].toLowerCase());
            });
            List<List<Widget>> rows = [];
            for (var val in _flightRequirementsList) {
              rows.add([
                appText(
                  val.flightCategories![0],
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.services!.toString(),
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.leadTime,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.permValidity,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.specFormRequired,
                  color: AppColors.charcoalGrey,
                ),
              ]);
            }
            return Padding(
              padding: const EdgeInsets.all(spacing8),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: mainListController,
                    child: Column(
                      children: [
                        CmsTableHeader(
                          columns: tableColumns,
                          columnsWidth: tableColumnsWidth,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: rows.length,
                            itemBuilder: (BuildContext context, int index) {
                              Widget actions = Container();
                              Widget expWidget = Container(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 8, 24, 8),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: AppColors.blueGrey,
                                      width: 2.0,
                                    ),
                                    right: BorderSide(
                                      color: AppColors.blueGrey,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              _flightRequirementsList[index]
                                                      .fplMatch!
                                                  ? SvgPicture.asset(AppImages
                                                      .onlineAvailabeAsset)
                                                  : SvgPicture.asset(
                                                      AppImages.minusIcon),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    spacing10),
                                                child: appText(
                                                  "FPL Match",
                                                  color: AppColors.charcoalGrey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              _flightRequirementsList[index]
                                                      .reqSpecPermit!
                                                  ? SvgPicture.asset(AppImages
                                                      .onlineAvailabeAsset)
                                                  : SvgPicture.asset(
                                                      AppImages.minusIcon),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    spacing10),
                                                child: appText(
                                                  "Specific ",
                                                  color: AppColors.charcoalGrey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              _flightRequirementsList[index]
                                                      .docsRequired!
                                                  ? SvgPicture.asset(AppImages
                                                      .onlineAvailabeAsset)
                                                  : SvgPicture.asset(
                                                      AppImages.minusIcon),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    spacing10),
                                                child: appText(
                                                  "Document Required",
                                                  color: AppColors.charcoalGrey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              _flightRequirementsList[index]
                                                      .isOnline!
                                                  ? SvgPicture.asset(AppImages
                                                      .onlineAvailabeAsset)
                                                  : SvgPicture.asset(
                                                      AppImages.minusIcon),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    spacing10),
                                                child: appText(
                                                  "Online",
                                                  color: AppColors.charcoalGrey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        appText(
                                          "Notes: ",
                                          color: AppColors.charcoalGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 8, 0),
                                            child: appText(
                                              _flightRequirementsList[index]
                                                  .notes,
                                              color: AppColors.charcoalGrey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                              return CmsTableRow(
                                isExpandable: true,
                                expandedWidget: expWidget,
                                editBool: false,
                                actions: actions,
                                columns: tableColumns,
                                columnsWidth: tableColumnsWidth,
                                row: rows[index],
                                itemIndex: index,
                                onTapAction: () {},
                              );
                            }),
                        CmsTableFooter(
                          columnsWidth: tableColumnsWidth,
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
