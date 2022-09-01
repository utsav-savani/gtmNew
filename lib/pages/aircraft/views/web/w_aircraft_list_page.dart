import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/aircraft/bloc/aircraft/aircraft_bloc.dart';
import 'package:gtm/pages/aircraft/views/web/w_aircraft_details_page.dart';
import 'package:gtm/pages/home/models/gtm_tab.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/home/view/web/components/tab_header.dart';

class WAircraftListPage extends StatefulWidget {
  const WAircraftListPage({Key? key}) : super(key: key);

  @override
  State<WAircraftListPage> createState() => _WAircraftListPageState();
}

class _WAircraftListPageState extends State<WAircraftListPage> {
  final TextEditingController _searchBoxController = TextEditingController();
  static const int _rowsLimit = 500;
  final int _currentPage = 1;
  List<String> headings = const [
    generalInfo,
    health,
    passportVisa,
    sanctions,
    flightRequirements,
    alerts,
    airports,
  ];
  List<Widget> pages = [];
  late final Widget _selectedPage = pages[0];
  late final String _selectedHeading = headings[0];

  List<AircraftDetails> _aircraftList = [];
  List<String> tableColumns = [
    'Reg No',
    'Type',
    'Ref. Code',
    'Operator',
    'Reg. Country'
  ];
  List<double> tableColumnsWidth = [100, 0, 100, 0, 200];

  ScrollController mainListController = ScrollController();

  @override
  void didChangeDependencies() {
    fetchAircraft(page: _currentPage);
    pages.clear();
    super.didChangeDependencies();
  }

  fetchAircraft({int page = 1}) {
    AircraftBloc aircraftBloc = BlocProvider.of<AircraftBloc>(context);
    aircraftBloc.aircraftRepository.setPage(page.toString());
    aircraftBloc.aircraftRepository.setLimit(_rowsLimit.toString());
    aircraftBloc.add(const FetchDetailedAircraftEvent());
  }

  searchAircraft({String searchText = ''}) {
    AircraftBloc aircraftBloc = BlocProvider.of<AircraftBloc>(context);
    aircraftBloc.add(SearchAircraft(searchText: searchText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AircraftBloc, AircraftState>(
        listener: (context, state) {},
        child: BlocBuilder<AircraftBloc, AircraftState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            if (state.status == FetchAircraftsStatus.loading ||
                state.status == FetchAircraftDetailStatus.initial) {
              return loadingWidget();
            }

            if (state.status == FetchAircraftsStatus.success) {
              if (state.aircraftDetails != null &&
                  state.aircraftDetails!.isNotEmpty) {
                _aircraftList = state.aircraftDetails!;
              }
            }
            _aircraftList.sort((a, b) {
              return a.registrationNumber!
                  .toLowerCase()
                  .compareTo(b.registrationNumber!.toLowerCase());
            });
            List<List<Widget>> rows = [];
            for (var val in _aircraftList) {
              var _operatorsList = [];
              if (val.operators != null && val.operators!.isNotEmpty) {
                for (int i = 0; i < val.operators!.length; i++) {
                  if (val.operators![i].customerName != null) {
                    _operatorsList.add(val.operators![i].customerName);
                  }
                }
              }
              rows.add([
                appText(
                  val.registrationNumber,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.aircraftType!.fullName,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.referenceCode,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  _operatorsList.join(', '),
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.country?.name ?? "",
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
                              Widget expWidget = Container();
                              GtmTab gtmTab = GtmTab(
                                isActive: true,
                                name: _aircraftList[index].registrationNumber ??
                                    '',
                                tab: tabHeader(
                                    false,
                                    _aircraftList[index].registrationNumber ??
                                        '',
                                    context),
                                page: WAircraftDetailPage(
                                  aircraft: _aircraftList[index],
                                ),
                                shortname:
                                    _aircraftList[index].registrationNumber ??
                                        '',
                              );
                              return CmsTableRow(
                                isExpandable: false,
                                expandedWidget: expWidget,
                                editBool: false,
                                actions: actions,
                                columns: tableColumns,
                                columnsWidth: tableColumnsWidth,
                                row: rows[index],
                                itemIndex: index,
                                onTapAction: () => openTab(gtmTab, context),
                              );
                            }),
                        CmsTableFooter(
                          columnsWidth: tableColumnsWidth,
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            GtmTab gtmTab = GtmTab(
                              isActive: true,
                              name: 'New Aircraft Tab',
                              tab: tabHeader(false, 'New Aircraft', context),
                              page: const WAircraftDetailPage(),
                              shortname: 'New Aircraft',
                            );
                            openTab(gtmTab, context);
                          },
                          child: const Text('Create New'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.newBlueColor)),
                        ),
                        width(10),
                        ElevatedButton(
                          onPressed: () {
                            closeTab("Aircraft", context);
                          },
                          child: const Text('Exit'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.redColor)),
                        ),
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
