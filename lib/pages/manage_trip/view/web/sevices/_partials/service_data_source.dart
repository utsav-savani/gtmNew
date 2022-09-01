import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/_partials/service_extensions.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/_partials/service_popup_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ServiceDataSource extends DataGridSource {
  BuildContext context;
  TripServiceMain tripServiceMain;
  late TripServiceBloc tripServiceBloc;

  ServiceDataSource({required this.context, required this.tripServiceMain}) {
    tripServiceBloc = BlocProvider.of(context);
    if (tripServiceMain.services == null || tripServiceMain.schedule == null) {
      return;
    }
    dataGridRows = tripServiceMain.services!.map((service) {
      return DataGridRow(
        cells: _buildCells(service),
      );
    }).toList();
  }

  List<DataGridCell> _buildCells(service) {
    return tripServiceMain.schedule!.map((schedule) {
      print("Start: ========Sechedule services ==========");
      print(schedule.services);
      print("End: ========Sechedule services ==========");

      List<TripService>? temp = schedule.services!
          .where((element) => element.serviceId == service.serviceId)
          .toList();
      TripService? cellValue;
      if (temp.isNotEmpty) {
        cellValue = temp.first;
      }
      String _columName = schedule.tripScheduleId.toString();
      _columName += '#' + schedule.tripOverflyId.toString();
      _columName += '#' + schedule.isOverFlight.toString();
      print("Start ======Service========");
      print("${cellValue?.tripOverflyServiceId}");
      print("${cellValue?.tripServiceId}");
      print("End ======Service========");
      return DataGridCell(
        columnName: _columName,
        value: cellValue,
      );
    }).toList();
  }

  void showEnableEditSnackBar() {
    AppHelper().showSnackBar(
      context,
      message: 'Click the edit button to make changes',
    );
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell e) {
        if (e.value == null) {
          return Container();
        }
        TripService _tripService = e.value as TripService;

        String _tripScheduleId = e.columnName.split('#')[0];
        String _tripOverlfyId = e.columnName.split('#')[1];
        bool _isOverFlight = e.columnName.split('#')[2] == 'true';
        if (!_isOverFlight && _tripService.service == "Permit (OVF)") {
          return Container();
        }
        int? _overflyId;
        if (_tripOverlfyId != "null") _overflyId = int.parse(_tripOverlfyId);
        return _buildGridCell(
          _tripService,
          onDeleteTap: () {
            print("======");
            print("Overflight Id => $_tripOverlfyId");
            print("Overflight Id => $_overflyId");
            print("======");
            _deleteItem(
              isOverFlight: _isOverFlight,
              tripScheduleId: int.parse(_tripScheduleId),
              tripService: _tripService,
              tripOverflyId: _overflyId,
            );
          },
          onInfoTap: () {
            print("======");
            print("Overflight Id => $_tripOverlfyId");
            print("Overflight Id1 => $_overflyId");
            print("isRemovable ${_tripService.isRemovable}");
            print(
              "OverflightService ID => ${_tripService.tripOverflyServiceId}",
            );
            print("======");
            _infoModalPopupHandler(
              overflight: _isOverFlight,
              tripService: _tripService,
            );
          },
        );
      }).toList(),
    );
  }

  void _infoModalPopupHandler({
    required TripService tripService,
    required bool overflight,
  }) {
    TripServiceModalType _type = TripServiceModalType.LOCATION;
    if (overflight) _type = TripServiceModalType.OVERFLY;
    print(_type);
    print(tripService.tripServiceId);
    print(tripService.tripOverflyServiceId);
    int _itemId = 0;
    if (_type == TripServiceModalType.LOCATION) {
      _itemId = tripService.tripServiceId ?? 0;
    }
    if (_type == TripServiceModalType.OVERFLY) {
      _itemId = tripService.tripOverflyServiceId ?? 0;
    }
    showGeneralDialog(
      context: context,
      barrierLabel: tripService.service ?? '',
      barrierDismissible: true,
      pageBuilder: (context, _, __) => Padding(
        padding: const EdgeInsets.all(100),
        child: TripServiceModalPopupsWidget(type: _type, typeId: _itemId),
        // child: TripServicePopup(
        //   type: _type,
        //   typeId: tripService.tripServiceId ?? 0,
        // ),
      ),
    );
  }

  void _deleteItem({
    required TripService tripService,
    required bool isOverFlight,
    required int tripScheduleId,
    int? tripOverflyId,
  }) {
    if (!tripServiceBloc.editMode) {
      showEnableEditSnackBar();
      return;
    }
    print("Trip schedule id $tripScheduleId");
    print("Trip overfly id $tripOverflyId");
    print("isRemovable ${tripService.isRemovable}");
    String serviceName = tripService.service ?? '';
    if (tripService.isRemovable ?? false) {
      TripServiceBloc tripServiceBloc = BlocProvider.of(context);
      tripServiceBloc.add(
        DeleteTripService(
          tripServiceID: tripService.serviceId ?? 0,
          tripServiceScheduleID: tripScheduleId,
          isOverFlight: isOverFlight,
          tripOverflyID: tripOverflyId ?? 0,
        ),
      );

      List<TripServiceSchedule>? _schedules = tripServiceMain.schedule;
      if (_schedules != null && _schedules.isNotEmpty) {
        int tripServiceScheduleIndex = _schedules.indexWhere((element) =>
            element.tripScheduleId.toString() == tripScheduleId.toString());
        if (tripServiceScheduleIndex > -1) {
          TripServiceSchedule tripServiceSchedule =
              _schedules[tripServiceScheduleIndex];
          tripServiceBloc.add(
            AddToPayload(
              addToPayloadMode: AddToPayloadMode.delete,
              tripSchedule: tripServiceSchedule,
              tripService: tripService,
              tripOverflyId: tripOverflyId,
            ),
          );
        }
      }
    } else {
      AppHelper().showSnackBar(
        context,
        message: serviceName + ' cannot be removed',
      );
    }
  }

  Widget _buildGridCell(
    TripService tripService, {
    GestureTapCallback? onInfoTap,
    GestureTapCallback? onDeleteTap,
  }) {
    ServiceStatus status;
    switch (tripService.status) {
      case TripServiceBloc.serviceStatusInprogress:
        status = ServiceStatus.inProgress;
        break;
      case TripServiceBloc.serviceStatusConfirmed:
        status = ServiceStatus.confirmed;
        break;
      default:
        status = ServiceStatus.newService;
        break;
    }
    bool isMandatoryFlagVisible = false;
    bool canDeleteService = false;
    Color foregroundColor;
    Color _backgroundColor;
    String statusText;
    String serviceManagedBy = 'UAS';
    serviceManagedBy = serviceManagedBy.split('').join('\n');
    switch (status) {
      case ServiceStatus.newService:
        isMandatoryFlagVisible = true;
        canDeleteService = true;
        _backgroundColor = AppColors.blueGrey;
        foregroundColor = AppColors.coolBlue;
        statusText = 'New';
        break;
      case ServiceStatus.inProgress:
        isMandatoryFlagVisible = true;
        canDeleteService = false;
        _backgroundColor = AppColors.lightPeach;
        foregroundColor = AppColors.apricot;
        statusText = 'In Progress';
        break;
      case ServiceStatus.confirmed:
        isMandatoryFlagVisible = true;
        canDeleteService = false;
        _backgroundColor = AppColors.silver;
        foregroundColor = AppColors.jadeGreen;
        statusText = 'Confirmed';
        break;
      case ServiceStatus.cancelled:
        isMandatoryFlagVisible = false;
        canDeleteService = false;
        _backgroundColor = AppColors.peachyPink;
        foregroundColor = AppColors.redColor;
        statusText = 'Cancelled';
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          _backgroundCellDesignWidget(
            backgroundColor: _backgroundColor,
            isMandatoryFlagVisible: isMandatoryFlagVisible,
          ),
          Row(
            children: [
              if (isMandatoryFlagVisible) Container(width: 10) else Container(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: foregroundColor,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                statusText,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Builder(builder: (context) {
                                if (tripService.tripServiceId == 0) {
                                  return Container();
                                }
                                if (tripService.vendorId != null) {
                                  return InkWell(
                                    onTap: onInfoTap,
                                    child: const Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  );
                                }
                                return Container();
                              }),
                            ),
                            if (canDeleteService)
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: onDeleteTap,
                                  child: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              )
                            else
                              Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 28,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          serviceManagedBy,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: spacing10,
                          ),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _backgroundCellDesignWidget({
    required bool isMandatoryFlagVisible,
    required Color backgroundColor,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: _mandatoryBoxDecoration(isMandatoryFlagVisible),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ],
    );
  }

  BoxDecoration? _mandatoryBoxDecoration(bool isMandatory) {
    if (!isMandatory) return null;
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff07f7aa),
          Color(0xff00a7eb),
        ],
      ),
    );
  }
}
