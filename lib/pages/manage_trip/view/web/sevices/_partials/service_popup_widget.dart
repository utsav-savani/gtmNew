import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/save_service_popup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:gtm/pages/widgets/trip_accordion.dart';
import 'package:gtm/responsive/screen_type_layout.dart';
import 'package:html/parser.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/sequence.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/sequence_schedule.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/history_log.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/task_memo.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/vendor.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/trip_service_field.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/trip_checklist.dart';

class TripServiceModalPopupsWidget extends StatefulWidget {
  final TripServiceModalType type;
  final int typeId;

  const TripServiceModalPopupsWidget({
    required this.type,
    required this.typeId,
    Key? key,
  }) : super(key: key);

  @override
  State<TripServiceModalPopupsWidget> createState() =>
      _TripServiceModalPopupsWidgetState();
}

class _TripServiceModalPopupsWidgetState
    extends State<TripServiceModalPopupsWidget> {
  TextEditingController statusController = TextEditingController();
  TextEditingController throughController = TextEditingController();
  String selectedPaymentMethod = '';
  String selectedStatus = '';
  @override
  void didChangeDependencies() {
    ServicePopupBloc servicePopupBloc = BlocProvider.of(context);
    servicePopupBloc.add(
      FetchTripPopup(
        type: widget.type,
        typeId: widget.typeId,
      ),
    );
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
              return loadingWidget();
            case FetchSchedulePopupStatus.success:
              return ScreenTypeLayout(
                mobile: _buildMobile(
                  tripModalPopupDetail: state.tripPopupDetail,
                ),
                tablet: _buildWeb(
                  tripModalPopupDetail: state.tripPopupDetail,
                ),
                desktop: _buildWeb(
                  tripModalPopupDetail: state.tripPopupDetail,
                ),
              );
            case FetchSchedulePopupStatus.failure:
              return errorWidget();
          }
        },
      ),
    );
  }

  Widget _buildMobile({required TripModalPopupDetail tripModalPopupDetail}) {
    return SafeArea(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeading(heading: tripModalPopupDetail.service ?? ''),
                _buildSequence(sequence: tripModalPopupDetail.sequence),
                _buildVendors(vendors: tripModalPopupDetail.vendors ?? []),
                _buildFields(fields: tripModalPopupDetail.fields ?? []),
                _buildTaskMemos(
                    taskMemos: tripModalPopupDetail.taskMemos ?? []),
                _buildHistoryLogs(
                    historyLog: tripModalPopupDetail.historyLog ?? []),
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
          _buildCancelSave(),
        ],
      ),
    );
  }

  Widget _buildWeb({required TripModalPopupDetail tripModalPopupDetail}) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildHeader(tripModalPopupDetail),
            _buildSequenceSection(sequence: tripModalPopupDetail.sequence),
            _buildVendors(vendors: tripModalPopupDetail.vendors ?? []),
            _buildFields(fields: tripModalPopupDetail.fields ?? []),
            _buildActionsWeb(
              scheduleStatus: tripModalPopupDetail.scheduleStatus ?? '',
              serviceStatus: tripModalPopupDetail.serviceStatus ?? '',
              through: tripModalPopupDetail.through ?? '',
              checklist: tripModalPopupDetail.checklist ?? [],
              payment: tripModalPopupDetail.payment ?? '',
            ),
            _buildHistoryLogs(
              historyLog: tripModalPopupDetail.historyLog ?? [],
            ),
            _buildTaskMemos(taskMemos: tripModalPopupDetail.taskMemos ?? []),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(TripModalPopupDetail tripModalPopupDetail) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.defaultColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: appText(
              "${tripModalPopupDetail.service} : ${tripModalPopupDetail.sequence!.name}",
              color: AppColors.whiteColor,
              fontSize: 14,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSequenceSection({Sequence? sequence}) {
    if (sequence == null) {
      return Container();
    }
    List<SequenceSchedule> schedules = sequence.schedules ?? [];
    return Container(
      color: AppColors.paleBlue,
      height: spacing120,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          SequenceSchedule seqSch = schedules[index];
          bool isDeparture = (seqSch.type ?? '') == 'DEP';
          IconData _icon = Icons.flight_land_rounded;
          if (isDeparture) _icon = Icons.flight_takeoff_rounded;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              width(32),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(_icon),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: appText(
                      seqSch.icoa ?? '',
                      color: AppColors.blueGrey,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.powderBlue,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 4),
                            child: Text(
                              convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                                seqSch.date ?? '',
                                isUTC: true,
                              ),
                            ),
                          ),
                          const Divider(
                            color: AppColors.powderBlue,
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 4),
                            child: Text(
                              convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                                seqSch.date ?? '',
                                isUTC: false,
                                timezone: seqSch.timezone,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              width(32),
            ],
          );
        },
        itemCount: schedules.length,
      ),
    );
  }

  Widget _buildActionsMobile({
    required String serviceStatus,
    required String scheduleStatus,
    required String through,
    required String payment,
    required List<TripChecklist> checklist,
  }) {
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

  Widget _buildActionsWeb({
    required String serviceStatus,
    required String scheduleStatus,
    required String through,
    required String payment,
    required List<TripChecklist> checklist,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      child: TripAccordion(
        visualDensity: -3,
        titleWidget: appText('Manage Service'),
        listTileColor: AppColors.veryLightBlue,
        titleColor: AppColors.charcoalGrey,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(12),
            Row(
              children: [
                Expanded(child: _buildStatus(serviceStatus: serviceStatus)),
                Expanded(child: _buildThrough(through: through)),
              ],
            ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSaveButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryLogs({required List<HistoryLog> historyLog}) {
    if (historyLog.isEmpty) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: TripAccordion(
        visualDensity: -3,
        titleWidget: appText('History Logs', color: AppColors.whiteColor),
        listTileColor: AppColors.deepLavender,
        titleColor: AppColors.whiteColor,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: AppColors.veryLightBlue,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
                              Expanded(
                                child: Text(
                                  convertDateTimeToHumanReadableFormat(
                                    historyLog[index].date ?? '',
                                  ),
                                ),
                                flex: 2,
                              ),
                              const VerticalDivider(),
                              Expanded(
                                child:
                                    Text(historyLog[index].description ?? ''),
                                flex: 8,
                              ),
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
          ),
        ),
      ),
    );
  }

  Widget _buildTaskMemos({required List<TaskMemo> taskMemos}) {
    if (taskMemos.isEmpty) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: TripAccordion(
        visualDensity: -3,
        titleWidget: appText('Task Memos', color: AppColors.whiteColor),
        listTileColor: AppColors.deepLavender,
        titleColor: AppColors.whiteColor,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    flex: 2,
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: Text('Date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    flex: 2,
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: Text(
                      'Note',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    flex: 6,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: taskMemos.length,
                itemBuilder: (context, index) {
                  var document = parse(taskMemos[index].note);
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(taskMemos[index].name ?? ''),
                              flex: 2,
                            ),
                            const VerticalDivider(),
                            Expanded(
                              child: Text(convertDateTimeToHumanReadableFormat(
                                  taskMemos[index].date ?? '')),
                              flex: 2,
                            ),
                            const VerticalDivider(),
                            Expanded(
                              child: Text(document.body!.text),
                              flex: 6,
                            ),
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
        ),
      ),
    );
  }

  Widget _buildVendors({List<Vendor> vendors = const []}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          Vendor vendor = vendors[index];
          List<String>? _mobiles = vendor.mobile ?? [];
          List<String>? _phone = vendor.phone ?? [];
          List<String>? _email = vendor.email ?? [];
          List<String>? _fax = vendor.fax ?? [];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TripAccordion(
              visualDensity: -3,
              titleWidget: appText(
                'Vendor: ${vendor.vendor ?? ''}',
                color: AppColors.brownishGrey,
              ),
              listTileColor: AppColors.veryLightBlue,
              titleColor: AppColors.brownishGrey,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  height(8),
                  SizedBox(
                    height: spacing60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        _buildCustomerTextField(
                          label: "Tel. No.",
                          value: _phone.join(','),
                        ),
                        _buildCustomerTextField(
                          label: "Mobile No.",
                          value: _mobiles.join(','),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: spacing60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        _buildCustomerTextField(
                          label: "Email",
                          value: _email.join(','),
                        ),
                        _buildCustomerTextField(
                          label: "Fax",
                          value: _fax.join(','),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomerTextField({
    required String label,
    required String value,
  }) {
    TextEditingController tc = TextEditingController();
    tc.text = value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: SizedBox(
        height: spacing40,
        width: MediaQuery.of(context).size.width / 4,
        child: CustomWidgets().buildConstrainedTextFormField(
          TextFormField(
            controller: tc,
            decoration: InputDecoration(
              enabled: false,
              label: Text(label),
            ),
          ),
          maxWidth: double.infinity,
        ),
      ),
    );
  }

  Widget _buildFields({required List<TripServiceField> fields}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: TripAccordion(
        visualDensity: -3,
        titleWidget: appText(
          'Service Details',
          color: AppColors.brownishGrey,
        ),
        listTileColor: AppColors.veryLightBlue,
        titleColor: AppColors.brownishGrey,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            height(8),
            Wrap(
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: fields.map((TripServiceField e) {
                TextEditingController _textEditingController =
                    TextEditingController();
                String _value = e.value ?? '';
                if (e.text == "Brief Notes") _value = parse(_value).body!.text;
                _textEditingController.text = _value;

                if (e.text == "Brief Notes") {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: CustomWidgets().buildConstrainedTextFormField(
                      TextFormField(
                        controller: _textEditingController,
                        readOnly: true,
                        decoration: InputDecoration(labelText: e.text),
                      ),
                    ),
                  );
                }

                return _buildCustomerTextField(
                  label: "${e.text}",
                  value: _textEditingController.text,
                );

                // return Padding(
                //   padding: const EdgeInsets.all(8),
                //   child: CustomWidgets().buildConstrainedTextFormField(
                //     TextFormField(
                //       controller: _textEditingController,
                //       readOnly: true,
                //       decoration: InputDecoration(labelText: e.text),
                //     ),
                //   ),
                // );
              }).toList(),
            ),
          ],
        ),
      ),
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
        label: "Status",
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
        value: TripServiceBloc.payment.contains(selectedPaymentMethod)
            ? selectedPaymentMethod
            : null,
        onChanged: (val) {
          selectedPaymentMethod = val ?? '';
        },
        label: "Payment",
      ),
    );
  }

  Widget _buildChecklist({required List<TripChecklist> checklist}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        child: ElevatedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.checklist),
          label: const Text('Checklist'),
        ),
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
              tripServiceModalPopupPayload: TripServiceModalPopupPayload(
                  payment: selectedPaymentMethod,
                  serviceStatus: selectedStatus)));
        },
        child: BlocListener<SaveServicePopupBloc, SaveServicePopupState>(
          listener: (context, state) {
            if (state == SaveServicePopupState.success) {
              AppHelper().showSnackBar(context, message: 'Service updated');
            } else if (state == SaveServicePopupState.failure) {
              AppHelper()
                  .showSnackBar(context, message: 'Service update failed');
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
                  return CustomWidgets()
                      .buildCircularProgressSmall(color: Colors.white);
              }
            },
          ),
        ),
      ),
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
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            )
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
                      child: Icon(isDeparture
                          ? Icons.flight_takeoff_rounded
                          : Icons.flight_land_rounded),
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
                          child: Text(
                            convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                              seqSch.date ?? '',
                              isUTC: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 4),
                          child: Text(
                            convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                              seqSch.date ?? '',
                              isUTC: false,
                              timezone: seqSch.timezone,
                            ),
                          ),
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
