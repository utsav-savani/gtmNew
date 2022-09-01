import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripDataPlutoGrid {
  List<PlutoColumn>? columns;
  List<PlutoRow>? rows;
  List<PlutoRow>? rowsBuilder;

  final List<Trip>? _tripList;
  final BuildContext context;

  TripDataPlutoGrid(this._tripList, this.context) {
    var size = MediaQuery.of(context).size;
    columns = [
      _buildPlutoColumnHeader(tripId),
      _buildPlutoColumnHeader(regNo),
      _buildPlutoColumnHeader(operator),
      _buildPlutoColumnHeader(airCraftType),
      _buildPlutoColumnHeader(flightCategory),
      _buildPlutoColumnHeader(callsign),
      _buildPlutoColumnHeader(start),
      _buildPlutoColumnHeader(end),
      _buildPlutoColumnHeader(route),
      _buildPlutoColumnHeader(tripStatus),
      _buildPlutoColumnHeader(fileStatus),
    ];
    rows = _buildPlutoRows(_tripList!);
  }

  PlutoColumn _buildPlutoColumnHeader(plutoColumn) {
    // width: size.width > webLarge ? 32.w : spacing116,
    return PlutoColumn(
      width: spacing120,
      minWidth: spacing84,
      backgroundColor: AppColors.tableHeaderColor,
      title: plutoColumn,
      field: plutoColumn,
      titleSpan: TextSpan(
        text: plutoColumn,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
      type: PlutoColumnType.number(format: '#############'),
    );
  }

  _buildPlutoRows(List<Trip> tripsList) {
    rowsBuilder = [];
    for (var trip in tripsList) {
      var row = PlutoRow(
        cells: {
          regNo: PlutoCell(value: trip.regNo),
          tripId: PlutoCell(value: "${trip.tripId}"),
          operator: PlutoCell(value: trip.operator),
          airCraftType: PlutoCell(value: trip.acType),
          flightCategory: PlutoCell(value: trip.flightCategory),
          callsign: PlutoCell(value: trip.callsign),
          start: PlutoCell(value: trip.start),
          end: PlutoCell(value: trip.end),
          route: PlutoCell(value: "${trip.route}"),
          tripStatus: PlutoCell(value: trip.tripStatus),
          fileStatus: PlutoCell(value: trip.fileStatus),
        },
      );
      rowsBuilder!.add(row);
    }
    return rowsBuilder;
  }
}
