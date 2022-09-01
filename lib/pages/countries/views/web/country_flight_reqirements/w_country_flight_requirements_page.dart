import 'package:country_repository/country_repository.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/extensions/string_extension.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';
import 'package:gtm/pages/countries/bloc/flight_requirements/country_flight_requirements_bloc.dart';
import 'package:gtm/pages/countries/views/web/country_flight_reqirements/w_country_flight_requirement_details_page.dart';

class WCountryFlightRequirementsPage extends StatefulWidget {
  final Country country;

  const WCountryFlightRequirementsPage({required this.country, Key? key})
      : super(key: key);

  @override
  State<WCountryFlightRequirementsPage> createState() =>
      _WCountryFlightRequirementsPageState();
}

class _WCountryFlightRequirementsPageState
    extends State<WCountryFlightRequirementsPage> {
  final TextEditingController _searchBoxController = TextEditingController();
  final FlightRequirementsDataTableSource _datatableSource =
      FlightRequirementsDataTableSource();
  int rowsPerPage = 100;

  @override
  void didChangeDependencies() {
    _datatableSource.context = context;
    fetchFlightRequirements();
    super.didChangeDependencies();
  }

  fetchFlightRequirements() {
    CountryFlightRequirementsBloc countryFlightRequirements =
        BlocProvider.of<CountryFlightRequirementsBloc>(context);
    countryFlightRequirements
        .add(FetchFlightRequirements(widget.country.countryId ?? 0));
  }

  searchFlightRequirements({String searchText = ''}) {
    CountryFlightRequirementsBloc countryFlightRequirements =
        BlocProvider.of<CountryFlightRequirementsBloc>(context);
    countryFlightRequirements
        .add(SearchFlightRequirements(searchText: searchText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CountryFlightRequirementsBloc,
          CountryFlightRequirementState>(
        listener: (context, state) {
          if (state.status == FetchFlightRequirementsStatus.success) {
            if (state.flightRequirements != null) {
              _datatableSource.setData(state.flightRequirements!);
            }
          }
        },
        child: BlocBuilder<CountryFlightRequirementsBloc,
            CountryFlightRequirementState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: () {
                  if (state.status == FetchFlightRequirementsStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.flightRequirements == null) {
                    return getNoData();
                  }

                  if (state.flightRequirements!.isEmpty) {
                    return getNoData();
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _searchBoxController,
                          onChanged: (value) {
                            searchFlightRequirements(searchText: value);
                          },
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Text('Search'.translate()),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (_searchBoxController.text.isNotEmpty) {
                                      _searchBoxController.clear();
                                      searchFlightRequirements();
                                    }
                                  },
                                  icon: const Icon(Icons.clear))),
                        ),
                      ),
                      Expanded(
                        child: PaginatedDataTable2(
                          columns: [
                            getDataColumn('Flight Category'.translate()),
                            getDataColumn('Services'.translate()),
                            getDataColumn('Through'.translate()),
                            getDataColumn('Lead Time'.translate()),
                            getDataColumn('Permit Validity'.translate()),
                            getDataColumn('Required'.translate()),
                          ],
                          source: _datatableSource,
                          rowsPerPage: rowsPerPage,
                        ),
                      ),
                    ],
                  );
                }()),
              ],
            );
          },
        ),
      ),
    );
  }

  getNoData() {
    return Center(
      child: Text('noDataFound'.translate()),
    );
  }

  getDataColumn(String label) {
    return DataColumn2(
      label: Text(label,
          style: const TextStyle(color: AppColors.dataTableColumnHeaderColor)),
      size: ColumnSize.L,
    );
  }
}

class FlightRequirementsDataTableSource extends DataTableSource {
  setData(List<FlightRequirement> _dataSource) {
    data.clear();
    data.addAll(_dataSource);
    totalRows = data.length;
    notifyListeners();
  }

  int totalRows = 0;
  List<FlightRequirement> data = [];
  late BuildContext context;

  @override
  DataRow? getRow(int index) {
    if (index < data.length) {
      FlightRequirement e = data[index];
      String required = '';
      if (e.reqSpecPermit == null) {
        required = '';
      } else if (e.reqSpecPermit!) {
        required = 'Yes';
      } else {
        required = 'No';
      }

      String flightCategory =
          e.flightCategories == null ? '' : e.flightCategories!.join(',');
      String services = e.services == null ? '' : e.services!.join(',');

      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(
            Text(flightCategory),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return WCountryFlightRequirementsDetailsPage(flightRequirement: e,);
                },fullscreenDialog: true
              ));
            },
          ),
          DataCell(Text(services)),
          DataCell(Text(e.through ?? '')),
          DataCell(Text(e.leadTime ?? '')),
          DataCell(Text(e.permValidity ?? '')),
          DataCell(Text(required)),
        ],
      );
    } else {
      return const DataRow(cells: [
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ]);
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalRows;

  @override
  int get selectedRowCount => 0;
}
