import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/models/gtm_tab.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/home/view/web/components/tab_header.dart';
import 'package:gtm/pages/people/cubit/people_cubit.dart';
import 'package:gtm/pages/people/views/web/w_person_page.dart';
import 'package:people_repository/people_repository.dart';

class WPeopleListPage extends StatefulWidget {
  const WPeopleListPage({Key? key}) : super(key: key);

  @override
  State<WPeopleListPage> createState() => _WPeopleListPageState();
}

class _WPeopleListPageState extends State<WPeopleListPage> {
  final TextEditingController _searchBoxController = TextEditingController();
  List<People>? peopleList;
  bool isFirstCall = true;
  List<People>? searchList;
  Set<String> customers = {};

  @override
  void didChangeDependencies() {
    fetchPeople();
    super.didChangeDependencies();
  }

  fetchPeople() {
    context.read<PeopleCubit>().getPeople();
  }

  searchPeopleFromList() {
    if (peopleList != null &&
        peopleList!.isNotEmpty &&
        _searchBoxController.text.isNotEmpty) {
      List<People> temp = [];
      for (int i = 0; i < peopleList!.length; i++) {
        if (peopleList![i].name!.contains(_searchBoxController.text)) {
          temp.add(peopleList![i]);
        }
      }
      searchList = temp;
    } else {
      searchList = peopleList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool _isWeb = MediaQuery.of(context).size.width >= web;
    return Scaffold(
      body: BlocListener<PeopleCubit, PeopleState>(
        listener: (context, state) {},
        child: BlocBuilder<PeopleCubit, PeopleState>(
          builder: (context, state) {
            if (state.status == FetchPeopleStatus.loading) {
              return loadingWidget();
            }
            if (state.status == FetchPeopleStatus.success) {
              peopleList = state.people;
              if (isFirstCall) {
                searchList = peopleList;
                isFirstCall = false;
              }
              customers =
                  state.customers.map((e) => e.name.toLowerCase()).toSet();
            }
            return Column(
              children: [
                peopleList != null
                    ? Expanded(
                        child: _isWeb
                            ? _buildPeoplesTable()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: 1200,
                                  child: _buildPeoplesTable(),
                                ),
                              ),
                      )
                    : const Center(child: CircularProgressIndicator())
              ],
            );
          },
        ),
      ),
    );
  }

  _buildPeoplesTable() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(spacing8),
          child: TextField(
            controller: _searchBoxController,
            onChanged: (value) {
              searchPeopleFromList();
              setState(() {});
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text('Search'.translate()),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (_searchBoxController.text.isNotEmpty) {
                        _searchBoxController.clear();
                      }
                    },
                    icon: const Icon(Icons.clear))),
          ),
        ),
        Expanded(
          child: PeopleCustomListView(
            data: searchList,
            customers: customers,
          ),
        ),
      ],
    );
  }
}

class PeopleCustomListView extends StatefulWidget {
  const PeopleCustomListView(
      {Key? key, required this.data, required this.customers})
      : super(key: key);

  final List<People>? data;
  final Set<String> customers;
  @override
  State<PeopleCustomListView> createState() => _PeopleCustomListViewState();
}

class _PeopleCustomListViewState extends State<PeopleCustomListView> {
  ScrollController mainListController = ScrollController();
  List<String> tableColumns = [
    'Name',
    'Customers',
    'Positions',
    'Residence',
    'Action'
  ];
  List<double> tableColumnsWidth = [
    0,
    0,
    200,
    200,
    200,
  ];

  @override
  Widget build(BuildContext context) {
    List<People> _peopleList = widget.data ?? [];
    List<List<Widget>> rows = [];
    _peopleList.sort((a, b) {
      return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
    });

    for (var val in _peopleList) {
      List<String> customers = [];
      if (val.customers != null) {
        for (int i = 0; i < val.customers!.length; i++) {
          if (widget.customers.contains(val.customers![i].toLowerCase())) {
            customers.add(val.customers![i]);
          }
        }
      }
      rows.add([
        appText(val.name, color: AppColors.charcoalGrey),
        appText(customers.join(', '), color: AppColors.charcoalGrey),
        appText(val.roles != null ? val.roles!.join(', ') : '',
            color: AppColors.charcoalGrey),
        appText(val.nationality, color: AppColors.charcoalGrey),
        appText('', color: AppColors.charcoalGrey),
      ]);
    }
    log("List size: " + _peopleList.length.toString());
    log("Table size: " + rows.length.toString());
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
                        name: _peopleList[index].name ?? '',
                        tab: tabHeader(
                            false, _peopleList[index].name ?? '', context),
                        page: WPersonPage(people: _peopleList[index]),
                        shortname: _peopleList[index].name ?? '',
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
                      name: newCrew,
                      tab: tabHeader(false, newCrew, context),
                      page: const WPersonPage(
                        isPassenger: false,
                      ),
                      shortname: newCrew,
                    );
                    openTab(gtmTab, context);
                  },
                  child: const Text(newCrew),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppColors.tableSearchBarColor)),
                ),
                width(10),
                ElevatedButton(
                  onPressed: () {
                    GtmTab gtmTab = GtmTab(
                      isActive: true,
                      name: newPassenger,
                      tab: tabHeader(false, newPassenger, context),
                      page: const WPersonPage(
                        isPassenger: true,
                      ),
                      shortname: newCrew,
                    );
                    openTab(gtmTab, context);
                  },
                  child: const Text(newPassenger),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppColors.tableSearchBarColor)),
                ),
                width(10),
                ElevatedButton(
                  onPressed: () {
                    closeTab("People", context);
                  },
                  child: const Text('Exit'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.redColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
