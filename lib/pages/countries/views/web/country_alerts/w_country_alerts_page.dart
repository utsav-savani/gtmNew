import 'package:country_repository/country_repository.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/extensions/string_extension.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:gtm/pages/countries/bloc/alerts/country_alerts_bloc.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';
import 'package:gtm/pages/countries/views/web/country_alerts/w_country_alert_details_page.dart';

class WCountryAlertsPage extends StatefulWidget {
  final Country country;

  const WCountryAlertsPage({required this.country, Key? key}) : super(key: key);

  @override
  State<WCountryAlertsPage> createState() => _WCountryAlertsPageState();
}

class _WCountryAlertsPageState extends State<WCountryAlertsPage> {
  final TextEditingController _searchBoxController = TextEditingController();
  final AlertsDataTableSource _datatableSource = AlertsDataTableSource();
  int rowsPerPage = 100;

  @override
  void didChangeDependencies() {
    _datatableSource.context = context;
    fetchAlerts();
    super.didChangeDependencies();
  }

  fetchAlerts() {
    CountryAlertsBLoc countryAlertsBloc =
        BlocProvider.of<CountryAlertsBLoc>(context);
    countryAlertsBloc.add(FetchCountryAlerts(widget.country.countryId ?? 0));
  }

  searchAlerts({String searchText = ''}) {
    CountryAlertsBLoc countryAlertsBloc =
        BlocProvider.of<CountryAlertsBLoc>(context);
    countryAlertsBloc.add(SearchCountryAlerts(searchText: searchText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CountryAlertsBLoc, CountryAlertsState>(
        listener: (context, state) {
          if (state.status == FetchCountryAlertStatus.success) {
            if (state.alerts != null) {
              _datatableSource.setData(state.alerts!);
            }
          }
        },
        child: BlocBuilder<CountryAlertsBLoc, CountryAlertsState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: () {
                  if (state.status == FetchCountryAlertStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.alerts == null) {
                    return getNoData();
                  }

                  if (state.alerts!.isEmpty) {
                    return getNoData();
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _searchBoxController,
                          onChanged: (value) {
                            searchAlerts(searchText: value);
                          },
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Text('Search'.translate()),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (_searchBoxController.text.isNotEmpty) {
                                      _searchBoxController.clear();
                                      searchAlerts();
                                    }
                                  },
                                  icon: const Icon(Icons.clear))),
                        ),
                      ),
                      Expanded(
                        child: PaginatedDataTable2(
                          columns: [
                            getDataColumn('Category'.translate()),
                            getDataColumn('Type'.translate()),
                            getDataColumn('Start Date'.translate()),
                            getDataColumn('End Date'.translate()),
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

class AlertsDataTableSource extends DataTableSource {
  setData(List<Alert> _dataSource) {
    data.clear();
    data.addAll(_dataSource);
    totalRows = data.length;
    notifyListeners();
  }

  int totalRows = 0;
  List<Alert> data = [];
  late BuildContext context;

  @override
  DataRow? getRow(int index) {
    if (index < data.length) {
      Alert e = data[index];
      String category = e.category == null ? '' : e.category!.join(',');
      String type = e.type == null ? '' : e.type!.join(',');
      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(
            Text(category),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return WCountryAlertDetailsPage(
                      alert: e,
                    );
                  },
                  fullscreenDialog: true));
            },
          ),
          DataCell(Text(type)),
          DataCell(Text(e.startDate)),
          DataCell(Text(e.endDate ?? '')),
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
