import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gtm/_shared/constants/string_constants.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/widget_size.dart';
import 'package:gtm/_shared/widgets/custom_radio_tile.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/home/cubit/tab_cubit/tab_cubit.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_state.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_state.dart';
import 'package:gtm/pages/home/dashboard/dashboard_event.dart';
import 'package:gtm/pages/home/dashboard/view/mobile/m_trip_manager_landing_screen.dart';
import 'package:gtm/pages/home/models/gtm_tab.dart';
import 'package:gtm/pages/home/view/mobile/_partials/create_trip_modal_widget.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/home/view/web/components/tab_header.dart';
import 'package:gtm/pages/manage_trip/view/manage_trip.dart';
import 'package:gtm/responsive/orientation_layout.dart';
import 'package:gtm/responsive/screen_type_layout.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripDashboardV2 extends StatefulWidget {
  final TabController tabController;
  final IntCallback tabControllerIndex;

  const TripDashboardV2({
    Key? key,
    required this.tabController,
    required this.tabControllerIndex,
  }) : super(key: key);

  @override
  State<TripDashboardV2> createState() => _TripDashboardV2State();
}

class _TripDashboardV2State extends State<TripDashboardV2> with AutomaticKeepAliveClientMixin {
  late TripBloc mTripBloc;
  late List<GtmTab> _gtmTabLocalList;
  late TripsDataSource tripsDataSource;

  @override
  void didChangeDependencies() {
    mTripBloc = BlocProvider.of(context);
    mTripBloc.add(const FetchTrips());
    tripsDataSource = TripsDataSource(tripBloc: mTripBloc);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScreenTypeLayout(
      mobile: _buildMobile(context),
      tablet: OrientationLayout(
        landscape: (p0) => _buildWeb(context),
        portrait: (p0) => _buildMobile(context),
      ),
      desktop: _buildWeb(context),
    );
  }

  Widget _buildWeb(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabCubit, TabState>(
        builder: (context, state) {
          if (state is TabSuccess) {
            _gtmTabLocalList = state.gtmTabList;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTripMangerText(),
              _buildFilter(),
              _buildSearchBar(),
              _buildTripsTable(),
              _buildCreateTripButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return const MTripManagerLandingScreen();
  }

  Widget _buildTripMangerText() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        'Trip Manager',
        style: Theme.of(context).textTheme.headline2!.merge(
              TextStyle(
                color: AppColors.alternateButtonColor,
                fontSize: spacing36,
              ),
            ),
      ),
    );
  }

  Widget _buildFilter() {
    SearchBy? searchBy = SearchBy.schedule;
    Period? period = Period.today;
    DateTime? fromDate, toDate;
    TextEditingController fromDateController = TextEditingController(), toDateController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    CustomWidgets().buildDropdown(
                      label: 'Search By',
                      hint: 'Select',
                      items: SearchBy.values.map<DropdownMenuItem<SearchBy>>((SearchBy value) {
                        return DropdownMenuItem<SearchBy>(
                          value: value,
                          child: Text(TripBloc.getSearchByString(value)),
                        );
                      }).toList(),
                      onChanged: (SearchBy? v) {
                        searchBy = v;
                      },
                      value: searchBy,
                      maxWidth: 130,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() async {
                              fromDate = await AppHelper().pickDate(context);
                              if (fromDate != null) {
                                fromDateController.text = TripBloc.dateFormat.format(fromDate!);
                              }
                            });
                          },
                          child: CustomWidgets().buildConstrainedTextFormField(
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                label: Text('From'),
                                suffixIcon: Icon(Icons.calendar_month_outlined),
                              ),
                              controller: fromDateController,
                            ),
                            maxWidth: 180,
                          ),
                        ),
                        const Padding(
                          child: Text('To'),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        InkWell(
                          onTap: () async {
                            toDate = await AppHelper().pickDate(context);
                            setState(() {
                              if (toDate != null) {
                                toDateController.text = TripBloc.dateFormat.format(toDate!);
                              }
                            });
                          },
                          child: CustomWidgets().buildConstrainedTextFormField(
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                label: Text('To'),
                                suffixIcon: Icon(Icons.calendar_month_outlined),
                              ),
                              controller: toDateController,
                            ),
                            maxWidth: 180,
                          ),
                        ),
                      ],
                    ),
                    CustomWidgets().buildDropdown(
                      label: 'Period',
                      hint: 'Select',
                      items: Period.values.map<DropdownMenuItem<Period>>((Period value) {
                        return DropdownMenuItem<Period>(
                          value: value,
                          child: Text(TripBloc.getPeriodString(value)),
                        );
                      }).toList(),
                      onChanged: (Period? v) {
                        period = v;
                      },
                      value: period,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (searchBy == null) {
                                AppHelper().showSnackBar(context, message: 'Select Search By');
                                return;
                              }
                              if (fromDate == null) {
                                AppHelper().showSnackBar(context, message: 'Select From Date');
                                return;
                              }
                              if (toDate == null) {
                                AppHelper().showSnackBar(context, message: 'Select To Date');
                                return;
                              }
                              mTripBloc.add(FilterTripsByDate(fromDate: fromDate!, searchBy: searchBy!, toDate: toDate!));
                              refreshTripStatistics();
                            },
                            child: const Text('Filter')),
                        TextButton(
                            onPressed: () {
                              fromDateController.clear();
                              toDateController.clear();
                              mTripBloc.add(const FetchTrips());
                            },
                            child: const Text('Clear')),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          _buildTripStatistics(),
        ],
      ),
    );
  }

  Widget _buildTripStatistics() {
    String? _selectedItem = TripBloc.total;
    return BlocBuilder<TripStatisticBloc, TripStatisticsState>(
      builder: (context, state) {
        TripStatistic tripStatistic = state.tripStatistic ?? const TripStatistic(total: 0, completed: 0, inProgress: 0, draft: 0, cancelled: 0);
        switch (state.status) {
          case FetchTripStatisticsStatus.initial:
          case FetchTripStatisticsStatus.loading:
          case FetchTripStatisticsStatus.success:
            return StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  children: [
                    CustomRadioListTile(
                        value: tripStatistic.total,
                        groupValue: _selectedItem,
                        onChanged: (value) {
                          if (state.status != FetchTripStatisticsStatus.success) {
                            return;
                          }
                          mTripBloc.add(const FilterByTripStatistics(tripStatisticType: TripStatisticType.total));
                          setState(() => _selectedItem = value);
                        },
                        title: 'Total',
                        color: AppColors.lightBlueGrey),
                    CustomRadioListTile(
                      value: tripStatistic.draft,
                      groupValue: _selectedItem,
                      onChanged: (value) {
                        if (state.status != FetchTripStatisticsStatus.success) {
                          return;
                        }
                        mTripBloc.add(const FilterByTripStatistics(tripStatisticType: TripStatisticType.draft));
                        setState(() => _selectedItem = value);
                      },
                      title: 'Draft',
                      color: AppColors.palePeach,
                    ),
                    CustomRadioListTile(
                      value: tripStatistic.inProgress,
                      groupValue: _selectedItem,
                      onChanged: (value) {
                        if (state.status != FetchTripStatisticsStatus.success) {
                          return;
                        }
                        mTripBloc.add(const FilterByTripStatistics(tripStatisticType: TripStatisticType.inProgress));
                        setState(() => _selectedItem = value);
                      },
                      title: 'In Progress',
                      color: AppColors.apricot,
                    ),
                    CustomRadioListTile(
                      value: tripStatistic.completed,
                      groupValue: _selectedItem,
                      onChanged: (value) {
                        if (state.status != FetchTripStatisticsStatus.success) {
                          return;
                        }
                        mTripBloc.add(const FilterByTripStatistics(tripStatisticType: TripStatisticType.completed));
                        setState(() => _selectedItem = value);
                      },
                      title: 'Completed',
                      color: AppColors.tea,
                    ),
                    CustomRadioListTile(
                      value: tripStatistic.cancelled,
                      groupValue: _selectedItem,
                      onChanged: (value) {
                        if (state.status != FetchTripStatisticsStatus.success) {
                          return;
                        }
                        mTripBloc.add(const FilterByTripStatistics(tripStatisticType: TripStatisticType.cancelled));
                        setState(() => _selectedItem = value);
                      },
                      title: 'Cancelled',
                      color: AppColors.redColor,
                    ),
                  ],
                );
              },
            );
          case FetchTripStatisticsStatus.failure:
            return _buildErrorWidget();
        }
      },
    );
  }

  Widget _buildSearchBar() {
    TextEditingController searchTextController = TextEditingController();
    TripBloc tripBloc = BlocProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          color: AppColors.blueBerryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomWidgets().buildConstrainedTextFormField(
                TextFormField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      fillColor: AppColors.whiteColor,
                      filled: true,
                      suffixIcon: InkWell(
                        child: const Icon(Icons.close),
                        onTap: () {
                          searchTextController.clear();
                          tripBloc.add(const SearchTrips(searchText: ''));
                          refreshTripStatistics();
                        },
                      )),
                  onFieldSubmitted: (searchText) {
                    tripBloc.add(SearchTrips(searchText: searchText));
                    refreshTripStatistics();
                  },
                ),
                maxWidth: 520,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                  ),
                  label: const Text('Download All Listed Trips')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsTable() {
    return Expanded(
      child: BlocListener<TripBloc, TripListState>(
        listener: (context, state) {
          if (state.status == FetchTripStatus.success) {
            tripsDataSource.updateTripsTable(state.trips ?? []);
          }
        },
        child: BlocBuilder<TripBloc, TripListState>(
          builder: (BuildContext context, TripListState state) {
            switch (state.status) {
              case FetchTripStatus.initial:
              case FetchTripStatus.loading:
                return _buildCircularProgressBar();
              case FetchTripStatus.success:
                if (state.trips == null) {
                  return _buildEmptyStateWidget();
                }
                if (state.trips!.isEmpty) {
                  return _buildEmptyStateWidget();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                      headerColor: AppColors.tableHeaderColor,
                      headerHoverColor: AppColors.tableSearchBarColor,
                      rowHoverColor: AppColors.charcoalGrey,
                      rowHoverTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: SfDataGrid(
                      loadMoreViewBuilder: (BuildContext context, loadMoreRows) {
                        Future<String> loadRows() async {
                          await loadMoreRows();
                          return Future<String>.value('Completed');
                        }

                        return FutureBuilder<String>(
                            initialData: 'loading',
                            future: loadRows(),
                            builder: (context, snapShot) {
                              if (snapShot.data == 'loading') {
                                return Container(
                                    height: 60.0,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: BorderDirectional(top: BorderSide(width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.26)))),
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurple)));
                              } else {
                                return SizedBox.fromSize(size: Size.zero);
                              }
                            });
                      },
                      allowSorting: true,
                      allowMultiColumnSorting: true,
                      source: tripsDataSource,
                      headerRowHeight: 26,
                      onCellTap: (DataGridCellTapDetails details) {
                        if ((details.rowColumnIndex.rowIndex - 1) >= 0) {
                          final DataGridRow row = tripsDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1];
                          var tripNumber = row.getCells().first.value.toString();
                          Trip trip = state.trips![details.rowColumnIndex.rowIndex - 1];
                          GtmTab gtmTab = GtmTab(
                            isActive: true,
                            name: 'Trip: ' + tripNumber,
                            tab: tabHeader(false, 'Trip: ' + tripNumber, context),
                            page: ManageTrip(guid: trip.guid),
                          );
                          _openTab(gtmTab, context);
                        }
                      },
                      columns: <GridColumn>[
                        _buildColumnHeader(1, 120, tripNumber),
                        _buildColumnHeader(2, 80, regNo),
                        _buildColumnHeader(3, double.nan, operator),
                        _buildColumnHeader(4, 120, airCraftType),
                        _buildColumnHeader(5, double.nan, flightCategory),
                        _buildColumnHeader(6, 80, callsign),
                        _buildColumnHeader(7, 100, start),
                        _buildColumnHeader(8, 100, end),
                        _buildColumnHeader(9, double.nan, route),
                        _buildColumnHeader(10, 120, tripStatus),
                        _buildColumnHeader(11, 120, fileStatus),
                        _buildColumnHeader(12, 0, tripId),
                      ],
                    ),
                  ),
                );
              case FetchTripStatus.failure:
                return _buildErrorWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCreateTripButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierLabel: "",
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.8),
              useRootNavigator: true,
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, __, ___) {
                return Center(
                    child: Material(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(spacing4),
                    ),
                  ),
                  child: SizedBox(
                    height: spacing376,
                    width: spacing648,
                    child: CreateTripModalWidget(onCreateTrip: (TripDataResponse response) {
                      GtmTab gtmTab = GtmTab(
                        isActive: true,
                        name: 'New Trip',
                        tab: tabHeader(
                          false,
                          response.tripNumber,
                          context,
                        ),
                        page: ManageTrip(
                          guid: response.guid ?? '',
                        ),
                      );
                      _openTab(gtmTab, context);
                    }),
                  ),
                ));
              },
              transitionBuilder: (_, anim, __, child) {
                Tween<Offset> tween;
                if (anim.status == AnimationStatus.reverse) {
                  tween = Tween(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  );
                } else {
                  tween = Tween(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  );
                }

                return SlideTransition(
                  position: tween.animate(anim),
                  child: FadeTransition(
                    opacity: anim,
                    child: child,
                  ),
                );
              },
            );
          },
          child: const Text('Create New Trip'),
        ),
      ),
    );
  }

  GridColumn _buildColumnHeader(int columnId, double minWidth, String columnDisplayName) {
    return GridColumn(
      width: minWidth,
      columnName: columnId.toString(),
      label: Container(
        padding: const EdgeInsets.all(2),
        alignment: Alignment.centerLeft,
        child: appText(
          columnDisplayName,
          color: Colors.white,
        ),
      ),
      columnWidthMode: ColumnWidthMode.fill,
      visible: columnId == 12 ? false : true,
    );
  }

  Widget _buildCircularProgressBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text('Internal Error Occurred'),
    );
  }

  Widget _buildEmptyStateWidget() {
    return const Center(
      child: Text('No Trips found'),
    );
  }

  void refreshTripStatistics() {
    TripStatisticBloc tripStatisticBloc = BlocProvider.of(context);
    tripStatisticBloc.add(const FetchTripStatistics());
  }

  void _openTab(gtmTab, context) async {
    openTab(gtmTab, context);
    final int index = _gtmTabLocalList.indexWhere((element) => element.name == gtmTab.name);
    final int _val = index >= 0 ? index : _gtmTabLocalList.length - 1;
    widget.tabControllerIndex(_val);

    // final int index = _gtmTabLocalList.indexWhere((element) => element.name == gtmTab.name);
    // if (index >= 0) {
    //   if (widget.tabController.index != index) {
    //     // send value to callback
    //     widget.tabControllerIndex(index);
    //   }
    // } else {
    //   // send value to callback
    //   widget.tabControllerIndex(_gtmTabLocalList.length - 1);
    // }
  }

  @override
  bool get wantKeepAlive => true;
}

class TripsDataSource extends DataGridSource {
  TripsDataSource({required this.tripBloc});

  TripBloc tripBloc;
  final List<Trip> _trips = [];
  List<DataGridRow> _tripsData = [];

  @override
  Future<void> handleLoadMoreRows() async {
    List<Trip> trips = await tripBloc.loadMore();
    _trips.addAll(trips);
    _buildDataGridRows();
    notifyListeners();
  }


  @override
  List<DataGridRow> get rows => _tripsData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int index = effectiveRows.indexOf(row);
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        // final Alignment alignment = (e.columnName == '3' || e.columnName == '5' || e.columnName == '9') ?
        // Alignment.centerLeft : Alignment.center;

        const Alignment alignment = Alignment.centerLeft;

        Widget cell = Builder(
          builder: (context) {
            if (e.columnName == '10' || e.columnName == '11') {
              return Container(
                width: 116,
                height: 28,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: getStatusColor(e.value),
                  border: Border.all(
                    color: getStatusColor(e.value),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                alignment: Alignment.center,
                child: textValue(
                  e.value.toString(),
                  color: e.value.toString() == 'Draft' ? Colors.black : Colors.white,
                ),
              );
            } else if (e.columnName == '7' || e.columnName == '8') {
              return textValue(
                convertDateStringToHumanReadableFormat(e.value.toString()),
                color: AppColors.greyCellText,
              );
            } else {
              return textValue(
                e.value.toString(),
                color: AppColors.greyCellText,
              );
            }
          },
        );

        final Widget cellItem = (e.columnName == '10' || e.columnName == '11')
            ? Container(
                width: 116,
                height: 28,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: getStatusColor(e.value),
                  border: Border.all(
                    color: getStatusColor(e.value),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                alignment: Alignment.center,
                child: textValue(
                  e.value.toString(),
                  color: e.value.toString() == 'Draft' ? Colors.black : Colors.white,
                ),
              )
            : textValue(
                e.value.toString(),
                color: AppColors.greyCellText,
              );
        return Container(
          color: (index % 2 != 0) ? AppColors.greyRowOdd : AppColors.greyRowEven,
          alignment: alignment,
          padding: const EdgeInsets.all(4),
          child: cell,
        );
      }).toList(),
    );
  }

  void _buildDataGridRows() {
    _tripsData = _trips
        .map<DataGridRow>((Trip e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: '1', value: e.tripNumber),
              DataGridCell<String>(columnName: '2', value: e.regNo),
              DataGridCell<String>(columnName: '3', value: e.operator),
              DataGridCell<String>(columnName: '4', value: e.acType),
              DataGridCell<String>(columnName: '5', value: e.flightCategory.toUpperCase()),
              DataGridCell<String>(columnName: '6', value: e.callsign),
              DataGridCell<String>(columnName: '7', value: e.start),
              DataGridCell<String>(columnName: '8', value: e.end),
              DataGridCell<String>(
                columnName: '9',
                value: arrayToCommaSeperated(arr: e.route!),
              ),
              DataGridCell<String>(columnName: '10', value: e.tripStatus),
              DataGridCell<String>(columnName: '11', value: e.fileStatus),
              DataGridCell<int>(columnName: '12', value: e.tripId),
            ]))
        .toList();
  }

  void updateTripsTable(List<Trip> tripsData) {
    _trips.clear();
    _trips.addAll(tripsData);
    _buildDataGridRows();
    notifyListeners();
  }
}
