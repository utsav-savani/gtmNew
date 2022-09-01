import 'package:accordion/accordion.dart';
import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/home/bloc/home_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_sub_aircraft_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_sub_aircraft_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_sub_aricraft_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/save_lookup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/save_trip_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/save_trip_details_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_event.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:gtm/responsive/screen_type_layout.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripData extends StatefulWidget {
  final TripDetail tripDetail;

  const TripData({Key? key, required this.tripDetail}) : super(key: key);

  @override
  State<TripData> createState() => _TripDataState();
}

class _TripDataState extends State<TripData> with AutomaticKeepAliveClientMixin {
  Operator? selectedOperator;

  Office? selectedOffice;

  Aircraft? selectedPrimaryReg;

  TextEditingController clientReferenceTextField = TextEditingController();

  bool isInEditMode = false;

  @override
  void didChangeDependencies() {
    fetchLookupData();
    super.didChangeDependencies();
  }

  void fetchLookupData() {
    LookupBloc lookupBloc = BlocProvider.of<LookupBloc>(context);
    lookupBloc.add(FetchLookupList(customerId: widget.tripDetail.customerId ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<PrimaryAircraft> childAircraft = widget.tripDetail.childAircraft ?? [];
    List<SubAircraftSelectionHelper<Aircraft>> substituteAircraft = childAircraft
        .map((e) => SubAircraftSelectionHelper<Aircraft>(
            items: childAircraft.map((e) => Aircraft(aircraftId: e.aircraftId, registrationNumber: e.registrationNumber)).toList()))
        .toList();
    PrimaryAircraft? primaryAircraft = widget.tripDetail.primaryAircraft;
    ValueNotifier<Aircraft?> onPrimaryAircraftChange = ValueNotifier(Aircraft(
      aircraftId: (primaryAircraft?.aircraftId) ?? 0,
      registrationNumber: (primaryAircraft?.registrationNumber) ?? '',
    ));

    fetchAircraft(context, widget.tripDetail.customerId);

    return ScreenTypeLayout(
        mobile: _buildMobile(
          context: context,
          childAircraft: childAircraft,
          onPrimaryAircraftChange: onPrimaryAircraftChange,
          substituteAircraft: substituteAircraft,
        ),
        tablet: _buildWeb(
          context: context,
          childAircraft: childAircraft,
          onPrimaryAircraftChange: onPrimaryAircraftChange,
          substituteAircraft: substituteAircraft,
        ),
        desktop: _buildWeb(
          context: context,
          childAircraft: childAircraft,
          onPrimaryAircraftChange: onPrimaryAircraftChange,
          substituteAircraft: substituteAircraft,
        ));
  }

  Widget _buildWeb({
    required BuildContext context,
    required ValueNotifier<Aircraft?> onPrimaryAircraftChange,
    required List<PrimaryAircraft> childAircraft,
    required List<SubAircraftSelectionHelper<Aircraft>> substituteAircraft,
  }) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: _buildContainerDecoration(),
                            child: _buildTripInfoWeb(
                              context: context,
                              onPrimaryAircraftChange: onPrimaryAircraftChange,
                              childAircraft: childAircraft,
                              substituteAircraft: substituteAircraft,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: _buildPointOfContactWeb(context),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: _buildClientReferenceWeb(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildOperationalNotes(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildSaveButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile({
    required BuildContext context,
    required ValueNotifier<Aircraft?> onPrimaryAircraftChange,
    required List<PrimaryAircraft> childAircraft,
    required List<SubAircraftSelectionHelper<Aircraft>> substituteAircraft,
  }) {
    return Scaffold(
      body: SafeArea(
        child: OnTapHideKeyBoard(
          child: Column(
            children: [
              Expanded(
                child: Accordion(
                  children: [
                    AccordionSection(
                      header: _buildAccordionHeading(heading: 'Trip Info'),
                      content: _buildTripInfoMobile(
                        context: context,
                        onPrimaryAircraftChange: onPrimaryAircraftChange,
                        childAircraft: childAircraft,
                        substituteAircraft: substituteAircraft,
                      ),
                      isOpen: true,
                    ),
                    AccordionSection(
                      header: _buildAccordionHeading(heading: 'Point of Contact'),
                      content: _buildPointOfContactMobile(context),
                    ),
                    AccordionSection(
                      header: _buildAccordionHeading(heading: 'Client Reference'),
                      content: _buildClientReferenceMobile(),
                    ),
                    AccordionSection(
                      header: _buildAccordionHeading(heading: 'Operational Notes'),
                      content: _buildOperationalNotes(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSaveButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccordionHeading({required String heading}) {
    return Text(
      heading,
      style: const TextStyle(color: AppColors.whiteColor, fontSize: 14),
    );
  }

  Widget _buildCancelButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.iconGrey),
      ),
      onPressed: () {},
      child: const Text('Cancel'),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: isInEditMode
          ? () {
              TripManagerPayload tripPayload = TripManagerPayload(
                guid: widget.tripDetail.guid,
                aircraftId: selectedPrimaryReg?.aircraftId,
                customerId: widget.tripDetail.customerId,
                officeId: selectedOffice?.officeId,
                operatorId: selectedOperator?.customerId,
                customerReference: clientReferenceTextField.text,
                flightCategoryId: widget.tripDetail.flightCategoryId,
                subAircrafts: widget.tripDetail.childAircraft ?? [],
                tripCostEstimate: widget.tripDetail.tripCostEstimate,
                creatorId: widget.tripDetail.tripOwnerId,
              );
              SaveTripDetailsBloc saveBloc = BlocProvider.of<SaveTripDetailsBloc>(context);
              saveBloc.add(SaveTripDetails(tripManagerPayload: tripPayload));
            }
          : () {
              setState(() {
                isInEditMode = !isInEditMode;
              });
            },
      child: BlocListener<SaveTripDetailsBloc, SaveTripDetailsState>(
        listener: (context, SaveTripDetailsState state) {
          if (state.status == SaveTripDetailsStatus.success) {
            AppHelper().showSnackBar(context, message: 'Trip data saved');
          }
          if (state.status == SaveTripDetailsStatus.failure) {
            AppHelper().showSnackBar(context, message: 'Unable to Save Trip data');
          }
        },
        child: BlocBuilder<SaveTripDetailsBloc, SaveTripDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case SaveTripDetailsStatus.initial:
              case SaveTripDetailsStatus.success:
              case SaveTripDetailsStatus.failure:
                return Text(isInEditMode ? 'Save' : 'Edit');
              case SaveTripDetailsStatus.loading:
                return CustomWidgets().buildCircularProgressSmall();
            }
          },
        ),
      ),
    );
  }

  Widget _buildOperationalNotes() {
    return const TextField(
      decoration: InputDecoration(label: Text('Operational Notes - Coming soon')),
      enabled: false,
    );
  }

  Widget _buildTripInfoWeb({
    required BuildContext context,
    required ValueNotifier<Aircraft?> onPrimaryAircraftChange,
    required List<PrimaryAircraft> childAircraft,
    required List<SubAircraftSelectionHelper<Aircraft>> substituteAircraft,
  }) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCardHeading('Trip Info'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: _buildCustomerTextField(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              children: [
                Expanded(child: _buildOperatorDropdown()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildOfficeDropdown(context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              children: [
                Expanded(child: _buildPrimaryAircraftDropdown(onPrimaryAircraftChange)),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildPrimaryAircraftDetails(onPrimaryAircraftChange),
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: childAircraft.length,
                      itemBuilder: (context, index) {
                        ValueNotifier<Aircraft?> onAircraftChange = ValueNotifier<Aircraft?>(substituteAircraft[index].selected);
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: _buildSecondaryAircraft(
                                  childAircraft[index],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: _buildSecondaryAircraftDetailsV2(childAircraft[index]),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    // Add button hidden
                    /*_buildAddSubRegButton(() {
                      setState(() {
                        substituteAircraft.add(
                          SubAircraftSelectionHelper(
                            items: childAircraft.map((e) => Aircraft(aircraftId: e.aircraftId, registrationNumber: e.registrationNumber)).toList(),
                          ),
                        );
                      });
                    }),*/
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointOfContactWeb(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: _buildContainerDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCardHeading('Point of Contact'),
          ),
          _buildPOCList(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: _buildLookUpButton(context, true),
          ),
        ],
      ),
    );
  }

  Widget _buildPointOfContactMobile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: _buildContainerDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCardHeading('Point of Contact'),
          ),
          _buildPOCList(),
          _buildLookUpButton(context, false),
        ],
      ),
    );
  }

  Widget _buildClientReferenceWeb() {
    clientReferenceTextField.text = widget.tripDetail.customerReference ?? '';
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: _buildContainerDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCardHeading('Client Reference'),
          ),
          TextFormField(
            enabled: isInEditMode,
            controller: clientReferenceTextField,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            //expands: true,
          ),
        ],
      ),
    );
  }

  Widget _buildClientReferenceMobile() {
    clientReferenceTextField.text = widget.tripDetail.customerReference ?? '';
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: _buildContainerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCardHeading('Client Reference'),
          ),
          TextFormField(
            enabled: isInEditMode,
            controller: clientReferenceTextField,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }

  Widget _buildTripInfoMobile({
    required BuildContext context,
    required ValueNotifier<Aircraft?> onPrimaryAircraftChange,
    required List<PrimaryAircraft> childAircraft,
    required List<SubAircraftSelectionHelper<Aircraft>> substituteAircraft,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildCustomerTextField(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildOperatorDropdown(maxWidth: double.infinity),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildOfficeDropdown(context, maxWidth: double.infinity),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildPrimaryAircraftDropdown(onPrimaryAircraftChange, maxWidth: double.infinity),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildPrimaryAircraftDetails(onPrimaryAircraftChange),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: substituteAircraft.length,
                    itemBuilder: (context, index) {
                      ValueNotifier<Aircraft?> onAircraftChange = ValueNotifier<Aircraft?>(substituteAircraft[index].selected);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildSecondaryAircraftDropdown(
                              substituteAircraft,
                              index,
                              onAircraftChange,
                              (index) {
                                setState(() {
                                  substituteAircraft.removeAt(index);
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 8),
                            child: _buildSecondaryAircraftDetails(onAircraftChange),
                          ),
                        ],
                      );
                    },
                  ),
                  // Add button disabled
                  /*_buildAddSubRegButton(() {
                    setState(() {
                      substituteAircraft.add(
                        SubAircraftSelectionHelper(
                          items: childAircraft.map((e) => Aircraft(aircraftId: e.aircraftId, registrationNumber: e.registrationNumber)).toList(),
                        ),
                      );
                    });
                  }),*/
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLookUpButton(BuildContext context, bool isWeb) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.blueGrey),
        minimumSize: MaterialStateProperty.all<Size?>(const Size(spacing120, spacing48)),
      ),
      onPressed: () {
        if (isWeb) {
          showLookupDialogWeb(context);
          return;
        }
        showLookupDialogMobile(context);
      },
      child: const Text(
        lookUp,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildPOCList() {
    List<TripPOCContact> lookupList = widget.tripDetail.pOCContact ?? [];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: lookupList.length,
      itemBuilder: (context, index) {
        return _buildPOCListItem(tripPOCContact: lookupList[index]);
      },
    );
  }

  Widget _buildPOCListItem({required TripPOCContact tripPOCContact}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.person),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(tripPOCContact.name),
                )),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              if (tripPOCContact.mobiles != null) {
                if (tripPOCContact.mobiles!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.phone_iphone),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(tripPOCContact.mobiles!.join(', ')),
                        )),
                      ],
                    ),
                  );
                }
              }
              return Container();
            },
          ),
          Builder(
            builder: (context) {
              if (tripPOCContact.phones != null) {
                if (tripPOCContact.phones!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.phone),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(tripPOCContact.phones!.join(', ')),
                        )),
                      ],
                    ),
                  );
                }
              }
              return Container();
            },
          ),
          Builder(
            builder: (context) {
              if (tripPOCContact.emails != null) {
                if (tripPOCContact.emails!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.email),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(tripPOCContact.emails!.join(', ')),
                        )),
                      ],
                    ),
                  );
                }
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeading(String heading) {
    return Text(
      heading,
      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blueGrey),
    );
  }

  Widget _buildCustomerTextField() {
    TextEditingController tc = TextEditingController();
    tc.text = widget.tripDetail.customerName ?? '';
    return CustomWidgets().buildConstrainedTextFormField(
      TextFormField(
        controller: tc,
        decoration: const InputDecoration(
          enabled: false,
          label: Text('Customer'),
        ),
      ),
      maxWidth: double.infinity,
    );
  }

  Widget _buildOperatorDropdown({double? maxWidth}) {
    return BlocBuilder<OperatorBloc, OperatorState>(
      builder: (context, state) {
        List<Operator> operators = state.operators ?? [];
        if (selectedOperator == null) {
          String tripOperator = widget.tripDetail.operatorName ?? '';
          if (operators.isNotEmpty) {
            List<Operator> temp = operators.where((Operator element) => element.customerName == tripOperator).toList();
            if (temp.isNotEmpty) {
              selectedOperator = temp.first;
            }
          }
        } else if (operators.isNotEmpty) {
          selectedOperator = operators.first;
        }
        return CustomWidgets().buildDropdown<Operator>(
          enabled: isInEditMode,
          items: operators.map((Operator operator) {
            return DropdownMenuItem<Operator>(
              value: operator,
              child: Text(operator.customerName),
            );
          }).toList(),
          onChanged: (Operator? operator) {
            selectedOperator = operator;
          },
          label: 'Operator',
          value: selectedOperator,
          maxWidth: maxWidth,
        );
      },
    );
  }

  Widget _buildOfficeDropdown(BuildContext context, {double? maxWidth}) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return FutureBuilder<List<Office>>(
      future: homeBloc.userRepository.getOffices(),
      builder: (context, snapshot) {
        List<Office> offices = snapshot.data ?? [];
        String tripOffice = widget.tripDetail.officeName ?? '';
        List<Office> temp = offices.where((Office element) => element.officeName == tripOffice).toList();
        if (temp.isNotEmpty) {
          selectedOffice = temp.first;
        }
        if (offices.isNotEmpty) {
          selectedOffice = offices.first;
        }
        return CustomWidgets().buildDropdown<Office>(
          label: 'UAS Team',
          items: offices.map((office) {
            return DropdownMenuItem<Office>(
              value: office,
              child: Text(office.officeName),
            );
          }).toList(),
          onChanged: (office) {
            selectedOffice = office;
          },
          value: selectedOffice,
          enabled: false,
          maxWidth: maxWidth,
        );
      },
    );
  }

  Widget _buildPrimaryAircraftDropdown(ValueNotifier<Aircraft?> onPrimaryAircraftChange, {double? maxWidth}) {
    return BlocBuilder<CustomerAircraftBloc, CustomerAircraftState>(
      builder: (context, state) {
        List<Aircraft> aircraft = state.aircrafts ?? [];

        if (selectedPrimaryReg == null) {
          int tripPrimaryAircraftID = widget.tripDetail.primaryAircraftId ?? 0;
          List<Aircraft> temp = aircraft.where((Aircraft element) => element.aircraftId == tripPrimaryAircraftID).toList();
          if (temp.isNotEmpty) {
            selectedPrimaryReg = aircraft.first;
            if (selectedPrimaryReg != null) {
              onPrimaryAircraftChange.value = selectedPrimaryReg;
              fetchOperators(context, selectedPrimaryReg!.aircraftId);
            }
          }
        }

        return CustomWidgets().buildDropdown<Aircraft>(
          enabled: isInEditMode,
          label: 'Aircraft Registration',
          items: aircraft.map((aircraft) {
            return DropdownMenuItem<Aircraft>(
              value: aircraft,
              child: Text(aircraft.registrationNumber),
            );
          }).toList(),
          onChanged: (primaryReg) {
            selectedPrimaryReg = primaryReg;
            onPrimaryAircraftChange.value = primaryReg;
            if (primaryReg == null) {
              return;
            }
            fetchOperators(context, primaryReg.aircraftId);
            fetchSubAircraft(context, widget.tripDetail.customerId, primaryReg.aircraftId);
          },
          value: selectedPrimaryReg,
          maxWidth: maxWidth,
        );
      },
    );
  }

  Widget _buildPrimaryAircraftDetails(ValueNotifier<Aircraft?> onPrimaryAircraftChange) {
    return ValueListenableBuilder<Aircraft?>(
      valueListenable: onPrimaryAircraftChange,
      builder: (context, Aircraft? value, child) {
        if (value == null) {
          return Container();
        }
        num mtow = value.mtow ?? 0;
        String? mtowUnit = value.mtowUnit;
        return StatefulBuilder(
          builder: (context, setState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label(
                        'Type: ',
                      ),
                      Expanded(
                        child: Text(
                          (value.aircraftType?.icao ?? ''),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    label('MTOW: '),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(mtow.toStringAsFixed(0)),
                        ),
                        DropdownButton<String>(
                          items: ['kg', 'lbs']
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (String? val) {
                            if (val == mtowUnit) {
                              return;
                            }
                            setState(() {
                              if (val == 'kg') {
                                mtow = AppHelper().convertLbsToKg(mtow);
                              } else {
                                mtow = AppHelper().convertKgToLbs(mtow);
                              }
                              mtowUnit = val;
                            });
                          },
                          value: mtowUnit,
                          isDense: true,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSecondaryAircraft(PrimaryAircraft childAircraft) {
    TextEditingController tc = TextEditingController();
    tc.text = childAircraft.registrationNumber;
    return CustomWidgets().buildConstrainedTextFormField(
      TextFormField(
        controller: tc,
        decoration: const InputDecoration(
          enabled: false,
          label: Text('Substitute Registration'),
        ),
      ),
      maxWidth: double.infinity,
    );
  }

  Widget _buildSecondaryAircraftDetailsV2(PrimaryAircraft childAircraft) {
    num mtow = childAircraft.mtow;
    String? mtowUnit = childAircraft.mtowUnit;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  label('MTOW: '),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(mtow.toStringAsFixed(0)),
                      ),
                      DropdownButton<String>(
                        items: ['kg', 'lbs']
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (String? val) {
                          if (val == mtowUnit) {
                            return;
                          }
                          setState(() {
                            if (val == 'kg') {
                              mtow = AppHelper().convertLbsToKg(mtow);
                            } else {
                              mtow = AppHelper().convertKgToLbs(mtow);
                            }
                            mtowUnit = val;
                          });
                        },
                        value: mtowUnit,
                        isDense: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSecondaryAircraftDropdown(List<SubAircraftSelectionHelper<Aircraft>> substituteAircraft, int index,
      ValueNotifier<Aircraft?> onAircraftChange, Function onSubAircraftRemove) {
    return Row(
      children: [
        Stack(
          children: [
            BlocBuilder<CustomerSubAircraftBloc, SubAircraftState>(
              builder: (context, state) {
                List<Aircraft> aircraft = state.aircrafts ?? [];
                if (aircraft.isNotEmpty) {
                  substituteAircraft[index].selected = aircraft.first;
                }
                return CustomWidgets().buildDropdown(
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
                  label: 'Substitute Registration',
                );
              },
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  onSubAircraftRemove(index);
                },
                child: const Icon(
                  Icons.do_not_disturb_on,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        _buildSecondaryAircraftDetails(onAircraftChange),
      ],
    );
  }

  Widget _buildSecondaryAircraftDetails(ValueNotifier<Aircraft?> onAircraftChange) {
    return ValueListenableBuilder<Aircraft?>(
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
    );
  }

  Widget _buildAddSubRegButton(VoidCallback? onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: AppColors.powderBlue,
      ),
      borderRadius: BorderRadius.circular(6),
    );
  }

  void showLookupDialogWeb(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return Padding(
            padding: const EdgeInsets.all(50),
            child: Material(
              child: _buildLoopUp(),
            ),
          );
        });
  }

  void showLookupDialogMobile(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            child: _buildLoopUp(),
          );
        });
  }

  Widget _buildLoopUp() {
    final TextEditingController _searchBoxController = TextEditingController();
    List<SelectionHelper<TripPOCContact>> customList = [];
    return SafeArea(
      child: Column(
        children: [
          _buildHeading(heading: 'Lookup'),
          Expanded(
            child: BlocListener<LookupBloc, LookupListState>(
              listener: (context, state) {},
              child: BlocBuilder<LookupBloc, LookupListState>(
                builder: (context, state) {
                  switch (state.status) {
                    case FetchLookupListState.initial:
                    case FetchLookupListState.loading:
                      return loadingWidget();
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
                                      label: const Text('Search'),
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: label('Name'),
                                    flex: 6,
                                  ),
                                  Expanded(
                                    child: label('Priority'),
                                    flex: 2,
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Checkbox(
                                              value: customList[index].isSelected,
                                              onChanged: (val) {
                                                SelectionHelper<TripPOCContact> e = customList[index];
                                                List<SelectionHelper<TripPOCContact>> test = customList.map((f) {
                                                  if (e.data != null && f.data != null) {
                                                    if (f.data!.customercontactId == e.data!.customercontactId) {
                                                      f.isSelected = !f.isSelected;
                                                      return f;
                                                    }
                                                    f.isSelected = false;
                                                    return f;
                                                  }
                                                  return f;
                                                }).toList();
                                                setState(() {
                                                  customList = test;
                                                });
                                              },
                                            ),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Text(customList[index].data!.name),
                                            flex: 6,
                                          ),
                                          Expanded(
                                            child: Text(customList[index].data!.priority.toString()),
                                            flex: 2,
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                },
                                itemCount: customList.length,
                              )),
                              // Expanded(
                              //   child: DataTable2(
                              //     columns: [
                              //       _buildDataColumn('', columnSize: ColumnSize.S),
                              //       _buildDataColumn('Name'.translate(), columnSize: ColumnSize.L),
                              //       _buildDataColumn('Priority'.translate(), columnSize: ColumnSize.S),
                              //     ],
                              //     rows: customList
                              //         .map((SelectionHelper<TripPOCContact> e) => DataRow(cells: [
                              //               DataCell(Checkbox(
                              //                 value: e.isSelected,
                              //                 onChanged: (val) {
                              //                   List<SelectionHelper<TripPOCContact>> test = customList.map((f) {
                              //                     if (e.data != null && f.data != null) {
                              //                       if (f.data!.customercontactId == e.data!.customercontactId) {
                              //                         f.isSelected = !f.isSelected;
                              //                         return f;
                              //                       }
                              //                       f.isSelected = false;
                              //                       return f;
                              //                     }
                              //                     return f;
                              //                   }).toList();
                              //                   setState(() {
                              //                     customList = test;
                              //                   });
                              //                 },
                              //               )),
                              //               DataCell(Text(e.data!.name)),
                              //               DataCell(Text(e.data!.priority.toString())),
                              //             ]))
                              //         .toList(),
                              //     columnSpacing: 0,
                              //   ),
                              // ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                      fetchTripMangerDetails(context);
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      List<SelectionHelper<TripPOCContact>> selectedItem = customList.where((element) => element.isSelected).toList();
                      if (selectedItem.isNotEmpty) {
                        if (selectedItem.first.data != null) {
                          saveLookup(context, selectedItem.first.data!.customercontactId);
                        }
                      }
                    },
                    child: BlocBuilder<SaveLookupBloc, SaveLookupState>(
                      builder: (context, state) {
                        switch (state) {
                          case SaveLookupState.initial:
                          case SaveLookupState.success:
                          case SaveLookupState.failure:
                            return const Text('Add');
                          case SaveLookupState.loading:
                            return CustomWidgets().buildCircularProgressSmall();
                        }
                      },
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(130, 48),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeading({String heading = ''}) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          heading,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void saveLookup(BuildContext context, int customerContactID) {
    SaveLookupBloc lookupBloc = BlocProvider.of<SaveLookupBloc>(context);
    lookupBloc.add(SaveLookupData(tripLookUpPayload: TripLookUpPayload(guid: widget.tripDetail.guid, customercontactId: customerContactID)));
  }

  Widget _buildNoData() {
    return Center(
      child: Text('noDataFound'.translate()),
    );
  }

  DataColumn2 _buildDataColumn(String label, {ColumnSize columnSize = ColumnSize.L}) {
    return DataColumn2(
      label: Text(label, style: const TextStyle(color: AppColors.dataTableColumnHeaderColor)),
      size: columnSize,
    );
  }

  fetchTripMangerDetails(BuildContext context) {
    TripDetailsBloc tripDetailsBloc = BlocProvider.of<TripDetailsBloc>(context);
    tripDetailsBloc.add(FetchTripDetails(guid: widget.tripDetail.guid!));
  }

  void fetchAircraft(BuildContext context, int? customerID) {
    CustomerAircraftBloc aircraftBloc = BlocProvider.of(context);
    aircraftBloc.add(FetchCustomerAircraftData(customerID ?? 0));
  }

  void fetchSubAircraft(BuildContext context, int? customerID, int? aircraftId) {
    CustomerSubAircraftBloc aircraftBloc = BlocProvider.of(context);
    aircraftBloc.add(FetchCustomerSubAircraftData(customerID ?? 0, aircraftId ?? 0));
  }

  void fetchOperators(BuildContext context, int? aircraftID) {
    OperatorBloc operatorBloc = BlocProvider.of<OperatorBloc>(context);
    operatorBloc.add(FetchOperatorData(aircraftID: aircraftID.toString()));
  }

  void searchLookup({String searchText = ''}) {}

  @override
  bool get wantKeepAlive => true;
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
