import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/home.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/home/view/web/components/tab_header.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripDashboardData extends StatefulWidget {
  final TabController tabController;
  final IntCallback tabControllerIndex;

  const TripDashboardData({
    Key? key,
    required this.tabController,
    required this.tabControllerIndex,
  }) : super(key: key);

  @override
  _TripDashboardData createState() => _TripDashboardData();
}

class _TripDashboardData extends State<TripDashboardData> {
  List<Trip>? tripList;

  int totalTrips = 0;

  late TabController _tabController;

  late Map<String, double> columnWidths = {
    '1': double.nan,
    '2': double.nan,
    '3': double.nan,
    '4': double.nan,
    '5': double.nan,
    '6': double.nan,
    '7': double.nan,
    '8': double.nan,
    '9': double.nan,
    '10': double.nan,
    '11': double.nan,
    '12': double.nan,
  };

  late List<GtmTab> _gtmTabLocalList;

  @override
  Widget build(BuildContext context) {
    _tabController = widget.tabController;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is DashboardSuccess) {
          tripList = state.tripList;
          totalTrips = tripList!.length;
        }
        return BlocBuilder<TabCubit, TabState>(
          builder: (context, state) {
            if (state is TabSuccess) {
              _gtmTabLocalList = state.gtmTabList;
            } else if (state is TabFailure) {
              debugPrint('failed to load on the front end');
            }
            return tripList == null
                ? const Center(child: CircularProgressIndicator())
                : tripList!.isNotEmpty
                    ? _buildTripsTable(tripList)
                    : appText(emptyData);
          },
        );
      },
    );
  }

  void _openTab(gtmTab, context) async {
    openTab(gtmTab, context);
    final int index = _gtmTabLocalList.indexWhere((element) => element.name == gtmTab.name);
    final int _val = index >= 0 ? index : _gtmTabLocalList.length - 1;
    widget.tabControllerIndex(_val);
  }

  Widget _buildTripsTable(tripList) {
    var tripsDataSource = TripsDataSource(tripsData: tripList);
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: AppColors.tableHeaderColor,
        headerHoverColor: AppColors.tableSearchBarColor,
        rowHoverColor: AppColors.charcoalGrey,
        rowHoverTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      child: SfDataGrid(
        allowSorting: true,
        allowMultiColumnSorting: true,
        source: tripsDataSource,
        //columnResizeMode: ColumnResizeMode.onResizeEnd,
        //allowColumnsResizing: true,
        headerRowHeight: tripManagerListHeaderRowHeight,
        onCellTap: (DataGridCellTapDetails details) {
          if ((details.rowColumnIndex.rowIndex - 1) >= 0) {
            final DataGridRow row = tripsDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1];
            var tripNumber = row.getCells().first.value.toString();
            Trip trip = tripList[details.rowColumnIndex.rowIndex - 1];
            GtmTab gtmTab = GtmTab(
              isActive: true,
              name: 'Trip: ' + tripNumber,
              tab: tabHeader(false, 'Trip: ' + tripNumber, context),
              page: ManageTrip(guid: trip.guid),
            );
            _openTab(gtmTab, context);
          }
        },
        onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
          setState(() {
            columnWidths[details.column.columnName] = details.width;
          });
          return true;
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
    );
  }

  _buildColumnHeader(int columnId, double minWidth, String columnDisplayName) {
    return GridColumn(
      width: minWidth,
      columnName: columnId.toString(),
      label: Container(
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        child: appText(
          columnDisplayName,
          color: Colors.white,
        ),
      ),
      columnWidthMode: ColumnWidthMode.fill,
      visible: columnId == 12 ? false : true,
    );
  }
}

class TripsDataSource extends DataGridSource {
  TripsDataSource({required List<Trip> tripsData}) {
    _tripsData = tripsData
        .map<DataGridRow>((e) => DataGridRow(cells: [
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

  List<DataGridRow> _tripsData = [];

  @override
  List<DataGridRow> get rows => _tripsData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      final int index = effectiveRows.indexOf(row);
      final Alignment alignment = (e.columnName == '3' || e.columnName == '5' || e.columnName == '9') ? Alignment.centerLeft : Alignment.center;
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
                borderRadius: BorderRadius.all(
                  Radius.circular(formItemCorner),
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
        child: cellItem,
      );
    }).toList());
  }
}
