import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:trip_manager_repository/src/models/trip.dart';

class TripDataTable extends DataTableSource {
  /*  static final TripDataTableList DataTableSingleInstance = TripDataTableList._singleInstance();
  TripDataTableList._singleInstance(); */

  /* factory TripDataTableList({List<Trip>? tripData}) {
    DataTableSingleInstance.tripList = tripData!;
    return DataTableSingleInstance;
  }
 */
  TripDataTable(
    this._tripList,
  );

  late List<Trip> _tripList;
  late bool tapOnRows;

  //fal BuildContext context;

  Future<void> sort<T>(
      Comparable<T> Function(Trip trip) getField, bool ascending) async {
    _tripList.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }

  @override
  DataRow getRow(int index) {
    // assert(index >= 0);
    // if (index >= _tripList.length) throw 'index > _tripList.length';
    final data = _tripList[index];
    //   debugPrint(data.acType);
    return DataRow2.byIndex(index: index, cells: [
      DataCell(Text(
        data.tripId.toString(),
        overflow: TextOverflow.ellipsis,
      )),
      // DataCell(Text(data.guid.toString())),
      // DataCell(Text(data.tripNumber.toString())),
      DataCell(Text(data.regNo.toString())),
      DataCell(Text(
        data.operator.toString(),
        overflow: TextOverflow.ellipsis,
      )),
      // DataCell(Text(data.customerId.toString())),
      DataCell(Text(
        data.acType.toString(),
        overflow: TextOverflow.ellipsis,
      )),
      // DataCell(Text(data.customer.toString())),
      // DataCell(Text(data.team.toString())),
      // DataCell(Text(data.isFlightCategory.toString())),
      DataCell(Text(
        data.flightCategory.toString(),
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(data.callsign.toString())),
      DataCell(Text(data.start.toString())),
      DataCell(Text(data.end.toString())),
      DataCell(Text(
        data.route.toString(),
        overflow: TextOverflow.clip,
      )),
      DataCell(Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            color: getStatus(data.tripStatus),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data.tripStatus.toString()),
          ))),
      DataCell(Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            color: getStatus(data.fileStatus),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data.fileStatus.toString()),
          ))),
      // DataCell(Text(data.creator.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _tripList.length;
  @override
  int get selectedRowCount => 0;

  Color getStatus(String text) {
    switch (text) {
      case 'Opened':
        return Colors.amber.shade100;
      case 'Confirmed':
        return Colors.blue.shade300;
      case 'In-Progress':
        return Colors.orange.shade300; //AppColors.inProgress;
      case 'Completed':
        return Colors.green.shade300; //AppColors.completd;
      case 'Cancelled':
        return Colors.red.shade300; //AppColors.cancelled;
      default:
        return Colors.blue.shade100;
    }
  }
}
