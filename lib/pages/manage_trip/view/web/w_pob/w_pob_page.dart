import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/extensions/string_extension.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/edit_delete_pob_sequence/edit_delete_pob_sequence_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_state.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_persons/pob_persons_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_persons/pob_persons_state.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/report/download_report_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/report/download_report_state.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/save_pob/save_pob_person_bloc.dart';
import 'package:gtm/pages/manage_trip/view/mobile/trip_schedule_pob.dart';
import 'package:gtm/pages/manage_trip/view/web/w_pob/w_pob_person_details_page.dart';
import 'package:gtm/pages/manage_trip/view/web/w_pob/w_pob_select_person.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';
import 'package:url_launcher/url_launcher.dart';

final ValueNotifier<int> selectedSequenceIndex = ValueNotifier<int>(0);
final ValueNotifier<bool> isLastTabSelected = ValueNotifier<bool>(false);

class WPOBPage extends StatefulWidget {
  final TripDetail? tripDetail;
  final String guid;

  const WPOBPage({required this.tripDetail, Key? key, required this.guid}) : super(key: key);

  @override
  State<WPOBPage> createState() => _WPOBPageState();
}

class _WPOBPageState extends State<WPOBPage> {
  final TextEditingController _searchBoxController = TextEditingController();
  int segmentGroupValue = 0;
  late EditDeletePOBSequenceBloc editDeletePOBSequence;
  List<TripScheduleSavePOB> savePOBPayload = [];

  @override
  void didChangeDependencies() {
    fetchPOBPersons(widget.guid);
    fetchPOBList(widget.guid);
    editDeletePOBSequence = BlocProvider.of<EditDeletePOBSequenceBloc>(context);
    super.didChangeDependencies();
  }

  fetchPOBList(String guid) {
    POBListBloc pobListBloc = BlocProvider.of<POBListBloc>(context);
    pobListBloc.add(FetchPOBList(guid: guid));
  }

  fetchPOBPersons(String guid) {
    POBPersonsBloc pobPersonsBloc = BlocProvider.of<POBPersonsBloc>(context);
    pobPersonsBloc.add(FetchPOBPersons(guid: guid));
  }

  filterPOBList(String type, int tripScheduleID) {
    POBListBloc pobListBloc = BlocProvider.of<POBListBloc>(context);
    pobListBloc.add(FilterPOBList(filterText: type, tripScheduleID: tripScheduleID));
  }

  savePOBDetails(List<UnknownPersons> unknownPersons) {
    SavePOBBloc updatePOBBloc = BlocProvider.of<SavePOBBloc>(context);
    updatePOBBloc.add(SavePOBDetails(unknownPersons: unknownPersons));
  }

  editPersonPassportSequence(int? personID, int? personPassportDocumentID, List<Map<String, dynamic>> selectedAirports) {
    editDeletePOBSequence.add(EditPersonPassportSequence(
        personID: personID ?? 0, personPassportDocumentID: personPassportDocumentID ?? 0, selectedAirports: selectedAirports));
  }

  deletePersonFromSequence(int tripPOBId) {
    editDeletePOBSequence.add(DeletePOBSequence(tripPobId: tripPOBId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<POBListBloc, POBListState>(
      listener: (context, state) {
        if (state.status == FetchPOBListState.success) {
          savePOBPayload.clear();
          savePOBPayload = state.tripPOBListSchedule!.persons.map((e) => TripScheduleSavePOB(e.tripScheduleId)).toList();
        }
      },
      child: BlocBuilder<POBListBloc, POBListState>(
        builder: (context, listState) {
          switch (listState.status) {
            case FetchPOBListState.initial:
            case FetchPOBListState.loading:
              return getProgress();
            case FetchPOBListState.success:
              return Scaffold(
                endDrawer: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Drawer(
                    child: BlocListener<POBPersonsBloc, POBPersonsState>(
                      listener: (context, state) {},
                      child: BlocBuilder<POBPersonsBloc, POBPersonsState>(
                        builder: (context, personsState) {
                          switch (personsState.status) {
                            case FetchPOBPersonsState.initial:
                            case FetchPOBPersonsState.loading:
                              return getProgress();
                            case FetchPOBPersonsState.success:
                              return WPOBSelectPerson(widget.guid, listState.tripPOBListSchedule!.persons);
                            case FetchPOBPersonsState.failure:
                              return getNoData();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                body: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: DefaultTabController(
                              length: listState.tripPOBListSchedule!.persons.length,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TabBar(
                                          onTap: (value) {
                                            selectedSequenceIndex.value = value;
                                            isLastTabSelected.value = value == listState.tripPOBListSchedule!.persons.length - 1;
                                          },
                                          indicatorWeight: 1,
                                          isScrollable: true,
                                          tabs: listState.tripPOBListSchedule!.persons.map((e) {
                                            return getTab(heading: e.sourcepointwithicaoiata ?? '', landing: e.eTa ?? '', takeOff: e.eTD ?? '');
                                          }).toList(),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            POBDownloadReportBloc pobDownloadReportBloc = BlocProvider.of(context);
                                            pobDownloadReportBloc.add(DownloadReport(
                                                guid: widget.guid,
                                                pob: listState.tripPOBListSchedule!.persons[selectedSequenceIndex.value],
                                                office: listState.tripPOBListSchedule!.tripOffice));
                                          },
                                          child: BlocListener<POBDownloadReportBloc, DownloadReportState>(
                                            listener: (context, state) {
                                              if (state.status == DownloadReportStatus.success) {
                                                String reportURL = state.reportURL;
                                                if (reportURL.isEmpty) {
                                                  AppHelper().showSnackBar(context, message: 'Unable to find the report');
                                                  return;
                                                }
                                                launchUrl(Uri.parse(reportURL));
                                              }
                                              if (state.status == DownloadReportStatus.failure) {
                                                AppHelper().showSnackBar(context, message: 'Download report failed');
                                              }
                                            },
                                            child: BlocBuilder<POBDownloadReportBloc, DownloadReportState>(
                                              builder: (context, state) {
                                                switch (state.status) {
                                                  case DownloadReportStatus.loading:
                                                    return CustomWidgets().buildCircularProgressSmall();
                                                  case DownloadReportStatus.initial:
                                                  case DownloadReportStatus.success:
                                                  case DownloadReportStatus.failure:
                                                    return const Text('Download Report');
                                                }
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: () {
                                          List<Widget> tabBars = [];
                                          for (int i = 0; i < listState.tripPOBListSchedule!.persons.length; i++) {
                                            tabBars.add(getTabBarView(listState.tripPOBListSchedule!.persons[i],
                                                isLastTab: i == listState.tripPOBListSchedule!.persons.length - 1));
                                          }
                                          return tabBars;
                                        }(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: isLastTabSelected,
                      builder: (context, value, widget) {
                        //print(value);
                        return RotatedBox(
                          quarterTurns: 3,
                          child: ElevatedButton(
                            onPressed: value
                                ? null
                                : () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)))),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Select Crew/Passenger',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            case FetchPOBListState.failure:
              return getNoData();
          }
        },
      ),
    );
  }

  getNoData() {
    return Center(
      child: Text('noDataFound'.translate()),
    );
  }

  getProgress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  getDataColumn(String label) {
    return DataColumn2(
      label: Text(label, style: const TextStyle(color: AppColors.dataTableColumnHeaderColor)),
      size: ColumnSize.L,
    );
  }

  Widget getTabBarView(TripPobSchedule schedule, {bool isLastTab = false}) {
    if (isLastTab) {
      return Container();
    }
    int segmentGroupValue = 0;
    List<TripPobScheduleDetail> pobList = schedule.pobLists ?? [];
    List<TripPobScheduleDetail> filteredList = List.from(pobList);
    int? crewCount = schedule.crewCount;
    int? passengerCount = schedule.passengerCount;
    try {
      savePOBPayload.where((element) => element.tripScheduleID == schedule.tripScheduleId).toList().first.crewCount =
          pobList.where((element) => element.type == POBListBloc.crew).length;
      savePOBPayload.where((element) => element.tripScheduleID == schedule.tripScheduleId).toList().first.passengerCount =
          pobList.where((element) => element.type == POBListBloc.passenger).length;
    } catch (e) {
      print(e);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.powderBlue,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CupertinoSegmentedControl(
                            children: {
                              0: buildSegment(POBListBloc.all),
                              1: buildSegment(POBListBloc.captain),
                              2: buildSegment(POBListBloc.crew),
                              3: buildSegment(POBListBloc.passenger),
                            },
                            onValueChanged: (val) {
                              int value = val as int;
                              setState(() {
                                {
                                  segmentGroupValue = value;
                                  switch (segmentGroupValue) {
                                    case 0:
                                      filteredList = pobList;
                                      break;
                                    case 1:
                                      filteredList = pobList.where((element) => element.type == POBListBloc.captain).toList();
                                      break;
                                    case 2:
                                      filteredList = pobList.where((element) => element.type == POBListBloc.crew).toList();
                                      break;
                                    case 3:
                                      filteredList = pobList.where((element) => element.type == POBListBloc.passenger).toList();
                                      break;
                                    default:
                                      filteredList = pobList;
                                      break;
                                  }
                                }
                              });
                            },
                            selectedColor: AppColors.deepLilac,
                            unselectedColor: Colors.white,
                            groupValue: segmentGroupValue,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: _searchBoxController,
                              onChanged: (val) {
                                String value = val.toLowerCase();
                                setState(() {
                                  segmentGroupValue = 0;
                                  filteredList = pobList.where((element) {
                                    String firstName = element.firstName ?? '';
                                    String lastName = element.lastName ?? '';
                                    String type = element.type ?? '';
                                    String passport = element.passportNumber ?? '';
                                    String pref = element.pref ?? '';
                                    String nationality = element.nationality ?? '';
                                    return firstName.contains(value) ||
                                        lastName.contains(value) ||
                                        type.contains(value) ||
                                        passport.contains(value) ||
                                        pref.contains(value) ||
                                        nationality.contains(value);
                                  }).toList();
                                });
                              },
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: Text('Search'.translate()),
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        if (_searchBoxController.text.isNotEmpty) {
                                          _searchBoxController.clear();
                                        }
                                      },
                                      icon: const Icon(Icons.clear))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              getCountWidget('Captain', pobList.where((element) => element.type == POBListBloc.captain).length.toString()),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return Row(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Builder(builder: (context) {
                                              int count = 0;
                                              List<TripScheduleSavePOB> list =
                                                  savePOBPayload.where((element) => element.tripScheduleID == schedule.tripScheduleId).toList();
                                              if (list.isNotEmpty) {
                                                count = list.first.crewCount ?? 0;
                                              }
                                              return Text(
                                                count.toString(),
                                                style: const TextStyle(color: AppColors.blueGrey, fontSize: 12),
                                              );
                                            }),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              'Crew',
                                              style: TextStyle(color: AppColors.blueGrey, fontSize: 12),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                },
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Builder(builder: (context) {
                                      int count = 0;
                                      List<TripScheduleSavePOB> list =
                                          savePOBPayload.where((element) => element.tripScheduleID == schedule.tripScheduleId).toList();
                                      if (list.isNotEmpty) {
                                        count = list.first.passengerCount ?? 0;
                                      }
                                      return Text(
                                        count.toString(),
                                        style: const TextStyle(color: AppColors.blueGrey, fontSize: 12),
                                      );
                                    }),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Passenger',
                                      style: TextStyle(color: AppColors.blueGrey, fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                              () {
                                TextEditingController crewCountController = TextEditingController();
                                TextEditingController passengerCountController = TextEditingController();
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: GestureDetector(
                                        child: const Icon(
                                          Icons.person_add_alt,
                                          size: 16,
                                        ),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Add to Crew'),
                                                  content: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 0),
                                                          child: TextFormField(
                                                            controller: crewCountController,
                                                            keyboardType: TextInputType.number,
                                                            decoration: const InputDecoration(label: Text('Crew')),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: TextFormField(
                                                            controller: passengerCountController,
                                                            decoration: const InputDecoration(label: Text('Passenger')),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                try {
                                                                  setState(() {
                                                                    // Crew count
                                                                    int? crew = savePOBPayload
                                                                            .where((element) => element.tripScheduleID == schedule.tripScheduleId)
                                                                            .toList()
                                                                            .isNotEmpty
                                                                        ? savePOBPayload
                                                                            .where((element) => element.tripScheduleID == schedule.tripScheduleId)
                                                                            .toList()
                                                                            .first
                                                                            .crewCount
                                                                        : 0;
                                                                    if (crew == null) {
                                                                      savePOBPayload
                                                                          .where((element) => element.tripScheduleID == schedule.tripScheduleId)
                                                                          .toList()
                                                                          .first
                                                                          .crewCount = int.tryParse(crewCountController.text);
                                                                    } else {
                                                                      savePOBPayload
                                                                          .where((element) => element.tripScheduleID == schedule.tripScheduleId)
                                                                          .toList()
                                                                          .first
                                                                          .crewCount = crew + (int.tryParse(crewCountController.text) ?? 0);
                                                                    }

                                                                    int? passenger = savePOBPayload
                                                                            .where((element) => element.tripScheduleID == schedule.tripScheduleId)
                                                                            .toList()
                                                                            .isNotEmpty
                                                                        ? savePOBPayload
                                                                            .where((element) => element.tripScheduleID == schedule.tripScheduleId)
                                                                            .toList()
                                                                            .first
                                                                            .passengerCount
                                                                        : 0;
                                                                    if (passenger == null) {
                                                                      savePOBPayload
                                                                          .where((element) => element.tripScheduleID == schedule.tripScheduleId)
                                                                          .toList()
                                                                          .first
                                                                          .passengerCount = int.tryParse(passengerCountController.text);
                                                                    } else {
                                                                      savePOBPayload
                                                                              .where((element) => element.tripScheduleID == schedule.tripScheduleId)
                                                                              .toList()
                                                                              .first
                                                                              .passengerCount =
                                                                          passenger + (int.tryParse(passengerCountController.text) ?? 0);
                                                                    }
                                                                  });
                                                                } catch (e) {
                                                                  //print(e);
                                                                }
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: const Text('Add'),
                                                              style: ElevatedButton.styleFrom(
                                                                minimumSize: const Size(130, 48),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        'Unknown',
                                        style: TextStyle(color: AppColors.blueGrey, fontSize: 12),
                                      ),
                                    )
                                  ],
                                );
                              }(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: DataTable2(
                          columns: [
                            getDataColumn('Surname'.translate()),
                            getDataColumn('Given Name'.translate()),
                            getDataColumn('Type'.translate()),
                            getDataColumn('Passport'.translate()),
                            getDataColumn('Pref'.translate()),
                            getDataColumn('Nationality'.translate()),
                            getDataColumn('Profile Icon'.translate()),
                            getDataColumn(''.translate()),
                            getDataColumn(''.translate()),
                          ],
                          rows: filteredList
                              .map((e) => DataRow(cells: [
                                    DataCell(Text(e.firstName ?? ''), onTap: () {
                                      showGeneralDialog(
                                        context: context,
                                        pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
                                          return Padding(
                                            padding: const EdgeInsets.all(50),
                                            child: WPOBPersonDetailsPage(personID: e.personId ?? 0, type: e.type),
                                          );
                                        },
                                      );
                                    }),
                                    DataCell(Text(e.lastName ?? '')),
                                    DataCell(Text(e.type ?? '')),
                                    DataCell(Text(e.passportNumber ?? '')),
                                    DataCell(Text(e.pref ?? '')),
                                    DataCell(Text(e.nationality ?? '')),
                                    const DataCell(Text('No Data')),
                                    DataCell(TextButton(
                                      child: const Text('Edit'),
                                      onPressed: () {
                                        showEditDialog(schedule, e);
                                      },
                                    )),
                                    DataCell(TextButton(
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        showDeleteDialog(e.tripobId);
                                      },
                                    )),
                                  ]))
                              .toList()),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: BlocListener<SavePOBBloc, SavePOBStatus>(
            listener: (context, state) {
              if(state == SavePOBStatus.success){
                AppHelper().showSnackBar(context,message: 'Saved Successfully');
              }else if(state == SavePOBStatus.failure){
                AppHelper().showSnackBar(context,message: 'Unable to save');
              }
            },
            child: BlocBuilder<SavePOBBloc, SavePOBStatus>(
              builder: (context, state) {
                switch (state) {
                  case SavePOBStatus.initial:
                  case SavePOBStatus.success:
                  case SavePOBStatus.failure:
                    return ElevatedButton(
                        onPressed: () {
                          savePOBDetails(savePOBPayload.map((e) => UnknownPersons(e.tripScheduleID, e.crewCount, e.passengerCount)).toList());
                        },
                        child: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(130, 48),
                        ));
                  case SavePOBStatus.loading:
                    return ElevatedButton(
                        onPressed: null,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(130, 48),
                        ));
                }
              },
            ),
          ),
        )
      ],
    );
  }

  showEditDialog(TripPobSchedule schedule, TripPobScheduleDetail e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit - ${e.firstName} ${e.lastName}'),
          content: Container(
            width: 500,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: AppColors.powderBlue),
                // bottom: BorderSide(width: 1, color: AppColors.powderBlue),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Expanded(
                          child: Text(
                        'Passport',
                        style: TextStyle(color: AppColors.brownGrey),
                      )),
                      Expanded(child: Text('Expiry Date', style: TextStyle(color: AppColors.brownGrey))),
                      Expanded(child: Text('Pref.', style: TextStyle(color: AppColors.brownGrey))),
                      Expanded(child: Text('Nationality', style: TextStyle(color: AppColors.brownGrey))),
                    ],
                  ),
                  const Divider(
                    color: AppColors.powderBlue,
                  ),
                  BlocBuilder<POBPersonsBloc, POBPersonsState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case FetchPOBPersonsState.initial:
                        case FetchPOBPersonsState.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case FetchPOBPersonsState.success:
                          if (state.tripPersons.isEmpty) {
                            return const Center(
                              child: Text('No data found'),
                            );
                          }
                          List<TripPerson> person = state.tripPersons.where((element) => element.personId == e.personId).toList();
                          if (person.isEmpty) {
                            return const Center(
                              child: Text('No data found'),
                            );
                          }
                          if (person.first.passport == null) {
                            return const Center(
                              child: Text('No Passports found'),
                            );
                          }
                          if (person.first.passport!.isEmpty) {
                            return const Center(
                              child: Text('No Passports found'),
                            );
                          }
                          List<POBPersonCommonState<Passport>> passports = person.first.passport!.map((e) {
                            if (e.preference != null) {
                              if (e.preference == '1') {
                                return POBPersonCommonState(e, true);
                              } else {
                                return POBPersonCommonState(e, false);
                              }
                            }
                            return POBPersonCommonState(e, false);
                          }).toList();
                          return StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: passports.length,
                                    itemBuilder: (context, index) {
                                      Passport passport = passports[index].data;
                                      return Column(
                                        children: [
                                          IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Row(children: [
                                                  Checkbox(
                                                      value: passports[index].val1,
                                                      onChanged: !passports[index].val1
                                                          ? (val) {
                                                              setState(() {
                                                                // Unchecking other passports
                                                                bool oldState = passports[index].val1;
                                                                for (int i = 0; i < passports.length; i++) {
                                                                  if (i == index) {
                                                                    passports[i].val1 = !oldState;
                                                                  } else {
                                                                    passports[i].val1 = false;
                                                                  }
                                                                }
                                                              });
                                                            }
                                                          : null),
                                                  Expanded(
                                                      child: Text(
                                                    passport.number ?? '',
                                                    style: const TextStyle(color: AppColors.brownishGrey),
                                                  ))
                                                ])),
                                                const VerticalDivider(
                                                  color: AppColors.powderBlue,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  passport.expireDate ?? '',
                                                  style: const TextStyle(color: AppColors.brownishGrey),
                                                )),
                                                const VerticalDivider(
                                                  color: AppColors.powderBlue,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  passport.preference ?? '',
                                                  style: const TextStyle(color: AppColors.brownishGrey),
                                                )),
                                                const VerticalDivider(
                                                  color: AppColors.powderBlue,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  passport.nationality ?? '',
                                                  style: const TextStyle(color: AppColors.brownishGrey),
                                                )),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.powderBlue,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  BlocListener<EditDeletePOBSequenceBloc, EditDeletePOBSequenceStatus>(
                                    listener: (BuildContext context, state) {
                                      if (state == EditDeletePOBSequenceStatus.success) {
                                        fetchPOBList(widget.guid);
                                        fetchPOBPersons(widget.guid);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: BlocBuilder<EditDeletePOBSequenceBloc, EditDeletePOBSequenceStatus>(
                                      builder: (context, state) {
                                        switch (state) {
                                          case EditDeletePOBSequenceStatus.initial:
                                          case EditDeletePOBSequenceStatus.success:
                                          case EditDeletePOBSequenceStatus.failure:
                                            return ElevatedButton(
                                                onPressed: () {
                                                  List<POBPersonCommonState<Passport>> selectedPassport =
                                                      passports.where((element) => element.val1).toList();
                                                  if (selectedPassport.isEmpty) {
                                                    return;
                                                  }
                                                  editPersonPassportSequence(e.personId, selectedPassport.first.data.personPassportDocumentId, [
                                                    {'tripScheduleId': schedule.tripScheduleId}
                                                  ]);
                                                },
                                                child: const Text('Update'),
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: const Size(130, 48),
                                                ));
                                          case EditDeletePOBSequenceStatus.loading:
                                            return ElevatedButton(
                                                onPressed: null,
                                                child: const SizedBox(
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                  height: 24,
                                                  width: 24,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: const Size(130, 48),
                                                ));
                                        }
                                      },
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        case FetchPOBPersonsState.failure:
                          return const Center(
                            child: Text('Unable to load'),
                          );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  getUnknownButton() {
    TextEditingController crewCount = TextEditingController();
    TextEditingController passengerCount = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: IconButton(
            icon: const Icon(Icons.person_add_alt),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Add to Crew'),
                      content: Column(
                        children: [
                          TextFormField(
                            controller: crewCount,
                          ),
                          TextFormField(
                            controller: passengerCount,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            'Unknown',
            style: TextStyle(color: AppColors.blueGrey, fontSize: 12),
          ),
        )
      ],
    );
  }

  getCountWidget(String title, String count) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            count,
            style: const TextStyle(color: AppColors.blueGrey, fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            title,
            style: const TextStyle(color: AppColors.blueGrey, fontSize: 12),
          ),
        )
      ],
    );
  }

  Tab getTab({String heading = '', String landing = '', String takeOff = ''}) {
    return Tab(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Text(
                  heading,
                  style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 16),
                ),
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.info_rounded,
                      size: 12,
                      color: AppColors.iconGrey,
                    )),
              ],
            ),
          ),
          Visibility(
            visible: landing.isNotEmpty,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.flight_land_rounded, size: 12, color: AppColors.iconGrey),
                  ),
                  Text(
                    convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(landing),
                    style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: takeOff.isNotEmpty,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.flight_takeoff_rounded, size: 12, color: AppColors.iconGrey),
                ),
                Text(
                  convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(takeOff),
                  style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSegment(String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  void showDeleteDialog(int? tripobId) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Are you sure want to delete?'),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                    ),
                    BlocListener<EditDeletePOBSequenceBloc, EditDeletePOBSequenceStatus>(
                      listener: (context, state) {
                        if (state == EditDeletePOBSequenceStatus.success) {
                          fetchPOBList(widget.guid);
                          fetchPOBPersons(widget.guid);
                          Navigator.pop(context);
                        }
                      },
                      child: BlocBuilder<EditDeletePOBSequenceBloc, EditDeletePOBSequenceStatus>(
                        builder: (context, state) {
                          switch (state) {
                            case EditDeletePOBSequenceStatus.initial:
                            case EditDeletePOBSequenceStatus.success:
                            case EditDeletePOBSequenceStatus.failure:
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextButton(
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<EditDeletePOBSequenceBloc>(context).add(DeletePOBSequence(tripPobId: tripobId ?? 0));
                                  },
                                ),
                              );
                            case EditDeletePOBSequenceStatus.loading:
                              return const Padding(
                                padding: EdgeInsets.all(10),
                                child: TextButton(
                                  child: CircularProgressIndicator(),
                                  onPressed: null,
                                ),
                              );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
