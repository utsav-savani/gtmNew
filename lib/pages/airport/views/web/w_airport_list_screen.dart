import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/airport/cubit/airport_cubit.dart';
import 'package:gtm/pages/airport/views/web/w_airport_details_page.dart';
import 'package:gtm/pages/home/models/gtm_tab.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/home/view/web/components/tab_header.dart';

class WAirportListPage extends StatefulWidget {
  const WAirportListPage({this.airportId, Key? key}) : super(key: key);

  final String? airportId;

  @override
  State<WAirportListPage> createState() => _WAirportListPageState();
}

class _WAirportListPageState extends State<WAirportListPage> {
  int limit = 500;
  bool next = false;
  int _currentPage = 1;

  ScrollController mainListController = ScrollController();
  List<Airport> airportList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fetchAirports(false);
    super.didChangeDependencies();
  }

  fetchAirports(bool forward) {
    context.read<AirportCubit>().getAirportPagination(forward);
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    List<Airport>? _airportsList;
    List<String> tableColumns = ['Airport', 'ICAO', 'IATA', 'Country', 'City'];
    List<double> tableColumnsWidth = [0, 100, 100, 0, 0];

    final bool _isWeb = MediaQuery.of(context).size.width >= web;
    return Scaffold(
      body: BlocListener<AirportCubit, AirportState>(
        listener: (context, state) {},
        child: BlocBuilder<AirportCubit, AirportState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            if (state.status == FetchAirportStatus.loading) {
              return loadingWidget();
            }
            if (state.status == FetchAirportStatus.initial) {}
            if (state.status == FetchAirportStatus.success) {
              if (state.airports != null && state.airports!.isNotEmpty) {
                _currentPage = state.airports!.length;
                _airportsList = state.airports;
              }
            }
            _airportsList!.sort((a, b) {
              return a.name.toLowerCase().compareTo(b.name.toLowerCase());
            });
            List<List<Widget>> rows = [];
            for (var val in _airportsList!) {
              rows.add([
                appText(
                  val.name,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.icao,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.iata,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  getFlag(val.code ?? '') + ' ' + val.countryName,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.city,
                  color: AppColors.charcoalGrey,
                ),
              ]);
            }
            return _isWeb
                ? _buildAirportsTable(
                    airportsList: _airportsList,
                    rows: rows,
                    tableColumns: tableColumns,
                    tableColumnsWidth: tableColumnsWidth,
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 800,
                      child: _buildAirportsTable(
                        airportsList: _airportsList,
                        rows: rows,
                        tableColumns: tableColumns,
                        tableColumnsWidth: tableColumnsWidth,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildAirportsTable(
      {required tableColumns,
      required tableColumnsWidth,
      required rows,
      required airportsList}) {
    return Padding(
      padding: const EdgeInsets.all(spacing8),
      child: Stack(children: [
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
                      name: airportsList[index].name,
                      tab: tabHeader(
                          false, airportsList[index].name ?? '', context),
                      page: WAiportDetailsPage(
                        airport: airportsList[index],
                      ),
                      shortname: airportsList[index].name ?? '',
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
          child: ElevatedButton(
            onPressed: () {
              closeTab("Airports", context);
            },
            child: const Text('Exit'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.redColor)),
          ),
        ),
      ]),
    );
  }
}
