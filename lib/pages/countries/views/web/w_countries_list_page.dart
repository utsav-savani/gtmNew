import 'package:country_repository/country_repository.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';
import 'package:gtm/pages/countries/bloc/country_list/country_bloc.dart';
import 'package:gtm/pages/countries/views/web/w_country_details_page.dart';
import 'package:gtm/pages/home/models/gtm_tab.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/home/view/web/components/tab_header.dart';

class WCountriesListPage extends StatefulWidget {
  const WCountriesListPage({Key? key}) : super(key: key);

  @override
  State<WCountriesListPage> createState() => _WCountriesListPageState();
}

class _WCountriesListPageState extends State<WCountriesListPage> {
  final TextEditingController _searchBoxController = TextEditingController();
  ScrollController mainListController = ScrollController();
  int rowsPerPage = 100;
  List<Country>? _countriesList;
  List<String> tableColumns = [
    'Country',
    '3-ISO',
    '2-ISO',
    'Capital City',
    'Currency'
  ];
  List<double> tableColumnsWidth = [0, 100, 100, 0, 100];

  @override
  void didChangeDependencies() {
    fetchCountries();
    super.didChangeDependencies();
  }

  fetchCountries() {
    CountryBloc countryBloc = BlocProvider.of<CountryBloc>(context);
    countryBloc.add(const FetchCountryList());
  }

  searchCountries({String searchText = ''}) {
    CountryBloc countryBloc = BlocProvider.of<CountryBloc>(context);
    countryBloc.add(SearchCountries(searchText: searchText));
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final bool _isWeb = MediaQuery.of(context).size.width >= web;
    return Scaffold(
      body: BlocListener<CountryBloc, CountryListState>(
        listener: (context, state) {},
        child: BlocBuilder<CountryBloc, CountryListState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            if (state.status == FetchCountryStatus.loading) {
              return loadingWidget();
            }
            if (state.status == FetchCountryStatus.initial) {}
            if (state.status == FetchCountryStatus.success) {
              if (state.countries != null && state.countries!.isNotEmpty) {
                _countriesList = state.countries;
              }
            }
            _countriesList!.sort((a, b) {
              return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
            });
            List<List<Widget>> rows = [];
            for (var val in _countriesList!) {
              rows.add([
                appText(
                  getFlag(val.code ?? '') + ' ' + val.name,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.code3,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.code,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.capitalCity,
                  color: AppColors.charcoalGrey,
                ),
                appText(
                  val.currencyCode,
                  color: AppColors.charcoalGrey,
                ),
              ]);
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: searchBarHeight,
                    child: TextField(
                      controller: _searchBoxController,
                      onChanged: (value) {
                        searchCountries(searchText: value);
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(search.translate()),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (_searchBoxController.text.isNotEmpty) {
                              _searchBoxController.clear();
                              searchCountries();
                            }
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Widget actions = Container();
                                    Widget expWidget = Container();
                                    GtmTab gtmTab = GtmTab(
                                      isActive: true,
                                      name: _countriesList![index].name ??
                                          "Country",
                                      tab: tabHeader(
                                          false,
                                          _countriesList![index].name ?? "",
                                          context),
                                      page: WCountryDetailsPage(
                                        country: _countriesList![index],
                                      ),
                                      shortname:
                                          _countriesList![index].name ?? '',
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
                                      onTapAction: () =>
                                          openTab(gtmTab, context),
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
                              closeTab("Countries", context);
                            },
                            child: const Text('Exit'),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.redColor)),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            );
          },
        ),
      ),
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
