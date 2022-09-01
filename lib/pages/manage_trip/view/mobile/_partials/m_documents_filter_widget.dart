import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_event.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_pdf_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class MDocumentsFilterWidget extends StatefulWidget {
  final String guid;
  const MDocumentsFilterWidget({Key? key, required this.guid})
      : super(key: key);

  @override
  State<MDocumentsFilterWidget> createState() => _MDocumentsFilterWidgetState();
}

class _MDocumentsFilterWidgetState extends State<MDocumentsFilterWidget> {
  List<TripDocumentSchedule> _toList = [];
  final String _service = '';
  final bool _excludeCancelled = false;
  bool _isLocal = true;
  bool _isUTC = true;
  bool _isWeather = false;
  bool _fuelRelease = false;
  bool _isNOTAMs = false;
  TripDocumentSchedule? _selectedFromSchedule;
  TripDocumentSchedule? _selectedToSchedule;
  final List<String> _selectedServices = <String>[];

  TripDocumentFilterModel? _tripDocumentFilterModel;

  @override
  void didChangeDependencies() {
    _fetchDocumentFilter(widget.guid);
    super.didChangeDependencies();
  }

  _fetchDocumentFilter(String guid) {
    DocumentFilterBloc documentFilterBloc =
        BlocProvider.of<DocumentFilterBloc>(context);
    documentFilterBloc.add(FetchDocumentFilter(guid: guid));
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.powderBlue,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: BlocListener<DocumentFilterBloc, DocumentFilterState>(
        listener: (context, state) {},
        child: BlocBuilder<DocumentFilterBloc, DocumentFilterState>(
          builder: (context, state) {
            switch (state.status) {
              case FetchDocumentsFilter.initial:
              case FetchDocumentsFilter.loading:
                return loadingWidget();
              case FetchDocumentsFilter.success:
                _tripDocumentFilterModel = state.tripDocumentFilter;
                if (state.tripDocumentFilter == null) {
                  return noDataFoundWidget();
                }
                return _tripDocumentFilterModel == null ||
                        _tripDocumentFilterModel!.tripScedule.isEmpty
                    ? noDataFoundWidget()
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          height(12),
                          _getSectors(_tripDocumentFilterModel!.tripScedule),
                          _getPreferences(state.tripDocumentFilter!),
                          _getIncludedDocuments(state.tripDocumentFilter!),
                          _getServiceType(state.tripDocumentFilter!),
                          _getButtons(state.tripDocumentFilter!),
                        ],
                      );
              case FetchDocumentsFilter.failure:
                return errorWidget();
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  _getSectors(List<TripDocumentSchedule> tripDocumentSchedules) {
    _toList = tripDocumentSchedules;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 8,
              ),
              child: Text(
                'Sectors',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w100,
                      color: AppColors.blackColor.withAlpha(110),
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                width(8),
                Expanded(
                  child: CustomWidgets().buildDropdown<TripDocumentSchedule>(
                    items:
                        tripDocumentSchedules.map((TripDocumentSchedule item) {
                      return DropdownMenuItem<TripDocumentSchedule>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _selectedFromSchedule = value;

                      List<TripDocumentSchedule> schedule =
                          tripDocumentSchedules
                              .where((element) => element == value)
                              .toList();
                      if (schedule.isNotEmpty) {
                        _toList = tripDocumentSchedules.where((element) {
                          return element.tripsequenceNumber >
                              schedule.first.tripsequenceNumber;
                        }).toList();
                      }
                    },
                    label: 'From',
                  ),
                ),
                width(8),
                Expanded(
                  child: CustomWidgets().buildDropdown<TripDocumentSchedule>(
                    items: _toList.map((TripDocumentSchedule item) {
                      return DropdownMenuItem<TripDocumentSchedule>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (val) {
                      _selectedToSchedule = val;
                    },
                    label: 'To',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _getPreferences(TripDocumentFilterModel tripDocumentFilterModel) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8,
                ),
                child: Text(
                  'Times:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w100,
                      color: AppColors.blackColor.withAlpha(110)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _getCheckBox(
                    name: 'Local',
                    value: _isLocal,
                    onChanged: (val) {
                      setState(() {
                        _isLocal = !_isLocal;
                      });
                    },
                  ),
                  _getCheckBox(
                    name: 'UTC',
                    value: _isUTC,
                    onChanged: (val) {
                      _isUTC = !_isUTC;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _getIncludedDocuments(TripDocumentFilterModel tripDocumentFilterModel) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8,
                ),
                child: Text(
                  'Include Docs:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w100,
                      color: AppColors.blackColor.withAlpha(110)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _getCheckBox(
                    name: 'Fuel Release',
                    value: _fuelRelease,
                    onChanged: (val) {
                      _fuelRelease = !_fuelRelease;
                      setState(() {});
                    },
                  ),
                  _getCheckBox(
                    name: 'Weather',
                    value: _isWeather,
                    onChanged: (val) {
                      _isWeather = !_isWeather;
                      setState(() {});
                    },
                  ),
                  _getCheckBox(
                    name: 'NOTAMs',
                    value: _isNOTAMs,
                    onChanged: (val) {
                      _isNOTAMs = !_isNOTAMs;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _getServiceType(TripDocumentFilterModel tripDocumentFilterModel) {
    List<TripDocumentService> tripDocumentServices =
        tripDocumentFilterModel.services;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8,
                ),
                child: Text(
                  'Service Type:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w100,
                        color: AppColors.blackColor.withAlpha(110),
                      ),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: tripDocumentServices.map((item) {
                  final bool isExists =
                      _selectedServices.contains(item.serviceId.toString());
                  final String serviceId = item.serviceId.toString();
                  return InkWell(
                    onTap: () {
                      if (_selectedServices.contains(serviceId)) {
                        _selectedServices.remove(serviceId);
                      } else {
                        _selectedServices.add(serviceId);
                      }
                      setState(() {});
                    },
                    child: Chip(
                      backgroundColor: isExists
                          ? AppColors.defaultColor
                          : AppColors.whiteColor,
                      elevation: 1,
                      label: Text(
                        item.service,
                        style: TextStyle(
                          color: isExists
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  _getButtons(TripDocumentFilterModel tripDocumentFilter) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              List<Map<String, dynamic>> schedule = [];
              List<Map<String, dynamic>> _selectedService = [];
              List<TripDocumentSchedule> scheduleFrom = tripDocumentFilter
                  .tripScedule
                  .where((element) => element == _selectedFromSchedule)
                  .toList();
              List<TripDocumentSchedule> scheduleTo = tripDocumentFilter
                  .tripScedule
                  .where((element) => element == _selectedToSchedule)
                  .toList();
              List<TripDocumentService> services = tripDocumentFilter.services
                  .where((element) => element.service == _service)
                  .toList();

              if (scheduleFrom.isNotEmpty) {
                schedule
                    .add({'tripScheduleId': scheduleFrom.first.tripScheduleId});
              }
              if (scheduleTo.isNotEmpty) {
                schedule
                    .add({'tripScheduleId': scheduleTo.first.tripScheduleId});
              }
              if (_selectedServices.isNotEmpty) {
                for (String serviceId in _selectedServices) {
                  _selectedService.add({'serviceId': serviceId});
                }
              }
              TripManagerDocumentPayload payload = TripManagerDocumentPayload(
                stations: schedule,
                services: _selectedService,
                excludeCancelled: _excludeCancelled,
                fuelRelease: _fuelRelease,
                guid: widget.guid,
                isLocal: _isLocal,
                isNOTAMS: _isNOTAMs,
                isUTC: _isUTC,
                isWeather: _isWeather,
              );
              _getDocumentsData(payload);
            },
            child: const Text('Update'),
            style: ElevatedButton.styleFrom(
              primary: AppColors.defaultColor,
              onPrimary: AppColors.whiteColor,
              minimumSize: const Size(130, 48),
            ),
          ),
          height(10),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.redColor,
                    ),
              ),
            ),
          ),
          height(10),
        ],
      ),
    );
  }

  _getDocumentsData(TripManagerDocumentPayload payload) {
    Navigator.pop(context);
    DocumentsPDFBloc documentsPDFBloc =
        BlocProvider.of<DocumentsPDFBloc>(context);
    documentsPDFBloc.add(FetchDocumentURL(payload: payload));
  }

  _getCheckBox({
    required String name,
    bool value = false,
    ValueChanged<bool?>? onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
          value: value,
          onChanged: onChanged,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
        Text(name),
      ],
    );
  }
}
