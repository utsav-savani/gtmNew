// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_state.dart';
import 'package:service_category_repository/service_category_repository.dart';
import 'package:gtm/pages/widgets/accordion.dart';
import 'package:gtm/pages/widgets/light_button.dart';
import 'package:gtm/pages/widgets/service_accordion.dart';
import 'dart:ui' as ui;

import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripServicesTab extends StatefulWidget {
  const TripServicesTab({Key? key, required this.args}) : super(key: key);

  final Map<String, String> args;
  @override
  State<TripServicesTab> createState() => _TripServicesTabState();
}

class _TripServicesTabState extends State<TripServicesTab> {
  List<String> contactType = ['Item1', 'Item2', 'item3'];
  List<String> status = ['Not Actioned', 'In-Progress', 'Completed'];
  List<String> through = ['UAS Direct', 'Other1', 'Other2'];
  List<String> payment = ['Credit Card', 'Debit Card', 'UPI', 'CASH'];
  List<TripServiceSchedule> schedules = [];
  TripServiceMain? mainData;
  bool isTaskMemo = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTripServicesDetails();
  }

  fetchTripServicesDetails() {
    TripServiceBloc tripDetailsBloc = BlocProvider.of<TripServiceBloc>(context);
    tripDetailsBloc.add(FetchTripService(guid: widget.args['guid']!));
  }

  @override
  Widget build(BuildContext context) {
    String guid = widget.args['guid']!;
    String tripNumber = widget.args['tripNumber']!;
    return BlocBuilder<TripServiceBloc, TripServiceState>(
      builder: (context, state) {
        if (state.status == FetchTripServiceStatus.initial ||
            state.status == FetchTripServiceStatus.loading) {
          return loadingWidget();
        }
        if (state.status == FetchTripServiceStatus.success) {
          mainData = state.tripServiceMain;
          schedules = mainData!.schedule!;
        }
        return Scaffold(
          body: SingleChildScrollView(
              child: Column(
            children: List.generate(
              schedules.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ServiceAccordion(
                  title: schedules[index].name ?? '',
                  isArrivale: schedules[index].eTA != null,
                  isDepart: schedules[index].eTD != null,
                  arrivalTime: schedules[index].eTA,
                  departTime: schedules[index].eTD,
                  isCountry: schedules[index].isOverFlight ?? false,
                  content: Container(
                    decoration: BoxDecoration(color: AppColors.lightPink),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => _searchServicesBottomSheet(
                              schedules[index], mainData!),
                          decoration: InputDecoration(
                              filled: true,
                              hintText: 'Search by services',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w100),
                              fillColor: AppColors.whiteColor,
                              contentPadding: EdgeInsets.all(8),
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                      Column(
                        children: List.generate(
                            schedules[index].services != null
                                ? schedules[index].services!.length
                                : 0,
                            (idx) => serviceDetails(
                                context,
                                schedules[index].services![idx],
                                schedules[index].services![idx].serviceStatus!,
                                false,
                                schedules[index])),
                      ),
                      Column(
                        children: List.generate(
                            schedules[index].mandatoryServicesList != null
                                ? schedules[index].mandatoryServicesList!.length
                                : 0,
                            (idx) => serviceDetails(
                                context,
                                schedules[index].mandatoryServicesList![idx],
                                '',
                                // schedules[index].mandatoryServicesList![idx].,
                                true,
                                schedules[index])),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          )),
        );
      },
    );
  }

  Padding commonDropDownButton(
      BuildContext context, String initalValue, List items, String hintText,
      {bool? removeBorder}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: removeBorder != null
              ? null
              : Border.all(color: AppColors.lightGreyBlue, width: 1),
        ),
        width: MediaQuery.of(context).size.width,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isExpanded: true,
              focusColor: Colors.white,
              value: initalValue,
              hint: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(hintText),
              ),
              items: items.asMap().entries.map((entry) {
                final value = entry.value;
                return DropdownMenuItem<String>(
                  value: value,
                  child: SizedBox(
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) async {
                setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding sequencRows(BuildContext context, String fieldvalue, String header,
      bool isIcon, Widget? icon,
      {double? iconSize, bool? removeIconback, bool? readMode}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            TextFormField(
              readOnly: readMode ?? true,
              initialValue: fieldvalue,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  filled: true,
                  labelText: header,
                  floatingLabelStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                  fillColor: readMode != null && !readMode
                      ? AppColors.whiteColor
                      : AppColors.lightBrown),
            ),
            isIcon
                ? Row(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        width: iconSize ?? 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightBlueGrey),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          color: removeIconback != null && removeIconback
                              ? AppColors.lightBlue.withOpacity(0)
                              : AppColors.lightBlue,
                        ),
                        child: icon,
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Container serviceDetails(BuildContext context, var service,
      String serviceStatus, bool isGradient, TripServiceSchedule schedule) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: const Border(
                bottom: BorderSide(color: AppColors.lightBlueGrey, width: 1),
                top: BorderSide(color: AppColors.lightBlueGrey, width: 1))),
        child: InkWell(
          onTap: () => !isGradient
              ? serviceDetailBottomSheet(service.service, schedule)
              : () {},
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 50,
                  decoration: isGradient
                      ? BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                              Color.fromARGB(255, 7, 248, 169),
                              Color.fromARGB(255, 0, 156, 244)
                            ]))
                      : BoxDecoration(),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.service,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      !isGradient
                          ? Row(
                              children: [
                                Text(
                                  'UAS : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w100),
                                ),
                                Text(
                                  serviceStatus,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: serviceStatusColor(
                                              serviceStatus)),
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: AppColors.primaryColor,
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  serviceStatusColor(String serviceStatus) {
    switch (serviceStatus.toLowerCase()) {
      case 'new':
        return AppColors.coolBlue;
      case 'in-progress':
        return AppColors.inProgress;
      case 'confirmed':
        return AppColors.confirmStatusColor;
      case 'not actioned':
        return AppColors.lightBlueGrey;
      case 'in progress':
        return AppColors.inProgress;
      default:
        return AppColors.blackColor;
    }
  }

  _searchServicesBottomSheet(
      TripServiceSchedule schedule, TripServiceMain mainData) {
    int servicesLength = (mainData.mondatoryServices != null
            ? mainData.mondatoryServices!.length
            : 0) +
        (mainData.services != null ? mainData.services!.length : 0);
    int mandatoryServiceLength = (mainData.mondatoryServices != null
        ? mainData.mondatoryServices!.length
        : 0);
    Set<String> selectedServiceIds = {};

    if (schedule.services != null) {
      for (int i = 0; i < schedule.services!.length; i++) {
        selectedServiceIds.add(schedule.services![i].serviceId.toString());
      }
    }
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setMethod) {
            return Container(
                padding: EdgeInsets.only(
                  top: (ui.window.viewPadding.top / ui.window.devicePixelRatio),
                ),
                child: Scaffold(
                  body: Column(children: [
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.mediumPink,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Row(
                                    children: [
                                      width(10),
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.blackColor,
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 16,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        fillColor: AppColors.whiteColor,
                                        filled: true,
                                        prefixIcon: Icon(Icons.search)),
                                  ),
                                )),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: AppColors.defaultColor,
                                    ),
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                      onPressed: () {
                                        addServiceBottomSheet(
                                            schedule, mainData);
                                      },
                                    ),
                                  ),
                                ))
                          ],
                        )),
                    Expanded(
                      child: ListView.separated(
                          itemCount: servicesLength,
                          separatorBuilder: (context, index) => Divider(
                                thickness: 2,
                                height: 0,
                              ),
                          itemBuilder: (context, index) {
                            if (index < mandatoryServiceLength) {
                              return selectServices(
                                  true,
                                  selectedServiceIds.contains(mainData
                                      .mondatoryServices![index]
                                      .serviceCategoryId
                                      .toString()),
                                  mainData.mondatoryServices![index].service!,
                                  () {
                                if (selectedServiceIds.contains(mainData
                                    .mondatoryServices![index].serviceCategoryId
                                    .toString())) {
                                  selectedServiceIds.remove(mainData
                                      .mondatoryServices![index]
                                      .serviceCategoryId
                                      .toString());
                                } else {
                                  selectedServiceIds.add(mainData
                                      .mondatoryServices![index]
                                      .serviceCategoryId
                                      .toString());
                                  setMethod(
                                    () {},
                                  );
                                }
                              });
                            } else {
                              return selectServices(
                                  false,
                                  selectedServiceIds.contains(mainData
                                      .services![index - mandatoryServiceLength]
                                      .serviceId
                                      .toString()),
                                  mainData
                                      .services![index - mandatoryServiceLength]
                                      .service!,
                                  () {});
                            }
                          }),
                    ),
                  ]),
                ));
          });
        });
  }

  Row selectServices(
      bool isGradient, bool isSelected, String serviceName, Function onChange) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 45,
          decoration: isGradient
              ? BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 7, 248, 169),
                      Color.fromARGB(255, 0, 156, 244),
                    ],
                  ),
                )
              : BoxDecoration(),
        ),
        Checkbox(value: isSelected, onChanged: (value) => onChange),
        Expanded(
          child: Text(
            serviceName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  Stack topHintBorder(
      {required BuildContext context,
      required String topHint,
      required Widget content,
      required bool isAllBorder}) {
    return Stack(children: [
      Container(
        height: 54,
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 42,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGreyBlue, width: 1),
              borderRadius: isAllBorder
                  ? const BorderRadius.all(Radius.circular(5))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
          child: content,
        ),
      ),
      Positioned(
        left: 10,
        child: Container(
            color: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(topHint,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold)),
            )),
      ),
    ]);
  }

  serviceDetailBottomSheet(String serviceName, TripServiceSchedule schedule) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: StatefulBuilder(builder: (context, setMethod) {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color: AppColors.defaultColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            serviceName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.clear,
                                color: AppColors.whiteColor,
                              )),
                          width(10)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Accordion(
                                title: schedule.name!,
                                guid: '',
                                isDashboard: false,
                                listTileColor: AppColors.accordionHeaderColor,
                                tripNumber: tripNumber,
                                isClip: false,
                                content: Column(children: [
                                  sequencRows(
                                      context,
                                      'Jet Aviation Sudia Arabia Co. LTD',
                                      'Vendor',
                                      false,
                                      null),
                                  sequencRows(
                                      context,
                                      '24/03/2022-19:00 Z',
                                      'Arrv.(OERK) Date & Time',
                                      true,
                                      svgToIcon(
                                          appImagesName:
                                              'assets/images/arrive_icon.svg')),
                                  sequencRows(
                                      context,
                                      '24/03/2022-19:00 Z',
                                      'Dept.(OERK) Date & Time',
                                      true,
                                      svgToIcon(
                                          appImagesName:
                                              'assets/images/departure_icon.svg')),
                                  sequencRows(
                                      context,
                                      '+96611220188',
                                      'Telephone',
                                      true,
                                      svgToIcon(
                                          appImagesName:
                                              'assets/images/noun-telephone.svg')),
                                  sequencRows(
                                      context,
                                      'ops@uas.aero',
                                      'Email',
                                      true,
                                      svgToIcon(
                                          appImagesName:
                                              'assets/images/email_green.svg')),
                                  commonDropDownButton(context, 'Item1',
                                      contactType, 'Other ways of contact'),
                                ]),
                              ),
                              Positioned(
                                top: 10,
                                left: MediaQuery.of(context).size.width * 0.55,
                                child: Row(
                                  children: [
                                    Text('UTC',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.normal)),
                                    Switch(
                                        activeColor: AppColors.greenColor,
                                        inactiveThumbColor:
                                            AppColors.greenColor,
                                        inactiveTrackColor:
                                            AppColors.whiteColor,
                                        value: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        }),
                                    Text('LCL',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Accordion(
                              title: serviceName,
                              guid: '',
                              tripNumber: tripNumber,
                              isDashboard: false,
                              isClip: false,
                              listTileColor: AppColors.accordionHeaderColor,
                              content: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(4),
                                          floatingLabelStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.primaryColor),
                                          hintText: 'UAS Reference Field',
                                          labelText: 'Service Refrences'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(4),
                                        hintText: 'Brief Notes',
                                      ),
                                      maxLines: 4,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 2, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      AppColors.lightBlueGrey),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight:
                                                      Radius.circular(5))),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isTaskMemo = true;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Tasks/Memos',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: isTaskMemo
                                                            ? AppColors
                                                                .deepPurple
                                                            : AppColors
                                                                .blackColor,
                                                        fontWeight: isTaskMemo
                                                            ? FontWeight.bold
                                                            : FontWeight
                                                                .normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 2, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      AppColors.lightBlueGrey),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight:
                                                      Radius.circular(5))),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isTaskMemo = false;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'History Log',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: !isTaskMemo
                                                            ? AppColors
                                                                .deepPurple
                                                            : AppColors
                                                                .blackColor,
                                                        fontWeight: !isTaskMemo
                                                            ? FontWeight.bold
                                                            : FontWeight
                                                                .normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 8, right: 8),
                                    child: TextFormField(
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(4),
                                          hintText: isTaskMemo
                                              ? 'Task/Memos'
                                              : 'History Log'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: topHintBorder(
                                            context: context,
                                            topHint: 'Status',
                                            isAllBorder: true,
                                            content: commonDropDownButton(
                                                context,
                                                'Not Actioned',
                                                status,
                                                'Status',
                                                removeBorder: true),
                                          ),
                                        ),
                                        width(10),
                                        Expanded(
                                          child: topHintBorder(
                                            context: context,
                                            topHint: 'Through',
                                            isAllBorder: true,
                                            content: commonDropDownButton(
                                                context,
                                                'UAS Direct',
                                                through,
                                                'Through',
                                                removeBorder: true),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: topHintBorder(
                                      context: context,
                                      topHint: 'Payment',
                                      isAllBorder: true,
                                      content: commonDropDownButton(context,
                                          'Credit Card', payment, 'Payment',
                                          removeBorder: true),
                                    ),
                                  ),
                                  sequencRows(
                                      context,
                                      'Checklist',
                                      'Checklist',
                                      true,
                                      svgToIcon(
                                          appImagesName:
                                              'assets/images/checklist.svg')),
                                  sequencRows(
                                      context,
                                      'Doc-1',
                                      'Attachment',
                                      true,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          svgToIcon(
                                              appImagesName:
                                                  'assets/images/attachment.svg'),
                                          width(10),
                                          Text(
                                            'Upload',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color:
                                                        AppColors.defaultColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      iconSize:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      readMode: false),
                                  Row(
                                    children: [
                                      LightButton(
                                        buttonText: 'Cancel',
                                        buttonHeight: 42,
                                        buttonWidth:
                                            MediaQuery.of(context).size.width,
                                        isLight: true,
                                        onPressed: () {},
                                        buttonColor: AppColors.powderBlue,
                                        textColor: AppColors.whiteColor,
                                      ),
                                      LightButton(
                                        buttonText: 'Edit',
                                        buttonHeight: 42,
                                        buttonWidth:
                                            MediaQuery.of(context).size.width,
                                        isLight: true,
                                        onPressed: () {},
                                        buttonColor: AppColors.defaultColor,
                                        textColor: AppColors.whiteColor,
                                      ),
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }

  addServiceBottomSheet(
      TripServiceSchedule schedule, TripServiceMain mainData) {
    List<bool> isListExpanded = [];
    List<ServiceCategory> serviceCategories = [];
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(
              top: (ui.window.viewPadding.top / ui.window.devicePixelRatio),
            ),
            child: BlocBuilder<ServiceCategoriesBloc, ServiceCategoriesState>(
              builder: (context, state) {
                if (state.status == FetchServiceCategoriesState.initial ||
                    state.status == FetchServiceCategoriesState.loading) {
                  return loadingWidget();
                } else if (state.status ==
                    FetchServiceCategoriesState.success) {
                  serviceCategories = state.serviceCategories;
                  isListExpanded = List.filled(serviceCategories.length, false);
                }
                return Scaffold(
                  body: StatefulBuilder(builder: (context, setMethod) {
                    return Column(children: [
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.mediumPink,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Row(
                                      children: [
                                        width(10),
                                        Icon(
                                          Icons.arrow_back_ios,
                                          color: AppColors.blackColor,
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 16,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          fillColor: AppColors.whiteColor,
                                          filled: true,
                                          hintText: 'Add adhoc services',
                                          prefixIcon: Icon(Icons.search)),
                                    ),
                                  )),
                              Expanded(child: Container())
                            ],
                          )),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                        children: List.generate(
                            serviceCategories.length,
                            (index) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            tristate: true,
                                            value: false,
                                            onChanged: (value) {}),
                                        Text(serviceCategories[index].name),
                                        Expanded(child: Container()),
                                        serviceCategories[index]
                                                        .childServiceCategory !=
                                                    null &&
                                                serviceCategories[index]
                                                    .childServiceCategory!
                                                    .isNotEmpty
                                            ? IconButton(
                                                icon: Icon(isListExpanded[index]
                                                    ? Icons.arrow_drop_up
                                                    : Icons.arrow_drop_down),
                                                onPressed: () {
                                                  setMethod(() {
                                                    isListExpanded[index] =
                                                        !isListExpanded[index];
                                                  });
                                                },
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    isListExpanded[index]
                                        ? Column(
                                            children: List.generate(
                                                serviceCategories[index]
                                                            .childServiceCategory !=
                                                        null
                                                    ? serviceCategories[index]
                                                        .childServiceCategory!
                                                        .length
                                                    : 0,
                                                (idx1) => Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            width(30),
                                                            Checkbox(
                                                                value: false,
                                                                onChanged:
                                                                    (value) {}),
                                                            Text(serviceCategories[
                                                                    index]
                                                                .childServiceCategory![
                                                                    idx1]
                                                                .name),
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            serviceCategories[index]
                                                                            .childServiceCategory![
                                                                                idx1]
                                                                            .childServiceCategory !=
                                                                        null &&
                                                                    serviceCategories[
                                                                            index]
                                                                        .childServiceCategory![
                                                                            idx1]
                                                                        .childServiceCategory!
                                                                        .isNotEmpty
                                                                ? IconButton(
                                                                    icon: Icon(isListExpanded[
                                                                            index]
                                                                        ? Icons
                                                                            .arrow_drop_up
                                                                        : Icons
                                                                            .arrow_drop_down),
                                                                    onPressed:
                                                                        () {},
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                          )
                                        : Container()
                                  ],
                                )),
                      )))
                    ]);
                  }),
                );
              },
            ),
          );
        });
  }
}

class SearchServiceCustomObject {
  String serviceId;
  String serviceName;
  bool isMandatory;
  SearchServiceCustomObject(this.serviceId, this.serviceName, this.isMandatory);
}
