import 'package:country_repository/country_repository.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/countries.dart';
import 'package:gtm/pages/countries/views/mobile/m_countries_page.dart';

class MCountriesFlightRequirement extends StatefulWidget {
  const MCountriesFlightRequirement({Key? key}) : super(key: key);

  @override
  State<MCountriesFlightRequirement> createState() =>
      _MCountriesFlightRequirementState();
}

class _MCountriesFlightRequirementState
    extends State<MCountriesFlightRequirement> {
  final List<Country> _countries = <Country>[];
  final TextEditingController _searchBoxController = TextEditingController();
  final CountriesDataTableSource _datatableSource = CountriesDataTableSource();
  int rowsPerPage = 100;
  List<Country>? countries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomFilter(),
        body: SingleChildScrollView(
            child: SizedBox(
          height: 1500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Search', prefixIcon: Icon(Icons.search)),
                ),
              ),
              Container(
                height: spacing44,
                color: AppColors.defaultColor,
                child: Row(children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Country - United Arab Emirates',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                ]),
              ),
              Container(
                height: spacing44,
                color: AppColors.brightPink,
                child: Row(children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Flight Category - Non-Sched',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.expand_less)),
                ]),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MCountriesPage()),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Services'),
                          ),
                          Expanded(child: Text('APIS Inboun…'))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Through'),
                          ),
                          Expanded(child: Text('Direct'))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Lead Time'),
                          ),
                          Expanded(child: Text('1 Day'))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Permit Validity'),
                          ),
                          Expanded(child: Text('null hours'))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Required'),
                          ),
                          Expanded(child: Text('-'))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: spacing44,
                color: AppColors.brightPink,
                child: Row(children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Flight Category- Private Non.. ',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.expand_less)),
                ]),
              ),
              Container(
                height: spacing44,
                color: AppColors.brightPink,
                child: Row(children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Flight Category- Private Non..',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.expand_less)),
                ]),
              ),
              Container(
                height: spacing44,
                color: AppColors.brightPink,
                child: Row(children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Flight Category- Private Non..',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.expand_less)),
                ]),
              ),
              Container(
                height: spacing44,
                color: AppColors.defaultColor,
                child: Row(children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Country-United Arab Emirates',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.expand_less)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Flight Category'),
                  controller: TextEditingController()
                    ..text = 'Private Non Revenue Part9',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: TextEditingController()
                          ..text = 'APIS Inbound',
                        decoration: const InputDecoration(
                          labelText: 'Services',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: TextEditingController()..text = 'Through',
                        decoration: const InputDecoration(labelText: 'Direct'),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.powderBlue),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.powderBlue),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                      width: 112,
                                      height: 36,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('FPL MATCH'),
                                      )),
                                  VerticalDivider(),
                                  Icon(
                                    Icons.cancel_outlined,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.powderBlue),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                      width: 112,
                                      height: 36,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Specific'),
                                      )),
                                  VerticalDivider(),
                                  Icon(
                                    Icons.cancel_outlined,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.powderBlue),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                      width: 112,
                                      height: 36,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Document Required'),
                                      )),
                                  VerticalDivider(),
                                  Icon(
                                    Icons.cancel_outlined,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.powderBlue),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                      width: 112,
                                      height: 36,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('English'),
                                      )),
                                  VerticalDivider(),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: TextEditingController()..text = '1 Days',
                        decoration: const InputDecoration(
                          labelText: 'Lead Time',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: TextEditingController()
                          ..text = 'Not Available',
                        decoration:
                            const InputDecoration(labelText: 'Permit Validity'),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Required'),
                  controller: TextEditingController()..text = 'Not Available',
                ),
              ),
            ],
          ),
        )));
  }

  getDataColumn(String label) {
    return DataColumn2(
      label: Text(label,
          style: const TextStyle(color: AppColors.dataTableColumnHeaderColor)),
      size: ColumnSize.L,
    );
  }

  Widget bottomFilter() {
    return Container(
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      child: Column(children: [
                        Container(
                          color: AppColors.defaultColor,
                          height: 48,
                          child: Row(children: const [
                            Expanded(
                                child: Text(
                              'Columns',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            )
                          ]),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 48,
                          child: Row(children: const [
                            Expanded(child: Text('Name')),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.expand_circle_down),
                            )
                          ]),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 48,
                          child: Row(children: const [
                            Expanded(child: Text('Customers')),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.expand_circle_down),
                            )
                          ]),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 48,
                          child: Row(children: const [
                            Expanded(child: Text('Positions')),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.expand_circle_down),
                            )
                          ]),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 48,
                          child: Row(children: const [
                            Expanded(child: Text('Residence')),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.expand_circle_down),
                            )
                          ]),
                        ),
                      ]),
                      height: 350,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                    );
                  },
                );
              },
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.filter_alt),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'FILTERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.menu),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'COLUMNS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF4527a0),
              Color(0xFF7b1fa2),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}

class CountriesDataTableSource extends DataTableSource {
  setData(List<Country> _dataSource) {
    data.clear();
    data.addAll(_dataSource);
    totalRows = data.length;
    notifyListeners();
  }

  int totalRows = 0;
  List<Country> data = [];
  late BuildContext context;

  @override
  DataRow? getRow(int index) {
    if (index < data.length) {
      Country e = data[index];
      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(
            Text(getFlag(e.code ?? '') + ' ' + e.name),
            onTap: () {
              showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext buildContext,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return Padding(
                    padding: const EdgeInsets.all(50),
                    child: WCountryDetailsPage(
                      country: e,
                    ),
                  );
                },
              );
              //showGeneralDialog(context: context, pageBuilder: pageBuilder);
            },
          ),
          DataCell(Text(e.code3 ?? '')),
          DataCell(Text(e.code ?? '')),
          DataCell(Text(e.capitalCity ?? '')),
          DataCell(Text(e.currencyCode ?? '')),
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

  getFlag(String countryCode) {
    try {
      return countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    } catch (e) {
      return '';
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalRows;

  @override
  int get selectedRowCount => 0;
}
