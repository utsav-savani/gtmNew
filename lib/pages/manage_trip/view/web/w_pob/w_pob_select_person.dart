import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/extensions/string_extension.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_persons/pob_persons_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/save_pob/save_pob_person_bloc.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

import './w_pob_page.dart';
import '../../../bloc/pob/pob_persons/pob_persons_state.dart';

enum ListType { all, captain, crew, passenger }

class WPOBSelectPerson extends StatefulWidget {
  final String guid;
  final List<TripPobSchedule> tripPOBListSchedule;

  const WPOBSelectPerson(this.guid, this.tripPOBListSchedule, {Key? key})
      : super(key: key);

  @override
  State<WPOBSelectPerson> createState() => _WPOBSelectPersonState();
}

class _WPOBSelectPersonState extends State<WPOBSelectPerson> {
  int segmentGroupValue = 0;
  List<TripPerson> personsList = [];
  List<TripPerson> filteredList = [];
  List<POBPersonCommonState<TripPerson>> listState = [];
  List<List<POBPersonCommonState<Passport>>> passportListState = [];
  List<POBPersonCommonState<TripPobSchedule>> sequenceListState = [];
  final TextEditingController _sequenceSearchController =
      TextEditingController();

  final ValueNotifier<bool> _displayBottomSheet = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<POBPersonsBloc, POBPersonsState>(
      listener: (context, state) {},
      child: BlocBuilder<POBPersonsBloc, POBPersonsState>(
        builder: (context, personsState) {
          switch (personsState.status) {
            case FetchPOBPersonsState.initial:
            case FetchPOBPersonsState.loading:
              return getProgress();
            case FetchPOBPersonsState.success:
              // List States
              personsList.clear();
              personsList.addAll(personsState.tripPersons);
              filteredList.clear();
              filteredList.addAll(personsList);
              listState = filteredList
                  .map((e) =>
                      POBPersonCommonState(e, false, val2: false, val3: false))
                  .toList();
              passportListState = filteredList.map((e) {
                if (e.passport == null) {
                  return <POBPersonCommonState<Passport>>[];
                } else {
                  return e.passport!.map((e) {
                    if (e.preference != null) {
                      if (e.preference == '1') {
                        return POBPersonCommonState<Passport>(e, true);
                      }
                    }
                    return POBPersonCommonState<Passport>(e, false);
                  }).toList();
                }
              }).toList();
              //

              return StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Column(
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
                            // close bottom sheet
                            _displayBottomSheet.value = false;
                            int value = val as int;
                            setState(() {
                              {
                                segmentGroupValue = value;
                                switch (segmentGroupValue) {
                                  case 0:
                                    filteredList = personsList;
                                    break;
                                  case 1:
                                    filteredList = personsList.where((element) {
                                      if (element.roles == null) {
                                        return false;
                                      }
                                      String roles = element.roles!.join(',');
                                      return roles.toLowerCase().contains(
                                          POBListBloc.captain.toLowerCase());
                                    }).toList();
                                    break;
                                  case 2:
                                    filteredList = personsList.where((element) {
                                      if (element.roles == null) {
                                        return false;
                                      }
                                      String roles = element.roles!.join(',');
                                      return roles.toLowerCase().contains(
                                          POBListBloc.crew.toLowerCase());
                                    }).toList();
                                    break;
                                  case 3:
                                    filteredList = personsList.where((element) {
                                      if (element.roles == null) {
                                        return false;
                                      }
                                      String roles = element.roles!.join(',');
                                      return roles.toLowerCase().contains(
                                          POBListBloc.passenger.toLowerCase());
                                    }).toList();
                                    break;
                                  default:
                                    filteredList = personsList;
                                    break;
                                }
                                listState = filteredList
                                    .map((e) => POBPersonCommonState(e, false,
                                        val2: false, val3: false))
                                    .toList();
                                passportListState = filteredList.map((e) {
                                  if (e.passport == null) {
                                    return <POBPersonCommonState<Passport>>[];
                                  } else {
                                    return e.passport!.map((e) {
                                      if (e.preference != null) {
                                        if (e.preference == '1') {
                                          return POBPersonCommonState<Passport>(
                                              e, true);
                                        }
                                      }
                                      return POBPersonCommonState<Passport>(
                                          e, false);
                                    }).toList();
                                  }
                                }).toList();
                              }
                            });
                          },
                          selectedColor: AppColors.deepLilac,
                          unselectedColor: Colors.white,
                          groupValue: segmentGroupValue,
                        ),
                      ),
                      Expanded(
                        child: () {
                          switch (segmentGroupValue) {
                            case 0:
                              return displayList(ListType.all);
                            case 1:
                              return displayList(ListType.captain);
                            case 2:
                              return displayList(ListType.crew);
                            case 3:
                              return displayList(ListType.passenger);
                            default:
                              return getNoData();
                          }
                        }(),
                      ),
                    ],
                  );
                },
              );
            case FetchPOBPersonsState.failure:
              return getNoData();
          }
        },
      ),
    ));
  }

  void collapseOtherItems(int selectedIndex) {
    List<POBPersonCommonState<TripPerson>> tempList = [];
    for (int i = 0; i < listState.length; i++) {
      if (i == selectedIndex) {
        tempList.add(POBPersonCommonState(listState[i].data, listState[i].val1,
            val2: listState[i].val2, val3: listState[i].val3));
      } else {
        tempList.add(POBPersonCommonState(listState[i].data, false,
            val2: false, val3: listState[i].val3));
      }
    }
    listState.clear();
    listState.addAll(tempList);
  }

  Widget displayList(ListType type) {
    bool isBottomSheetVisible = false;
    bool isAllList = false;
    bool isCaptainList = false;
    bool isCrewPassengerList = false;
    switch (type) {
      case ListType.all:
        isAllList = true;
        isCaptainList = false;
        isCrewPassengerList = false;
        break;
      case ListType.captain:
        isAllList = false;
        isCaptainList = true;
        isCrewPassengerList = false;
        break;
      case ListType.crew:
      case ListType.passenger:
        isAllList = false;
        isCaptainList = false;
        isCrewPassengerList = true;
        break;
    }
    try {
      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    TripPerson tripPerson = filteredList[index];
                    String roles = tripPerson.roles != null
                        ? tripPerson.roles!.join(',')
                        : '';
                    // Checking person exists in schedule
                    bool personExistsInSchedule = false;
                    TripPobSchedule tripPOBSchedule =
                        widget.tripPOBListSchedule[selectedSequenceIndex.value];
                    if (tripPOBSchedule.pobLists != null) {
                      personExistsInSchedule = tripPOBSchedule.pobLists!
                          .where((element) =>
                              element.personId == tripPerson.personId)
                          .toList()
                          .isNotEmpty;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              if (!isCrewPassengerList ||
                                  personExistsInSchedule)
                                const Padding(
                                  padding: EdgeInsets.only(right: 16, left: 16),
                                  child: Icon(Icons.account_circle_rounded),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 16),
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Visibility(
                                        visible: listState[index].val3,
                                        child: GestureDetector(
                                          child: const Icon(Icons.check_circle),
                                          onTap: () {
                                            setState(() {
                                              listState[index].val3 =
                                                  !listState[index].val3;
                                            });
                                            isBottomSheetVisible = listState
                                                    .where((element) =>
                                                        element.val3)
                                                    .toList()
                                                    .length >
                                                1;
                                            _displayBottomSheet.value =
                                                isBottomSheetVisible;
                                          },
                                        ),
                                        replacement: GestureDetector(
                                          child: const Icon(
                                              Icons.account_circle_rounded),
                                          onTap: () {
                                            setState(() {
                                              listState[index].val3 =
                                                  !listState[index].val3;
                                            });
                                            isBottomSheetVisible = listState
                                                    .where((element) =>
                                                        element.val3)
                                                    .toList()
                                                    .length >
                                                1;
                                            _displayBottomSheet.value =
                                                isBottomSheetVisible;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(tripPerson.name),
                                      Text(roles),
                                    ],
                                  ),
                                ),
                              ),
                              if (!isAllList)
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Row(
                                    children: [
                                      RotatedBox(
                                        quarterTurns:
                                            listState[index].val1 ? 1 : 0,
                                        child: IconButton(
                                          icon: const Icon(
                                              Icons.arrow_forward_ios_rounded),
                                          onPressed: () {
                                            setState(() {
                                              listState[index].val1 =
                                                  !listState[index].val1;
                                              collapseOtherItems(index);
                                            });
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        icon: listState[index].val2
                                            ? const Icon(Icons.person_add_alt_1)
                                            : const Icon(Icons.person_add_alt),
                                        onPressed: () {
                                          setState(() {
                                            listState[index].val2 =
                                                !listState[index].val2;
                                            collapseOtherItems(index);
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                )
                              else
                                Container()
                            ],
                          ),
                          Visibility(
                            visible: listState[index].val1,
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            child: getPassportView(index),
                          ),
                          Visibility(
                            visible: listState[index].val2,
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            child: getAddToSequenceView(tripPerson, index,
                                type: type),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _displayBottomSheet,
                builder: (context, bool value, child) {
                  return Visibility(
                      visible: value,
                      child: () {
                        List<TripPobSchedule> tripPOBScheduleList =
                            widget.tripPOBListSchedule;
                        if (tripPOBScheduleList.isEmpty) {
                          return getNoData();
                        }
                        List<POBPersonCommonState<TripPobSchedule>>
                            sequenceListState = [];
                        sequenceListState = tripPOBScheduleList
                            .map((e) => POBPersonCommonState(e, false))
                            .toList();
                        sequenceListState.removeLast();
                        List<POBPersonCommonState<TripPobSchedule>>
                            filteredList = [...sequenceListState];
                        bool saveEnabled = false;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: AppColors.lightBlueGrey)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Theme(
                                          data: ThemeData(),
                                          child: TextFormField(
                                            controller:
                                                _sequenceSearchController,
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.isEmpty) {
                                                  filteredList.clear();
                                                  filteredList.addAll(
                                                      sequenceListState);
                                                  return;
                                                }
                                                filteredList.clear();
                                                filteredList.addAll(
                                                    sequenceListState
                                                        .where((element) {
                                                  String title = element.data
                                                          .sourcepointwithicaoiata ??
                                                      '';
                                                  return title
                                                      .toLowerCase()
                                                      .contains(value);
                                                }).toList());
                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Search'.translate(),
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          color: AppColors.lightBlueGrey,
                                          height: 1,
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: filteredList.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  leading: Checkbox(
                                                    value: filteredList[index]
                                                        .val1,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        filteredList[index]
                                                                .val1 =
                                                            !filteredList[index]
                                                                .val1;
                                                      });
                                                      int itemIndex =
                                                          sequenceListState
                                                              .indexWhere(
                                                                  (element) {
                                                        return element.data
                                                                .tripScheduleId ==
                                                            filteredList[index]
                                                                .data
                                                                .tripScheduleId;
                                                      });
                                                      sequenceListState[
                                                                  itemIndex]
                                                              .val1 =
                                                          filteredList[index]
                                                              .val1;
                                                      final temp =
                                                          sequenceListState
                                                              .where(
                                                                  (element) =>
                                                                      element
                                                                          .val1)
                                                              .toList();
                                                      saveEnabled =
                                                          temp.isNotEmpty;
                                                    },
                                                  ),
                                                  title: Text(
                                                      'Seq ${index + 1} - ${filteredList[index].data.sourcepointwithicaoiata}'),
                                                ),
                                                const Divider(
                                                  color:
                                                      AppColors.lightBlueGrey,
                                                  height: 1,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                BlocListener<SavePOBBloc, SavePOBStatus>(
                                  listener: (context, state) {
                                    if (state == SavePOBStatus.success) {
                                      fetchPOBList(widget.guid);
                                      fetchPOBPersons(widget.guid);
                                    }
                                  },
                                  child:
                                      BlocBuilder<SavePOBBloc, SavePOBStatus>(
                                    builder: (context, state) {
                                      switch (state) {
                                        case SavePOBStatus.initial:
                                        case SavePOBStatus.success:
                                        case SavePOBStatus.failure:
                                          return Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: ElevatedButton(
                                                onPressed: saveEnabled
                                                    ? () {
                                                        String personType;
                                                        switch (type) {
                                                          case ListType.all:
                                                            personType =
                                                                POBPersonsBloc
                                                                    .all;
                                                            break;
                                                          case ListType.captain:
                                                            personType =
                                                                POBPersonsBloc
                                                                    .captain;
                                                            break;
                                                          case ListType.crew:
                                                            personType =
                                                                POBPersonsBloc
                                                                    .crew;
                                                            break;
                                                          case ListType
                                                              .passenger:
                                                            personType =
                                                                POBPersonsBloc
                                                                    .passenger;
                                                            break;
                                                        }
                                                        List<SavePOBScheduleDetailsPayload>
                                                            payload = [];
                                                        for (int i = 0;
                                                            i <
                                                                listState
                                                                    .length;
                                                            i++) {
                                                          if (listState[i]
                                                              .val3) {
                                                            TripPerson person =
                                                                listState[i]
                                                                    .data;
                                                            int? passportID;
                                                            passportListState[i]
                                                                .map((e) {
                                                              if (e.val1) {
                                                                passportID = e
                                                                    .data
                                                                    .personPassportDocumentId;
                                                              }
                                                              return null;
                                                            });
                                                            List<
                                                                    POBPersonCommonState<
                                                                        TripPobSchedule>>
                                                                selectedData =
                                                                sequenceListState
                                                                    .where((e) {
                                                              return e.val1;
                                                            }).toList();
                                                            payload.add(SavePOBScheduleDetailsPayload(
                                                                person.personId,
                                                                passportID,
                                                                personType,
                                                                selectedData
                                                                    .map((e) => e
                                                                        .data
                                                                        .tripScheduleId)
                                                                    .toList()));
                                                          }
                                                        }
                                                        savePOBPersonDetails(
                                                            payload);
                                                      }
                                                    : null,
                                                child: const Text('Save'),
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(130, 48),
                                                )),
                                          );
                                        case SavePOBStatus.loading:
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: ElevatedButton(
                                                onPressed: null,
                                                child: const SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                            color:
                                                                Colors.white)),
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(130, 48),
                                                )),
                                          );
                                      }
                                    },
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      }());
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      return Container();
    }
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

  Widget getPassportView(int tripPersonIndex) {
    if (passportListState[tripPersonIndex].isEmpty) {
      return getNoData();
    }
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: AppColors.powderBlue),
          bottom: BorderSide(width: 1, color: AppColors.powderBlue),
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
                Expanded(
                    child: Text('Expiry Date',
                        style: TextStyle(color: AppColors.brownGrey))),
                Expanded(
                    child: Text('Pref.',
                        style: TextStyle(color: AppColors.brownGrey))),
                Expanded(
                    child: Text('Nationality',
                        style: TextStyle(color: AppColors.brownGrey))),
              ],
            ),
            const Divider(
              color: AppColors.powderBlue,
            ),
            StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: passportListState[tripPersonIndex].length,
                  itemBuilder: (context, index) {
                    Passport passport =
                        passportListState[tripPersonIndex][index].data;
                    return Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Row(children: [
                                Checkbox(
                                    value: passportListState[tripPersonIndex]
                                            [index]
                                        .val1,
                                    onChanged:
                                        !passportListState[tripPersonIndex]
                                                    [index]
                                                .val1
                                            ? (val) {
                                                setState(() {
                                                  // Unchecking other passports
                                                  bool oldState =
                                                      passportListState[
                                                                  tripPersonIndex]
                                                              [index]
                                                          .val1;
                                                  for (int i = 0;
                                                      i <
                                                          passportListState[
                                                                  tripPersonIndex]
                                                              .length;
                                                      i++) {
                                                    if (i == index) {
                                                      passportListState[
                                                              tripPersonIndex][i]
                                                          .val1 = !oldState;
                                                    } else {
                                                      passportListState[
                                                              tripPersonIndex][i]
                                                          .val1 = false;
                                                    }
                                                  }
                                                });
                                              }
                                            : null),
                                Expanded(
                                    child: Text(
                                  passport.number ?? '',
                                  style: const TextStyle(
                                      color: AppColors.brownishGrey),
                                ))
                              ])),
                              const VerticalDivider(
                                color: AppColors.powderBlue,
                              ),
                              Expanded(
                                  child: Text(
                                passport.expireDate ?? '',
                                style: const TextStyle(
                                    color: AppColors.brownishGrey),
                              )),
                              const VerticalDivider(
                                color: AppColors.powderBlue,
                              ),
                              Expanded(
                                  child: Text(
                                passport.preference ?? '',
                                style: const TextStyle(
                                    color: AppColors.brownishGrey),
                              )),
                              const VerticalDivider(
                                color: AppColors.powderBlue,
                              ),
                              Expanded(
                                  child: Text(
                                passport.nationality ?? '',
                                style: const TextStyle(
                                    color: AppColors.brownishGrey),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getAddToSequenceView(TripPerson tripPerson, int passportIndex,
      {ListType type = ListType.all}) {
    List<TripPobSchedule> tripPOBScheduleList = widget.tripPOBListSchedule;
    if (tripPOBScheduleList.isEmpty) {
      return getNoData();
    }
    sequenceListState =
        tripPOBScheduleList.map((e) => POBPersonCommonState(e, false)).toList();
    sequenceListState.removeLast();
    List<POBPersonCommonState<TripPobSchedule>> filteredList = [
      ...sequenceListState
    ];
    bool saveEnabled = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.lightBlueGrey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Theme(
                      data: ThemeData(),
                      child: TextFormField(
                        controller: _sequenceSearchController,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              filteredList.clear();
                              filteredList.addAll(sequenceListState);
                              return;
                            }
                            filteredList.clear();
                            filteredList
                                .addAll(sequenceListState.where((element) {
                              String title =
                                  element.data.sourcepointwithicaoiata ?? '';
                              return title.toLowerCase().contains(value);
                            }).toList());
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search'.translate(),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.lightBlueGrey,
                      height: 1,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        bool isCheckBoxDisabled = false;
                        TripPobSchedule tripPOBSchedule =
                            filteredList[index].data;
                        if (tripPOBSchedule.pobLists != null) {
                          if (type == ListType.captain) {
                            List<TripPobScheduleDetail>
                                captainAvailabilityInSequence = tripPOBSchedule
                                    .pobLists!
                                    .where((element) =>
                                        element.type == POBPersonsBloc.captain)
                                    .toList();
                            isCheckBoxDisabled =
                                captainAvailabilityInSequence.isNotEmpty;
                          } else {
                            List<TripPobScheduleDetail>
                                personAvailabilityInSequence = tripPOBSchedule
                                    .pobLists!
                                    .where((element) =>
                                        element.personId == tripPerson.personId)
                                    .toList();
                            isCheckBoxDisabled =
                                personAvailabilityInSequence.isNotEmpty;
                          }
                        }
                        return Column(
                          children: [
                            ListTile(
                              leading: Checkbox(
                                value: filteredList[index].val1,
                                onChanged: isCheckBoxDisabled
                                    ? null
                                    : (val) {
                                        setState(() {
                                          filteredList[index].val1 =
                                              !filteredList[index].val1;
                                        });
                                        int itemIndex = sequenceListState
                                            .indexWhere((element) {
                                          return element.data.tripScheduleId ==
                                              filteredList[index]
                                                  .data
                                                  .tripScheduleId;
                                        });
                                        sequenceListState[itemIndex].val1 =
                                            filteredList[index].val1;
                                        final temp = sequenceListState
                                            .where((element) => element.val1)
                                            .toList();
                                        saveEnabled = temp.isNotEmpty;
                                      },
                              ),
                              title: Text(
                                  'Seq ${index + 1} - ${filteredList[index].data.sourcepointwithicaoiata}'),
                            ),
                            const Divider(
                              color: AppColors.lightBlueGrey,
                              height: 1,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocListener<SavePOBBloc, SavePOBStatus>(
              listener: (context, state) {
                if (state == SavePOBStatus.success) {
                  fetchPOBList(widget.guid);
                  fetchPOBPersons(widget.guid);
                }
              },
              child: BlocBuilder<SavePOBBloc, SavePOBStatus>(
                builder: (context, state) {
                  switch (state) {
                    case SavePOBStatus.initial:
                    case SavePOBStatus.success:
                    case SavePOBStatus.failure:
                      return Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                            onPressed: saveEnabled
                                ? () {
                                    List<POBPersonCommonState<Passport>>
                                        passports =
                                        passportListState[passportIndex];
                                    List<POBPersonCommonState<Passport>>
                                        passport = passports.where((element) {
                                      return element.val1;
                                    }).toList();
                                    int? passportDocumentID;
                                    if (passport.isNotEmpty) {
                                      passportDocumentID = passport.first.data
                                              .personPassportDocumentId ??
                                          0;
                                    }
                                    List<POBPersonCommonState<TripPobSchedule>>
                                        selectedData =
                                        sequenceListState.where((e) {
                                      return e.val1;
                                    }).toList();
                                    String personType;
                                    switch (type) {
                                      case ListType.all:
                                        personType = POBPersonsBloc.all;
                                        break;
                                      case ListType.captain:
                                        personType = POBPersonsBloc.captain;
                                        break;
                                      case ListType.crew:
                                        personType = POBPersonsBloc.crew;
                                        break;
                                      case ListType.passenger:
                                        personType = POBPersonsBloc.passenger;
                                        break;
                                    }
                                    SavePOBScheduleDetailsPayload payload =
                                        SavePOBScheduleDetailsPayload(
                                            tripPerson.personId,
                                            passportDocumentID,
                                            personType,
                                            selectedData
                                                .map((e) =>
                                                    e.data.tripScheduleId)
                                                .toList());
                                    savePOBPersonDetails([payload]);
                                  }
                                : null,
                            child: const Text('Save'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(130, 48),
                            )),
                      );
                    case SavePOBStatus.loading:
                      return Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                            onPressed: null,
                            child: const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(130, 48),
                            )),
                      );
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }

  savePOBPersonDetails(List<SavePOBScheduleDetailsPayload> payload) {
    SavePOBBloc editPOBSequenceBloc = BlocProvider.of<SavePOBBloc>(context);
    editPOBSequenceBloc
        .add(SavePOBScheduleDetails(podScheduleDetails: payload));
  }

  fetchPOBList(String guid) {
    POBListBloc pobListBloc = BlocProvider.of<POBListBloc>(context);
    pobListBloc.add(FetchPOBList(guid: guid));
  }

  fetchPOBPersons(String guid) {
    POBPersonsBloc pobPersonsBloc = BlocProvider.of<POBPersonsBloc>(context);
    pobPersonsBloc.add(FetchPOBPersons(guid: guid));
  }
}

class POBPersonCommonState<T> {
  T data;
  bool val1;
  bool val2;
  bool val3;

  POBPersonCommonState(this.data, this.val1,
      {this.val2 = false, this.val3 = false});
}
