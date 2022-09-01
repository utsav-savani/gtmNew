import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/bloc/home_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_sub_aircraft_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_sub_aircraft_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/save_lookup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/save_trip_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/save_trip_details_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_state.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_manager_repository/src/models/_partials/primary_aircraft.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

import '../../../bloc/trip_data/aircraft/customer_sub_aricraft_event.dart';

class WTripDataPage extends StatefulWidget {
  const WTripDataPage({Key? key, required this.manageTripGuid, required this.tripDetail}) : super(key: key);
  final TripDetail? tripDetail;
  final String manageTripGuid;

  @override
  State<WTripDataPage> createState() => _TripDataPageState();
}

class _TripDataPageState extends State<WTripDataPage> with AutomaticKeepAliveClientMixin {
  TextEditingController controller = TextEditingController();

  bool _operationalOpened = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<TripDetailsBloc, FetchTripDetailsState>(
      listener: (BuildContext context, state) {},
      child: BlocBuilder<TripDetailsBloc, FetchTripDetailsState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchTripDetailsStatus.initial:
            case FetchTripDetailsStatus.loading:
              return _buildCircularProgress();
            case FetchTripDetailsStatus.success:
              fetchAircraft(state.tripDetail.customerId);
              return _buildTripDataPage(state.tripDetail);
            case FetchTripDetailsStatus.failure:
              return _buildNoData();
          }
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    fetchLookupData();
    super.didChangeDependencies();
  }

  fetchTripMangerDetails() {
    TripDetailsBloc tripDetailsBloc = BlocProvider.of<TripDetailsBloc>(context);
    tripDetailsBloc.add(FetchTripDetails(guid: widget.manageTripGuid));
  }

  Widget _buildNoData() {
    return Center(
      child: Text('noDataFound'.translate()),
    );
  }

  Widget _buildCircularProgress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTripDataPage(TripDetail tripDetail) {
    try {
      HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
      TextEditingController customerNameController = TextEditingController();
      customerNameController.text = tripDetail.customerName ?? '';
      PrimaryAircraft? primaryAircraft = tripDetail.primaryAircraft;
      ValueNotifier<Aircraft?> onPrimaryAircraftChange =
          ValueNotifier(Aircraft(aircraftId: (primaryAircraft?.aircraftId) ?? 0, registrationNumber: (primaryAircraft?.registrationNumber) ?? ''));
      List<PrimaryAircraft> childAircraft = tripDetail.childAircraft ?? [];
      List<TripPOCContact> lookupList = tripDetail.pOCContact ?? [];

      List<SubAircraftSelectionHelper<Aircraft>> substituteAircraft = childAircraft
          .map((e) => SubAircraftSelectionHelper<Aircraft>(
              items: childAircraft.map((e) => Aircraft(aircraftId: e.aircraftId, registrationNumber: e.registrationNumber)).toList()))
          .toList();

      Operator? selectedOperator;
      Office? selectedOffice;
      Aircraft? selectedPrimaryReg;
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // main container trip info 1
            SizedBox(
              height: 60.h,

              /// ROW sub container [3] items 2
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Trip Info container 2 of 1
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(spacing20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.powderBlue,
                          ),
                          borderRadius: BorderRadius.circular(formItemCorner),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: paddingMedium,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: paddingMedium,
                                    child: appText(
                                      tripInfo,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: ribbonFormElementHeight,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(ribbonTextPadding),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(formItemCorner),
                                              border: Border.all(
                                                width: 2,
                                                color: AppColors.lightBlueGrey,
                                              )),
                                          child: appText(tripDetail.customerName ?? '', color: AppColors.charcoalGrey),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: -10,
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            color: AppColors.paleGrey1,
                                            child: appText(customer, fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: paddingMedium,
                                          child: SizedBox(
                                            width: spacing260,
                                            height: spacing48,
                                            child: BlocBuilder<OperatorBloc, OperatorState>(
                                              builder: (context, state) {
                                                List<Operator> operators = state.operators ?? [];
                                                if (operators.isNotEmpty) {
                                                  selectedOperator = operators.first;
                                                }
                                                return DropdownButtonFormField<Operator>(
                                                  isExpanded: true,
                                                  hint: const Text(selectOperator),
                                                  value: selectedOperator,
                                                  items: operators.map((Operator operator) {
                                                    return DropdownMenuItem<Operator>(
                                                      value: operator,
                                                      child: Text(operator.customerName),
                                                    );
                                                  }).toList(),
                                                  onChanged: (operator) {
                                                    selectedOperator = operator;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: paddingMedium,
                                          child: SizedBox(
                                            width: spacing260,
                                            height: spacing48,
                                            child: FutureBuilder<List<Office>>(
                                              future: homeBloc.userRepository.getOffices(),
                                              builder: (context, snapshot) {
                                                List<Office> offices = snapshot.data ?? [];
                                                if (offices.isNotEmpty) {
                                                  selectedOffice = offices.first;
                                                }
                                                return DropdownButtonFormField<Office>(
                                                  isExpanded: true,
                                                  hint: const Text('UAS Team'),
                                                  value: selectedOffice,
                                                  items: offices.map((office) {
                                                    return DropdownMenuItem<Office>(
                                                      value: office,
                                                      child: Text(office.officeName),
                                                    );
                                                  }).toList(),
                                                  onChanged: (office) {
                                                    selectedOffice = office;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: paddingMedium,
                                          child: SizedBox(
                                            width: spacing260,
                                            height: spacing48,
                                            child: BlocBuilder<CustomerAircraftBloc, CustomerAircraftState>(
                                              builder: (context, state) {
                                                List<Aircraft> aircraft = state.aircrafts ?? [];
                                                if (aircraft.isNotEmpty) {
                                                  selectedPrimaryReg = aircraft.first;
                                                }
                                                return DropdownButtonFormField<Aircraft>(
                                                  isExpanded: true,
                                                  hint: const Text('Primary Registration'),
                                                  items: aircraft.map((aircraft) {
                                                    return DropdownMenuItem<Aircraft>(
                                                      value: aircraft,
                                                      child: Text(aircraft.toString()),
                                                    );
                                                  }).toList(),
                                                  onChanged: (primaryReg) {
                                                    selectedPrimaryReg = primaryReg;
                                                    onPrimaryAircraftChange.value = primaryReg;
                                                    if (primaryReg == null) {
                                                      return;
                                                    }
                                                    fetchOperators(primaryReg.aircraftId);
                                                    fetchSubAircraft(tripDetail.customerId, primaryReg.aircraftId);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: paddingMedium,
                                          child: ValueListenableBuilder<Aircraft?>(
                                            valueListenable: onPrimaryAircraftChange,
                                            builder: (context, value, child) {
                                              if (value == null) {
                                                return Container();
                                              }
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text('Type:'),
                                                        Text((value.aircraftType?.fullName) ?? ''),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text('MTOW:'),
                                                        Row(
                                                          children: [
                                                            Text((value.mtow).toString()),
                                                            Text((value.mtowUnit?.toString()) ?? ''),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: substituteAircraft.length,
                                            itemBuilder: (context, index) {
                                              ValueNotifier<Aircraft?> onAircraftChange =
                                                  ValueNotifier<Aircraft?>(substituteAircraft[index].selected);
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding: paddingMedium,
                                                          child: SizedBox(
                                                            width: spacing260,
                                                            height: spacing48,
                                                            child: BlocBuilder<CustomerSubAircraftBloc, SubAircraftState>(
                                                              builder: (context, state) {
                                                                List<Aircraft> aircraft = state.aircrafts ?? [];
                                                                if (aircraft.isNotEmpty) {
                                                                  substituteAircraft[index].selected = aircraft.first;
                                                                }
                                                                return DropdownButtonFormField<Aircraft>(
                                                                  isExpanded: true,
                                                                  value: substituteAircraft[index].selected,
                                                                  hint: const Text('Substitute Registration'),
                                                                  items: aircraft.map((Aircraft aircraft) {
                                                                    return DropdownMenuItem<Aircraft>(
                                                                      value: aircraft,
                                                                      child: Text(aircraft.toString()),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged: (Aircraft? aircraft) {
                                                                    substituteAircraft[index].selected = aircraft;
                                                                    onAircraftChange.value = aircraft;
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                substituteAircraft.removeAt(index);
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.do_not_disturb_on,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: paddingMedium,
                                                      child: ValueListenableBuilder<Aircraft?>(
                                                        builder: (BuildContext context, value, Widget? child) {
                                                          if (value == null) {
                                                            return Container();
                                                          }
                                                          return Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Text('Type:'),
                                                                    Text((value.aircraftType?.fullName) ?? ''),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Text('MTOW:'),
                                                                    Row(
                                                                      children: [
                                                                        Text((value.mtow ?? 0).toString()),
                                                                        Text((value.mtowUnit?.toString()) ?? ''),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        },
                                                        valueListenable: onAircraftChange,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              substituteAircraft.add(SubAircraftSelectionHelper(
                                                  items: childAircraft
                                                      .map((e) => Aircraft(aircraftId: e.aircraftId, registrationNumber: e.registrationNumber))
                                                      .toList()));
                                            });
                                          },
                                          icon: const Icon(Icons.add),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(spacing20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.powderBlue,
                          ),
                          borderRadius: BorderRadius.circular(spacing8),
                        ),
                        child: Padding(
                          padding: paddingMedium,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Padding(
                              padding: paddingMedium,
                              child: Text(pointofContact),
                            ),
                            Expanded(
                                child: ListView.builder(
                              itemCount: lookupList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.mail_outline_rounded,
                                    color: AppColors.powderBlue,
                                  ),
                                  title: Text(lookupList[index].name),
                                );
                              },
                            )),
                            Padding(
                              padding: paddingMedium,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.blueGrey),
                                  minimumSize: MaterialStateProperty.all<Size?>(const Size(spacing120, spacing48)),
                                ),
                                onPressed: () {
                                  showLookupDialog();
                                },
                                child: const Text(
                                  lookUp,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(spacing20),
                      child: Container(
                        width: 20.w,
                        height: 60.h,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Client Reference'),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.powderBlue),
                          borderRadius: BorderRadius.circular(spacing8),
                        ),
                      ),

                      //  Column(
                      //   children: [
                      //     SizedBox(
                      //         width: 5.w,
                      //         //// trip info container
                      //         child: MarkdownTextInput(
                      //           (String value) => setState(() => description = value),
                      //           description,
                      //           label: 'Description',
                      //           maxLines: 10,
                      //           actions: const [
                      //             MarkdownType.bold,
                      //             MarkdownType.italic,
                      //           ],
                      //           controller: controller,
                      //         )),
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 10),
                      //       child: MarkdownBody(
                      //         data: description,
                      //         shrinkWrap: true,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                ],
              ),
            ),

            // Operational notes
            Padding(
              padding: EdgeInsets.all(operationalNotesPadding),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _operationalOpened = !_operationalOpened;
                      setState(() {});
                    },
                    child: FormDropDownHeader(
                      opened: _operationalOpened,
                      text: 'Operational Notes',
                      soon: true,
                    ),
                  ),
                  Visibility(
                    visible: _operationalOpened,
                    child: Container(
                      padding: EdgeInsets.all(operationalNotesPadding),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.lightBlueGrey,
                        ),
                        borderRadius: _operationalOpened
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(formItemCorner),
                                bottomRight: Radius.circular(formItemCorner),
                              )
                            : BorderRadius.circular(formItemCorner),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'Flight',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'Permit',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'Handling',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'Fuel',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'Catering',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'Hotel',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'Transport',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'Miscellan',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(operationalNotesPadding),
                                  child: const FormDropDownHeader(
                                    opened: false,
                                    text: 'General',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: paddingMedium,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    buttonColor: AppColors.iconGrey,
                    onTap: () {},
                    buttonText: cancel,
                    textColor: AppColors.whiteColor,
                  ),
                  BlocBuilder<SaveTripDetailsBloc, SaveTripDetailsState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case SaveTripDetailsStatus.initial:
                        case SaveTripDetailsStatus.success:
                        case SaveTripDetailsStatus.failure:
                          return AppButton(
                            buttonColor: AppColors.veryLightBlue,
                            onTap: () {
                              TripManagerPayload tripPayload = TripManagerPayload(
                                guid: widget.manageTripGuid,
                                aircraftId: selectedPrimaryReg?.aircraftId,
                                customerId: tripDetail.customerId,
                                officeId: selectedOffice?.officeId,
                                operatorId: selectedOperator?.customerId,
                              );
                              SaveTripDetailsBloc saveBloc = BlocProvider.of<SaveTripDetailsBloc>(context);
                              saveBloc.add(SaveTripDetails(tripManagerPayload: tripPayload));
                            },
                            buttonText: editSave,
                            textColor: AppColors.blackColor,
                          );
                        case SaveTripDetailsStatus.loading:
                          return AppButton(
                            buttonColor: AppColors.veryLightBlue,
                            onTap: () {},
                            buttonText: editSave,
                            textColor: AppColors.blackColor,
                          );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      return Container();
    }
  }

  void fetchLookupData() {
    if (widget.tripDetail != null) {
      LookupBloc lookupBloc = BlocProvider.of<LookupBloc>(context);
      lookupBloc.add(FetchLookupList(customerId: widget.tripDetail!.customerId ?? 0));
    }
  }

  void fetchAircraft(int? customerID) {
    CustomerAircraftBloc aircraftBloc = BlocProvider.of(context);
    aircraftBloc.add(FetchCustomerAircraftData(customerID ?? 0));
  }

  void fetchSubAircraft(int? customerID, int? aircraftId) {
    CustomerSubAircraftBloc aircraftBloc = BlocProvider.of(context);
    aircraftBloc.add(FetchCustomerSubAircraftData(customerID ?? 0, aircraftId ?? 0));
  }

  void fetchOperators(int? aircraftID) {
    OperatorBloc operatorBloc = BlocProvider.of<OperatorBloc>(context);
    operatorBloc.add(FetchOperatorData(aircraftID: aircraftID.toString()));
  }

  void saveLookup(int customerContactID) {
    if (widget.tripDetail != null) {
      SaveLookupBloc lookupBloc = BlocProvider.of<SaveLookupBloc>(context);
      lookupBloc.add(SaveLookupData(tripLookUpPayload: TripLookUpPayload(guid: widget.tripDetail!.guid, customercontactId: customerContactID)));
    }
  }

  void showLookupDialog() {
    final TextEditingController _searchBoxController = TextEditingController();
    List<SelectionHelper<TripPOCContact>> customList = [];
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return Padding(
            padding: const EdgeInsets.all(50),
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: BlocListener<LookupBloc, LookupListState>(
                        listener: (context, state) {},
                        child: BlocBuilder<LookupBloc, LookupListState>(
                          builder: (context, state) {
                            switch (state.status) {
                              case FetchLookupListState.initial:
                              case FetchLookupListState.loading:
                                return _buildCircularProgress();
                              case FetchLookupListState.success:
                                List<TripPOCContact> actualList = state.lookupList;
                                customList = actualList.map((e) => SelectionHelper(e, false)).toList();
                                return StatefulBuilder(
                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: TextField(
                                            controller: _searchBoxController,
                                            onChanged: (value) {
                                              searchLookup(searchText: value);
                                            },
                                            decoration: InputDecoration(
                                                border: const OutlineInputBorder(),
                                                label: Text(search.translate()),
                                                prefixIcon: const Icon(Icons.search),
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      if (_searchBoxController.text.isNotEmpty) {
                                                        _searchBoxController.clear();
                                                        searchLookup();
                                                      }
                                                    },
                                                    icon: const Icon(Icons.clear))),
                                          ),
                                        ),
                                        Expanded(
                                          child: DataTable2(
                                            columns: [
                                              _buildDataColumn(''),
                                              _buildDataColumn('Name'.translate()),
                                              _buildDataColumn('Priority'.translate()),
                                            ],
                                            rows: customList
                                                .map((e) => DataRow(cells: [
                                                      DataCell(
                                                        Checkbox(
                                                          value: e.isSelected,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              var test = customList.map((f) {
                                                                if (e.data != null && f.data != null) {
                                                                  if (f.data!.customercontactId == e.data!.customercontactId) {
                                                                    return e.isSelected;
                                                                  }
                                                                  return false;
                                                                }
                                                                return false;
                                                              }).toList();
                                                              e.isSelected = !e.isSelected;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      DataCell(Text(e.data!.name)),
                                                      DataCell(Text(e.data!.priority.toString())),
                                                    ]))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              case FetchLookupListState.failure:
                                return _buildNoData();
                            }
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.powderBlue,
                              onPrimary: AppColors.deepLilac,
                              minimumSize: const Size(130, 48),
                            ),
                          ),
                        ),
                        BlocListener<SaveLookupBloc, SaveLookupState>(
                          listener: (context, state) {
                            print(state);
                            if (state == SaveLookupState.success) {
                              Navigator.pop(context);
                              fetchTripMangerDetails();
                            }
                          },
                          child: BlocBuilder<SaveLookupBloc, SaveLookupState>(
                            builder: (context, state) {
                              switch (state) {
                                case SaveLookupState.initial:
                                case SaveLookupState.success:
                                case SaveLookupState.failure:
                                  return ElevatedButton(
                                    onPressed: () {
                                      List<SelectionHelper<TripPOCContact>> selectedItem = customList.where((element) => element.isSelected).toList();
                                      if (selectedItem.isNotEmpty) {
                                        if (selectedItem.first.data != null) {
                                          saveLookup(selectedItem.first.data!.customercontactId);
                                        }
                                      }
                                    },
                                    child: const Text('Add'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(130, 48),
                                    ),
                                  );
                                case SaveLookupState.loading:
                                  return ElevatedButton(
                                    onPressed: null,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(130, 48),
                                    ),
                                  );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  DataColumn2 _buildDataColumn(String label) {
    return DataColumn2(
      label: Text(label, style: const TextStyle(color: AppColors.dataTableColumnHeaderColor)),
      size: ColumnSize.L,
    );
  }

  @override
  bool get wantKeepAlive => true;

  void searchLookup({String searchText = ''}) {}
}

class FormDropDownHeader extends StatelessWidget {
  const FormDropDownHeader({
    Key? key,
    required this.opened,
    required this.text,
    this.soon = false,
  }) : super(key: key);

  final bool opened;
  final String text;

  final bool soon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: formItemHeight,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.lightBlueGrey,
        ),
        borderRadius: opened
            ? BorderRadius.only(
                topLeft: Radius.circular(formItemCorner),
                topRight: Radius.circular(formItemCorner),
              )
            : BorderRadius.circular(formItemCorner),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(formItemPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          soon
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -10,
                      right: -36,
                      child: Image.asset(
                        AppImages.comingSoonImage,
                        height: 36,
                      ),
                    ),
                    appText(text),
                  ],
                )
              : appText(text),
          Expanded(child: Container()),
          Container(
            alignment: Alignment.center,
            child: Icon(
              opened ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
              color: AppColors.blueGrey,
              size: dropDownIconSize,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectionHelper<T> {
  T? data;
  bool isSelected;

  SelectionHelper(this.data, this.isSelected);
}

class SubAircraftSelectionHelper<T> {
  T? selected;
  List<T> items;

  SubAircraftSelectionHelper({this.selected, this.items = const []});
}
