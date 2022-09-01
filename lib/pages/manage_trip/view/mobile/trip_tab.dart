import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/widgets/widgets.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripDataTab extends StatefulWidget {
  const TripDataTab({
    Key? key,
    required this.args,
  }) : super(key: key);

  final Map<String, String> args;

  @override
  State<TripDataTab> createState() => _TripDataTabState();
}

class _TripDataTabState extends State<TripDataTab> {
  bool isBasicDataLoading = true;
  List<Office> uasTeams = [];
  List<Customer> customers = [];
  List<Aircraft> aircraftRig = [];
  List<Operator> operators = [];
  List<FlightCategory> flightCat = [];
  Office? selectedUasTeam;
  Customer? selectedCustomer;
  Aircraft? selectedAircraft;
  Operator? selectedOperator;
  FlightCategory? selectedFlightCategory;
  bool requestCostEstimation = false;
  List<String> weightUnits = ['Kgs', 'Lbs'];
  String selectedUnit = 'Kgs';
  double kgToLbs = 2.20462;
  int newChildCount = 0;
  late String _guid;
  TripDetail? tripDetail;
  List<Aircraft> selectedChildAircrafts = [];
  List<Aircraft> newChildAircrafts = [];
  List<TripPOCContact> pocs = [];
  Map<String, TripPOCContact> tripPocMap = {};

  int childAircraftCount = 0;
  bool isEdited = false;
  bool isCustomerEdited = false;
  bool isAircraftEdited = false;
  bool isPocEdited = false;
  bool tripCostEstimation = false;

  loadBasicData() async {
    try {
      TripManagerRepository _tripRepo = TripManagerRepository();
      await Future.delayed(const Duration(milliseconds: 100));
      tripDetail = await _tripRepo.getTripManagerDetails(guid: _guid);
      tripCostEstimation = tripDetail!.tripCostEstimate!;
      await loadNecessaryData();
      setState(() {
        isBasicDataLoading = false;
      });
    } catch (e) {
      isBasicDataLoading = false;
      setState(() {});
    }
  }

  loadNecessaryData() async {
    try {
      UserRepository _userRepo = UserRepository();
      OperatorRepository _opRepo = OperatorRepository();
      AircraftRepository _airRepo = AircraftRepository();
      setState(() {
        isBasicDataLoading = true;
      });
      uasTeams = await _userRepo.getOffices();
      customers = await _userRepo.getCustomers();
      operators = await _opRepo.getOperators(
          aircraftId: tripDetail!.primaryAircraftId.toString());
      _airRepo.setCustomerId(tripDetail!.customerId.toString());
      aircraftRig = await _airRepo.getAircrafts();
      for (int i = 0; i < uasTeams.length; i++) {
        if (uasTeams[i].officeId == tripDetail!.officeId) {
          selectedUasTeam = uasTeams[i];
          break;
        }
      }
      for (int i = 0; i < customers.length; i++) {
        if (customers[i].customerId == tripDetail!.customerId) {
          selectedCustomer = customers[i];
          break;
        }
      }
      for (int i = 0; i < operators.length; i++) {
        if (operators[i].customerId == tripDetail!.operatorId) {
          selectedOperator = operators[i];
          break;
        }
      }
      for (int i = 0; i < aircraftRig.length; i++) {
        if (aircraftRig[i].aircraftId == tripDetail!.primaryAircraftId) {
          selectedAircraft = aircraftRig[i];
          break;
        }
      }
      if (tripDetail!.childAircraft != null &&
          tripDetail!.childAircraft!.isNotEmpty) {
        childAircraftCount = tripDetail!.childAircraft!.length;
        final aircraftIdMap = {};
        for (var element in aircraftRig) {
          aircraftIdMap[element.aircraftId] = element;
        }
        for (int i = 0; i < tripDetail!.childAircraft!.length; i++) {
          selectedChildAircrafts
              .add(aircraftIdMap[tripDetail!.childAircraft![i].aircraftId]);
        }
      } else {
        newChildCount = 1;
      }
      await loadPoc();
      setState(() {
        isBasicDataLoading = false;
      });
    } catch (e) {
      //print(e);
      setState(() {
        isBasicDataLoading = false;
      });
    }
  }

  loadOperatorData(aircraftId) async {
    try {
      setState(() {
        isBasicDataLoading = true;
      });
      OperatorRepository _opRepo = OperatorRepository();
      operators = await _opRepo.getOperators(aircraftId: aircraftId.toString());
      setState(() {
        isBasicDataLoading = false;
      });
    } catch (e) {
      setState(() {
        isBasicDataLoading = false;
      });
    }
  }

  loadAircraftAndFlightData(customerId) async {
    try {
      setState(() {
        isBasicDataLoading = true;
      });
      AircraftRepository _airRepo = AircraftRepository();
      _airRepo.setCustomerId(customerId.toString());
      aircraftRig = await _airRepo.getAircrafts();
      flightCat = await FlightCategoryRepository()
          .getFlightCategories(customerId: customerId.toString());
      setState(() {
        isBasicDataLoading = false;
      });
    } catch (e) {
      setState(() {
        isBasicDataLoading = false;
      });
    }
  }

  updateAircraftList() async {
    try {
      setState(() {
        isBasicDataLoading = true;
      });
      AircraftRepository _airRepo = AircraftRepository();
      _airRepo.setCustomerId(selectedCustomer!.customerId.toString());
      aircraftRig = await _airRepo.getAircrafts();
      setState(() {
        isBasicDataLoading = false;
      });
    } catch (e) {
      setState(() {
        isBasicDataLoading = false;
      });
    }
  }

  saveTripData() async {
    try {
      setState(() {
        isBasicDataLoading = true;
      });
      TripManagerRepository _tripRepo = TripManagerRepository();
      List<String> temp = tripDetail!.childAircraft != null
          ? tripDetail!.childAircraft!
              .map((e) => e.aircraftId.toString())
              .toList()
          : [];
      if (newChildAircrafts.isNotEmpty) {
        temp.addAll(
            newChildAircrafts.map((e) => e.aircraftId.toString()).toList());
      }
      List<Map<String, String>> subAirCrafts =
          temp.isNotEmpty ? temp.map((e) => {'aircraftId': e}).toList() : [];
      await _tripRepo.updateTrip(
        TripManagerPayload(
          guid: _guid,
          aircraftId: selectedAircraft!.aircraftId,
          operatorId: selectedOperator!.customerId,
          subAircrafts: subAirCrafts,
          officeId: selectedUasTeam!.officeId,
          customerId: selectedCustomer!.customerId,
          customerReference: tripDetail!.customerReference,
          creatorId: "0ae049e8-1a66-477f-9975-08818af2c7ed",
          flightCategoryId: tripDetail!.flightCategoryId,
          tripCostEstimate: tripCostEstimation,
        ),
      );
      selectedChildAircrafts = [];
      childAircraftCount = 0;
      newChildAircrafts = [];
      newChildCount = 0;
      await loadBasicData();
      setState(() {
        isBasicDataLoading = false;
      });
    } catch (e) {
      //print(e.toString());
      setState(() {
        isBasicDataLoading = false;
      });
    }
  }

  validateInputData() {
    if (selectedUasTeam == null ||
        selectedCustomer == null ||
        selectedOperator == null ||
        selectedAircraft == null) {
      return false;
    }
    return true;
  }

  loadPoc() async {
    TripManagerRepository _tripRepo = TripManagerRepository();
    pocs = await _tripRepo.getTripLookUpData(
        customerId: selectedCustomer!.customerId);
    if (tripDetail!.pOCContact != null && tripDetail!.pOCContact!.isNotEmpty) {
      for (var element in tripDetail!.pOCContact!) {
        tripPocMap[element.customercontactId.toString()] = element;
      }
    }
  }

  updatePoc() async {
    try {
      setState(() {
        isBasicDataLoading = true;
      });
      TripManagerRepository _tripRepo = TripManagerRepository();
      tripPocMap.forEach((key, value) async {
        await _tripRepo.saveLookUpData(_tripRepo.generatTripLookUpPayload(
            guid: _guid,
            customercontactId: value.customercontactId.toString()));
      });
      tripDetail = await _tripRepo.getTripManagerDetails(guid: _guid);
      await loadPoc();
      setState(() {
        isBasicDataLoading = false;
      });
    } catch (e) {
      setState(() {
        isBasicDataLoading = false;
      });
    }
  }

  @override
  void initState() {
    loadBasicData();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    _guid = widget.args['guid']!;
    return isBasicDataLoading
        ? loadingWidget()
        : SingleChildScrollView(
            child: Column(children: [
              Accordion(
                tripNumber: widget.args['tripNumber']!,
                title: 'Trip Info',
                isDashboard: false,
                guid: _guid,
                listTileColor: AppColors.accordionHeaderColor,
                isClip: false,
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: topHintBorder(
                          context: context,
                          topHint: 'Customer',
                          content: Container(
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              border: Border.all(
                                  color: AppColors.lightGreyBlue, width: 0.5),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<Customer>(
                                    focusColor: Colors.white,
                                    value: selectedCustomer,
                                    hint: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text('Customer'),
                                    ),
                                    items: customers.map((Customer value) {
                                      return DropdownMenuItem<Customer>(
                                        value: value,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: Text(
                                            value.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: null
                                    // {
                                    //   if (selectedCustomer != value) {
                                    //     setState(() {
                                    //       isBasicDataLoading = true;
                                    //       selectedCustomer = value!;
                                    //       selectedAircraft = null;
                                    //       selectedOperator = null;
                                    //       operators = [];
                                    //       aircraftRig = [];
                                    //       newChildAircrafts = [];
                                    //       selectedChildAircrafts = [];
                                    //       newChildCount = 1;
                                    //       childAircraftCount = 0;
                                    //       isEdited = true;
                                    //       isCustomerEdited = true;
                                    //       isAircraftEdited = true;
                                    //     });
                                    //     await updateAircraftList(
                                    //         selectedCustomer!.customerId);
                                    //   }
                                    // },
                                    ),
                              ),
                            ),
                          ),
                          isAllBorder: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: topHintBorder(
                        context: context,
                        topHint: 'Operator',
                        isAllBorder: true,
                        content: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                                color: AppColors.lightGreyBlue, width: 0.5),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<Operator>(
                                focusColor: AppColors.whiteColor,
                                value: selectedOperator,
                                hint: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text('Operator'),
                                ),
                                items: operators.map((Operator value) {
                                  return DropdownMenuItem<Operator>(
                                    value: value,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                        value.customerName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (selectedOperator != value) {
                                    setState(() {
                                      selectedOperator = value!;
                                      isEdited = true;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: topHintBorder(
                        context: context,
                        topHint: 'UAS Teams',
                        isAllBorder: true,
                        content: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                                color: AppColors.lightGreyBlue, width: 0.5),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<Office>(
                                  focusColor: Colors.white,
                                  value: selectedUasTeam,
                                  hint: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text('UAS Team'),
                                  ),
                                  items: uasTeams.asMap().entries.map((entry) {
                                    final value = entry.value;
                                    final index = entry.key;
                                    return DropdownMenuItem<Office>(
                                      value: value,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Text(
                                          value.officeName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: null
                                  // {
                                  //   if (selectedUasTeam != value) {
                                  //     setState(() {
                                  //       selectedUasTeam = value!;
                                  //       isEdited = true;
                                  //     });
                                  //   }
                                  // },
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: topHintBorder(
                        context: context,
                        topHint: 'Primary Registration',
                        isAllBorder: true,
                        content: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                                color: AppColors.lightGreyBlue, width: 0.5),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<Aircraft>(
                                focusColor: Colors.white,
                                value: selectedAircraft,
                                hint: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text('Primary Registration'),
                                ),
                                items: aircraftRig.map((Aircraft value) {
                                  return DropdownMenuItem<Aircraft>(
                                    value: value,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                        value.registrationNumber,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) async {
                                  if (selectedAircraft != value) {
                                    await loadOperatorData(value!.aircraftId);
                                    setState(() {
                                      selectedAircraft = value;
                                      selectedOperator = null;
                                      isAircraftEdited = true;
                                      isEdited = true;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    !isAircraftEdited
                        ? Row(
                            children: [
                              width(8),
                              Expanded(
                                flex: 3,
                                child: topHintBorder(
                                    context: context,
                                    topHint: 'Type',
                                    isAllBorder: true,
                                    content: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(
                                        tripDetail!
                                            .primaryAircraft!.aircraftType,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    )),
                              ),
                              width(8),
                              Expanded(
                                flex: 2,
                                child: topHintBorder(
                                    context: context,
                                    topHint: 'MOTW',
                                    isAllBorder: false,
                                    content: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(
                                        "${tripDetail!.primaryAircraft!.mtow}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, top: 8, bottom: 8),
                                child: Container(
                                  height: 42,
                                  decoration: const BoxDecoration(
                                      color: AppColors.powderBlue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                          value: selectedUnit,
                                          items: weightUnits.map((String unit) {
                                            return DropdownMenuItem<String>(
                                                value: unit,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(unit),
                                                ));
                                          }).toList(),
                                          onChanged: (value) {}),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: childAircraftCount + newChildCount,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return index < childAircraftCount
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: topHintBorder(
                                              context: context,
                                              topHint: 'Subsitute Registration',
                                              isAllBorder: true,
                                              content: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .lightGreyBlue,
                                                      width: 0.5),
                                                ),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: ButtonTheme(
                                                    alignedDropdown: true,
                                                    child: DropdownButton<
                                                        Aircraft>(
                                                      focusColor: Colors.white,
                                                      value: index <
                                                              selectedChildAircrafts
                                                                  .length
                                                          ? selectedChildAircrafts[
                                                              index]
                                                          : null,
                                                      hint: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 8,
                                                        ),
                                                        child: Text(
                                                            'Subsitute Registration'),
                                                      ),
                                                      items:
                                                          selectedChildAircrafts
                                                              .map((value) {
                                                        return DropdownMenuItem<
                                                            Aircraft>(
                                                          value: value,
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.65,
                                                            child: Text(
                                                              value
                                                                  .registrationNumber,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        if ((index -
                                                                childAircraftCount) ==
                                                            newChildAircrafts
                                                                .length) {
                                                          setState(() {
                                                            isEdited = true;
                                                            newChildAircrafts
                                                                .add(value!);
                                                          });
                                                        } else if (newChildAircrafts[
                                                                index -
                                                                    childAircraftCount] !=
                                                            value) {
                                                          setState(() {
                                                            isEdited = true;
                                                            newChildAircrafts[
                                                                    index -
                                                                        childAircraftCount] =
                                                                value!;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        index == 0
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (newChildAircrafts
                                                            .length ==
                                                        newChildCount) {
                                                      setState(() {
                                                        newChildCount++;
                                                      });
                                                    } else {
                                                      scafoldErrorMessage(
                                                          'Please Select the subsitute registration',
                                                          context);
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: AppColors
                                                            .defaultColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    width: 40,
                                                    height: 42,
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                      Icons.add,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        width(8),
                                        Expanded(
                                          flex: 3,
                                          child: Stack(children: [
                                            Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 42,
                                                alignment: Alignment.centerLeft,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(5)),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .lightGreyBlue)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    tripDetail!
                                                        .childAircraft![index]
                                                        .aircraftType,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 10,
                                              child: Container(
                                                  color: AppColors.whiteColor,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4),
                                                    child: Text('Type',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  )),
                                            ),
                                          ]),
                                        ),
                                        width(8),
                                        Expanded(
                                          flex: 2,
                                          child: Stack(children: [
                                            Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 42,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .lightGreyBlue),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    "${tripDetail!.childAircraft![index].mtow}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 10,
                                              child: Container(
                                                  color: AppColors.whiteColor,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4),
                                                    child: Text('MTOW',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  )),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, top: 8, bottom: 8),
                                          child: Container(
                                            height: 42,
                                            decoration: const BoxDecoration(
                                                color: AppColors.powderBlue,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5))),
                                            child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                alignedDropdown: true,
                                                child: DropdownButton<String>(
                                                    value: selectedUnit,
                                                    items: weightUnits
                                                        .map((String unit) {
                                                      return DropdownMenuItem<
                                                              String>(
                                                          value: unit,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(unit),
                                                          ));
                                                    }).toList(),
                                                    onChanged: (value) {}),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: topHintBorder(
                                          context: context,
                                          topHint: 'Subsitute Registration',
                                          isAllBorder: true,
                                          content: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              border: Border.all(
                                                  color:
                                                      AppColors.lightGreyBlue,
                                                  width: 0.5),
                                            ),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                alignedDropdown: true,
                                                child: DropdownButton<Aircraft>(
                                                  focusColor: Colors.white,
                                                  value: (index -
                                                              childAircraftCount) <
                                                          newChildAircrafts
                                                              .length
                                                      ? newChildAircrafts[index -
                                                          childAircraftCount]
                                                      : null,
                                                  hint: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                    child: Text(
                                                        'Subsitute Registration'),
                                                  ),
                                                  items: aircraftRig
                                                      .map((Aircraft value) {
                                                    return DropdownMenuItem<
                                                        Aircraft>(
                                                      value: value,
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                        child: Text(
                                                          value
                                                              .registrationNumber,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    //print('some');
                                                    if ((index -
                                                            childAircraftCount) ==
                                                        newChildAircrafts
                                                            .length) {
                                                      setState(() {
                                                        isEdited = true;
                                                        newChildAircrafts
                                                            .add(value!);
                                                      });
                                                    } else if (newChildAircrafts[
                                                            index -
                                                                childAircraftCount] !=
                                                        value) {
                                                      setState(() {
                                                        isEdited = true;
                                                        newChildAircrafts[index -
                                                                childAircraftCount] =
                                                            value!;
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    index == 0
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: InkWell(
                                              onTap: () {
                                                if (newChildAircrafts.length ==
                                                    newChildCount) {
                                                  setState(() {
                                                    newChildCount++;
                                                  });
                                                } else {
                                                  scafoldErrorMessage(
                                                      'Please Select the subsitute registration',
                                                      context);
                                                }
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: AppColors.defaultColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                width: 40,
                                                height: 42,
                                                alignment: Alignment.center,
                                                child: const Icon(
                                                  Icons.add,
                                                  color: AppColors.whiteColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                );
                        })),
                    Row(
                      children: [
                        Checkbox(
                            value: tripCostEstimation,
                            onChanged: (value) {
                              setState(() {
                                tripCostEstimation = value!;
                              });
                            }),
                        const Text('Trip Cost Estimation')
                      ],
                    )
                  ],
                ),
              ),
              Accordion(
                title: 'Point of Contacts',
                listTileColor: AppColors.accordionHeaderColor,
                isDashboard: false,
                isClip: false,
                guid: _guid,
                tripNumber: widget.args['guid']!,
                content: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LightButton(
                        buttonHeight: 42,
                        buttonText: 'Lookup',
                        isLight: false,
                        buttonWidth: MediaQuery.of(context).size.width * 0.5,
                        onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return listInList();
                            }).whenComplete(() {
                          setState(() {});
                        }),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Accordion(
                      title: 'Operations',
                      guid: _guid,
                      tripNumber: widget.args['tripNumber']!,
                      isClip: false,
                      isDashboard: false,
                      listTileColor: AppColors.accordionHeaderColor,
                      content: ListView.builder(
                          shrinkWrap: true,
                          itemCount: tripDetail!.pOCContact != null
                              ? tripDetail!.pOCContact!.length
                              : 0,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    width(10),
                                    const Icon(Icons.email),
                                    width(10),
                                    Text(tripDetail!.pOCContact![index].name),
                                  ],
                                ),
                              )),
                    ),
                  )
                ]),
              ),
              Row(
                children: [
                  LightButton(
                      buttonText: (isEdited || isPocEdited) ? 'Save' : 'Edit',
                      buttonHeight: 42,
                      buttonWidth: MediaQuery.of(context).size.width * 0.5,
                      isLight: false,
                      onPressed: () async {
                        if (isEdited && validateInputData()) {
                          await saveTripData();
                          setState(() {
                            isAircraftEdited = false;
                            isCustomerEdited = false;
                            isEdited = false;
                          });
                        }
                        if (isPocEdited) {
                          await updatePoc();
                          setState(() {
                            isPocEdited = false;
                            tripPocMap = {};
                          });
                        } else {
                          if (!isEdited) {
                            scafoldErrorMessage('Data Saved', context);
                          } else {
                            scafoldErrorMessage(
                                'Select All Required fields', context);
                          }
                        }
                      }),
                ],
              )
            ]),
          );
  }

  listInList() => SizedBox(
      height: 400,
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return ListView.builder(
              itemCount: pocs.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Checkbox(
                        value: tripPocMap.containsKey(
                            pocs[index].customercontactId.toString()),
                        onChanged: (value) {
                          if (!value!) {
                            setState(() {
                              isPocEdited = true;
                              tripPocMap.remove(
                                  pocs[index].customercontactId.toString());
                            });
                          } else {
                            setState(() {
                              isPocEdited = true;
                              tripPocMap.putIfAbsent(
                                  pocs[index].customercontactId.toString(),
                                  (() => pocs[index]));
                            });
                          }
                        }),
                    Expanded(
                      child: Accordion(
                          title: pocs[index].name,
                          guid: _guid,
                          tripNumber: widget.args['tripNumber']!,
                          isClip: false,
                          isDashboard: false,
                          content: Container(
                            alignment: Alignment.center,
                            height: 120,
                            child: ListView.builder(
                                itemCount: pocs[index].callRecords!.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon((pocs[index]
                                                    .callRecords![i]
                                                    .medium
                                                    .toLowerCase() ==
                                                'email')
                                            ? Icons.email
                                            : Icons.phone),
                                        width(5),
                                        Text(pocs[index].callRecords![i].info),
                                      ],
                                    ),
                                  );
                                }),
                          )),
                    ),
                  ],
                );
              });
        },
      ));

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
}
