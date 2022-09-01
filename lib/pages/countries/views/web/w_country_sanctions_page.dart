import 'package:country_repository/country_repository.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/countries.dart';

class WCountrySanctionsPage extends StatefulWidget {
  final Country country;

  const WCountrySanctionsPage({required this.country, Key? key})
      : super(key: key);

  @override
  State<WCountrySanctionsPage> createState() => _WCountrySanctionsPageState();
}

class _WCountrySanctionsPageState extends State<WCountrySanctionsPage> {
  final TextEditingController _searchBoxController = TextEditingController();
  final SanctionsDataTableSource _datatableSource = SanctionsDataTableSource();
  int rowsPerPage = 100;
  List<Sanction>? _sanctionsRes;

  @override
  void didChangeDependencies() {
    _datatableSource.context = context;
    fetchSanctions();
    super.didChangeDependencies();
  }

  fetchSanctions() {
    context
        .read<CountrySanctionsCubit>()
        .getCountrySanctions(widget.country.countryId!);
  }

  searchSanctions(String searchText, bool? clear) {
    context
        .read<CountrySanctionsCubit>()
        .searchCountrySanctions(searchText, clear!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CountrySanctionsCubit, CountrySanctionsState>(
        listener: (context, state) {
          /// only for showing dialog and scaffold messenger
        },
        child: BlocBuilder<CountrySanctionsCubit, CountrySanctionsState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            if (state.status == FetchSanctionStatus.success) {
              if (state.sanctions != null) {
                _sanctionsRes = state.sanctions!;
                _datatableSource.setData(state.sanctions!);
              }
            }
            if (state.status == FetchSanctionStatus.searchSuccess) {
              if (state.sanctions != null) {
                _sanctionsRes = state.sanctions!;
                _datatableSource.setData(state.sanctions!);
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: () {
                  if (state.status == FetchSanctionStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _searchBoxController,
                          onChanged: (value) {
                            Future.delayed(const Duration(seconds: 400));
                            searchSanctions(value, false);
                          },
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Text(search.translate()),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    if (_searchBoxController.text.isNotEmpty) {
                                      _searchBoxController.clear();
                                      searchSanctions('', true);
                                    }
                                  },
                                  icon: const Icon(Icons.clear))),
                        ),
                      ),
                      state.sanctions!.isEmpty
                          ? getNoData()
                          : Expanded(
                              child: PaginatedDataTable2(
                                columns: [
                                  getDataColumn(fromDate.translate()),
                                  getDataColumn(toDate.translate()),
                                  getDataColumn(adoptedBy.translate()),
                                  getDataColumn(details.translate()),

                                  /// as clarified with nithesh we hide this column named action
                                  /// getDataColumn(action.translate()),
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
      child: Text(noSanctionsFound.translate()),
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

class SanctionsDataTableSource extends DataTableSource {
  setData(List<Sanction> _dataSource) {
    data.clear();
    data.addAll(_dataSource);
    totalRows = data.length;
    notifyListeners();
  }

  int totalRows = 0;
  List<Sanction?> data = [];
  late BuildContext context;

  @override
  DataRow? getRow(int index) {
    if (index < data.length) {
      Sanction e = data[index]!;
      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text(e.startDate)),
          DataCell(Text(e.endDate ?? notAvailable)),
          DataCell(Text(removeBrackets(e.adopter.toString()))),
          DataCell(Text(removeBrackets(e.details.toString()))),
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

  String removeBrackets(String? removeBrackets) {
    if (removeBrackets!.isNotEmpty) {
      String replace = removeBrackets.substring(1, removeBrackets.length - 1);
      return replace;
    } else {
      return removeBrackets;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalRows;

  @override
  int get selectedRowCount => 0;
}
