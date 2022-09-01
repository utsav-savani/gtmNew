import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/save_service_popup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:gtm/responsive/screen_type_layout.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/history_log.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/sequence.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/sequence_schedule.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/task_memo.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/trip_checklist.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/trip_service_field.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/vendor.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripServicePopup extends StatefulWidget {
  final TripServiceModalType type;
  final int typeId;

  const TripServicePopup({required this.type, required this.typeId, Key? key}) : super(key: key);

  @override
  State<TripServicePopup> createState() => _TripServicePopupState();
}

class _TripServicePopupState extends State<TripServicePopup> {
  TextEditingController statusController = TextEditingController();
  TextEditingController throughController = TextEditingController();
  String selectedPaymentMethod = '';
  String selectedStatus = '';

  @override
  void didChangeDependencies() {
    ServicePopupBloc servicePopupBloc = BlocProvider.of(context);
    servicePopupBloc.add(FetchTripPopup(type: widget.type, typeId: widget.typeId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ServicePopupBloc, ServicePopupState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchSchedulePopupStatus.initial:
            case FetchSchedulePopupStatus.loading:
              return _buildLoading();
            case FetchSchedulePopupStatus.success:
              return ScreenTypeLayout(
                  mobile: _buildMobile(tripModalPopupDetail: state.tripPopupDetail),
                  tablet: _buildWeb(tripModalPopupDetail: state.tripPopupDetail),
                  desktop: _buildWeb(tripModalPopupDetail: state.tripPopupDetail));
            case FetchSchedulePopupStatus.failure:
              return _buildError();
          }
        },
      ),
    );
  }

  Widget _buildMobile({required TripModalPopupDetail tripModalPopupDetail}) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeading(heading: tripModalPopupDetail.service ?? ''),
                  _buildSequence(sequence: tripModalPopupDetail.sequence),
                  _buildVendors(vendors: tripModalPopupDetail.vendors ?? []),
                  _buildFields(fields: tripModalPopupDetail.fields ?? []),
                  _buildTaskMemos(taskMemos: tripModalPopupDetail.taskMemos ?? []),
                  _buildHistoryLogs(historyLog: tripModalPopupDetail.historyLog ?? []),
                  _buildActionsMobile(
                    scheduleStatus: tripModalPopupDetail.scheduleStatus ?? '',
                    serviceStatus: tripModalPopupDetail.serviceStatus ?? '',
                    through: tripModalPopupDetail.through ?? '',
                    checklist: tripModalPopupDetail.checklist ?? [],
                    payment: tripModalPopupDetail.payment ?? '',
                  ),
                ],
              ),
            ),
          ),
          _buildCancelSave(),
        ],
      ),
    );
  }

  Widget _buildWeb({required TripModalPopupDetail tripModalPopupDetail}) {
    return Column(
      children: [
        _buildHeading(heading: tripModalPopupDetail.service ?? ''),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildSequence(sequence: tripModalPopupDetail.sequence),
                      ),
                      Expanded(
                        flex: 3,
                        child: _buildVendors(vendors: tripModalPopupDetail.vendors ?? []),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFields(fields: tripModalPopupDetail.fields ?? []),
                              _buildTaskMemos(taskMemos: tripModalPopupDetail.taskMemos ?? []),
                              _buildHistoryLogs(historyLog: tripModalPopupDetail.historyLog ?? []),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: _buildActionsWeb(
                            scheduleStatus: tripModalPopupDetail.scheduleStatus ?? '',
                            serviceStatus: tripModalPopupDetail.serviceStatus ?? '',
                            through: tripModalPopupDetail.through ?? '',
                            checklist: tripModalPopupDetail.checklist ?? [],
                            payment: tripModalPopupDetail.payment ?? '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskMemos({required List<TaskMemo> taskMemos}) {
    if (taskMemos.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildSmallHeading(heading: 'Task Memos'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(
                  child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),flex: 2,),
              VerticalDivider(),
              Expanded(child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),flex: 2,),
              VerticalDivider(),
              Expanded(child: Text('Note', style: TextStyle(fontWeight: FontWeight.bold)),flex: 6,),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: taskMemos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(taskMemos[index].name ?? ''),flex: 2,),
                        const VerticalDivider(),
                        Expanded(child: Text(convertDateTimeToHumanReadableFormat(taskMemos[index].date ?? '')),flex: 2,),
                        const VerticalDivider(),
                        Expanded(child: Text(taskMemos[index].note ?? ''),flex: 6,),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryLogs({required List<HistoryLog> historyLog}) {
    if (historyLog.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildSmallHeading(heading: 'History Log'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),flex: 2,),
              VerticalDivider(),
              Expanded(child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),flex: 8,),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: historyLog.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(convertDateTimeToHumanReadableFormat(historyLog[index].date ?? '')),flex: 2,),
                        const VerticalDivider(),
                        Expanded(child: Text(historyLog[index].description ?? ''),flex: 8,),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildError() {
    return const Center(child: Text('Something went wrong'));
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildHeading({String heading = ''}) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              heading,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close_rounded,color: Colors.white,))
          ],
        ),
      ),
    );
  }

  Widget _buildSequence({Sequence? sequence}) {
    if (sequence == null) {
      return Container();
    }
    List<SequenceSchedule> schedules = sequence.schedules ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildSmallHeading(heading: 'Sequence:'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(sequence.name ?? ''),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            SequenceSchedule seqSch = schedules[index];
            bool isDeparture = (seqSch.type ?? '') == 'DEP';
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(isDeparture ? Icons.flight_takeoff_rounded : Icons.flight_land_rounded),
                    ),
                    ConstrainedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(seqSch.icoa ?? ''),
                      ),
                      constraints: const BoxConstraints(minWidth: 80),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 4),
                          child: Text(convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(seqSch.date ?? '', isUTC: true)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 4),
                          child: Text(convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(seqSch.date ?? '', isUTC: false)),
                        ),
                      ],
                    ),
                  ],
                ),
                height(12),
              ],
            );
          },
          itemCount: schedules.length,
        ),
      ],
    );
  }

  Widget _buildVendors({List<Vendor> vendors = const []}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: vendors.map((e) {
            Vendor vendor = e;
            List<String> email = vendor.email ?? [];
            List<String> fax = vendor.fax ?? [];
            List<String> phone = vendor.phone ?? [];
            List<String> mobile = vendor.mobile ?? [];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blueGrey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildSmallHeading(heading: 'Vendor: '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(vendor.vendor ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                child: _buildSmallHeading(heading: vendor.fullName ?? ''),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildSeeMoreWidget(icon: const Icon(Icons.mail_rounded), values: email),
                                  _buildSeeMoreWidget(icon: const Icon(Icons.fax), values: fax),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildSeeMoreWidget(icon: const Icon(Icons.phone), values: phone),
                                  _buildSeeMoreWidget(icon: const Icon(Icons.phone_iphone), values: mobile),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSeeMoreWidget({required Icon icon, required List<String> values}) {
    if (values.isNotEmpty) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(values.first),
          ),
          () {
            if (values.length > 1) {
              return Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: PopupMenuButton(
                  itemBuilder: (context) {
                    return values.map((e) => PopupMenuItem(child: Text(e))).toList();
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
              );
            }
            return Container();
          }()
        ],
      );
    }
    return Container();
  }

  Widget _buildFields({required List<TripServiceField> fields}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: fields.map((TripServiceField e) {
            TextEditingController textEditingController = TextEditingController();
            textEditingController.text = e.value ?? '';
            return Padding(
              padding: const EdgeInsets.all(8),
              child: CustomWidgets().buildConstrainedTextFormField(TextFormField(
                readOnly: true,
                decoration: InputDecoration(labelText: e.text),
              )),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionsWeb(
      {required String serviceStatus,
      required String scheduleStatus,
      required String through,
      required String payment,
      required List<TripChecklist> checklist}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatus(serviceStatus: serviceStatus),
        _buildThrough(through: through),
        Row(
          children: [
            Expanded(
              child: _buildPayment(payment: payment),
            ),
            Expanded(
              child: _buildChecklist(checklist: checklist),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildSaveButton(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionsMobile(
      {required String serviceStatus,
      required String scheduleStatus,
      required String through,
      required String payment,
      required List<TripChecklist> checklist}) {
    return Column(
      children: [
        _buildStatus(serviceStatus: serviceStatus),
        _buildThrough(through: through),
        Row(
          children: [
            Expanded(child: _buildPayment(payment: payment)),
            Expanded(child: _buildChecklist(checklist: checklist)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatus({required String serviceStatus}) {
    serviceStatus = serviceStatus == '' ? 'Not Actioned' : serviceStatus;
    selectedStatus = serviceStatus;
    List<String> statusItems = [serviceStatus, 'Cancelled'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildDropdown<String>(
        items: statusItems.map((e) {
          return DropdownMenuItem(
            child: Text(e),
            value: e,
          );
        }).toList(),
        onChanged: (val) {
          selectedStatus = val ?? '';
        },
        value: selectedStatus,
        maxWidth: double.infinity,
      ),
    );
  }

  Widget _buildThrough({required String through}) {
    throughController.text = through;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildConstrainedTextFormField(
        TextFormField(
          readOnly: true,
          controller: throughController,
          focusNode: FocusNode(canRequestFocus: false),
          decoration: const InputDecoration(
            labelText: 'Through',
          ),
        ),
        maxWidth: double.infinity,
      ),
    );
  }

  Widget _buildPayment({required String payment}) {
    selectedPaymentMethod = payment;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildDropdown<String>(
        maxWidth: double.infinity,
        items: TripServiceBloc.payment.map((e) {
          return DropdownMenuItem(
            child: Text(e),
            value: e,
          );
        }).toList(),
        value: TripServiceBloc.payment.contains(selectedPaymentMethod) ? selectedPaymentMethod : null,
        onChanged: (val) {
          selectedPaymentMethod = val ?? '';
        },
      ),
    );
  }

  Widget _buildChecklist({required List<TripChecklist> checklist}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        child: ElevatedButton.icon(onPressed: null, icon: const Icon(Icons.checklist), label: const Text('Checklist')),
        tooltip: checklist.isEmpty ? 'No Checklist Found' : 'Show Checklist',
        itemBuilder: (context) {
          return checklist.map(
            (e) {
              return PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      e.checkListsName ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.checkListsNotes ?? ''),
                    const Divider(),
                  ],
                ),
              );
            },
          ).toList();
        },
      ),
    );
  }

  Widget _buildCancelSave() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSaveButton(),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (selectedPaymentMethod.isEmpty) {
            AppHelper().showSnackBar(context, message: 'Select Payment Type');
            return;
          }
          if (selectedStatus.isEmpty) {
            AppHelper().showSnackBar(context, message: 'Select Service Status');
            return;
          }
          SaveServicePopupBloc saveServicePopupBloc = BlocProvider.of(context);
          saveServicePopupBloc.add(SavePopup(
              serviceId: widget.typeId,
              type: widget.type,
              tripServiceModalPopupPayload: TripServiceModalPopupPayload(payment: selectedPaymentMethod, serviceStatus: selectedStatus)));
        },
        child: BlocListener<SaveServicePopupBloc, SaveServicePopupState>(
          listener: (context, state) {
            if (state == SaveServicePopupState.success) {
              AppHelper().showSnackBar(context, message: 'Service updated');
            } else if (state == SaveServicePopupState.failure) {
              AppHelper().showSnackBar(context, message: 'Service update failed');
            }
          },
          child: BlocBuilder<SaveServicePopupBloc, SaveServicePopupState>(
            builder: (context, state) {
              switch (state) {
                case SaveServicePopupState.initial:
                case SaveServicePopupState.success:
                case SaveServicePopupState.failure:
                  return const Text('Save');
                case SaveServicePopupState.loading:
                  return CustomWidgets().buildCircularProgressSmall(color: Colors.white);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSmallHeading({required String heading}) {
    return Text(
      heading,
      style: const TextStyle(
        color: Color(0xff9ea5bf),
        fontSize: 12,
      ),
    );
  }
}
