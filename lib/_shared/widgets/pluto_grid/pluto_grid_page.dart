import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/pluto_grid/trip_data_plutogrid.dart';
import 'package:gtm/pages/home/home.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class PlutoGridPage extends StatefulWidget {
  const PlutoGridPage({
    Key? key,
  }) : super(key: key);
  @override
  _PlutoGridWidgetPageState createState() => _PlutoGridWidgetPageState();
}

class _PlutoGridWidgetPageState extends State<PlutoGridPage> {
  final List<PlutoColumn> columns = [];

  final List<PlutoRow> rows = [];

  late PlutoGridStateManager stateManager;
  List<Trip>? tripList;
  int totalTrips = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is DashboardSuccess) {
          tripList = state.tripList;
          totalTrips = tripList!.length;
          var draft = tripList!
              .where(
                (element) =>
                    (element.tripStatus == 'Confirmed' ||
                        element.tripStatus == 'OnHold' ||
                        element.tripStatus == 'TCE') &&
                    (element.fileStatus == 'Open' ||
                        element.fileStatus == 'PFB'),
              )
              .length;

          _buildPlutoGridTable(tripList!);
        }

        return BlocBuilder<AdvanceFilterCubit, AdvanceFilterState>(
            builder: (context, state) {
          return BlocListener<AdvanceFilterCubit, AdvanceFilterState>(
              listener: (context, state) {
            if (state is AdvancFilterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: appText(state.message.toString())));
            }
          }, child: BlocBuilder<AdvanceFilterCubit, AdvanceFilterState>(
            builder: (context, state) {
              if (state is AdvancFilterSuccess) {
                tripList = state.tripList;
                totalTrips = tripList!.length;
                if (tripList!.isNotEmpty) _buildPlutoGridTable(tripList!);
              }
              if (state is AdvancFilterDataTableSuccess) {}
              return tripList == null
                  ? const Center(child: CircularProgressIndicator())
                  : tripList!.isNotEmpty
                      ? PlutoGrid(
                          columns: columns,
                          rows: rows,
                          configuration: const PlutoGridConfiguration(
                              gridBorderColor: Colors.transparent,
                              iconColor: AppColors.blueGrey,
                              gridBackgroundColor: AppColors.plutoGridTable,
                              gridBorderRadius:
                                  BorderRadius.all(Radius.circular(spacing8))),
                          onChanged: (PlutoGridOnChangedEvent event) {},
                          createFooter: (stateManager) {
                            stateManager.setPageSize(100,
                                notify: false); // Can be omitted. (Default 40)
                            return PlutoPagination(stateManager);
                          },
                          onLoaded: (PlutoGridOnLoadedEvent event) {
                            event.stateManager
                                .setSelectingMode(PlutoGridSelectingMode.row);

                            stateManager = event.stateManager;
                          },
                          rowColorCallback: (rowColorContext) {
                            return AppColors.paleGrey;
                          },
                        )
                      : noData();
            },
          ));
        });
      },
    );
  }

  void _buildPlutoGridTable(List<Trip>? tripList) {
    final tripTableData = TripDataPlutoGrid(tripList!, context);
    columns.addAll(tripTableData.columns!);
    rows.addAll(tripTableData.rows!);
  }

  Widget noData() {
    return const Center(
      child: Text(emptyData),
    );
  }
}
