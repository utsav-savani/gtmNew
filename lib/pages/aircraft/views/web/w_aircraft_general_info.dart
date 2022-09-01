import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/aircraft/aircraft_page_exported.dart';
import 'package:gtm/pages/aircraft/bloc/aircraft/cubit/aircraft_detail_cubit.dart';
import 'package:gtm/pages/widgets/scafold_error_message.dart';

class WAircraftGeneralInfoPage extends StatefulWidget {
  const WAircraftGeneralInfoPage({Key? key, required this.aircraft})
      : super(key: key);
  final AircraftDetails? aircraft;

  @override
  State<WAircraftGeneralInfoPage> createState() =>
      _WAircraftGeneralInfoPageState();
}

class _WAircraftGeneralInfoPageState extends State<WAircraftGeneralInfoPage> {
  bool editBool = false;
  bool isFirstCall = true;
  AircraftDetails? oldObject;
  late AircraftDetails newObject;
  AircraftDetails? updateObj;

  bool isMtowKgs = true;
  double? mtowValue;
  AircraftType? selectedAircraftType;
  Set<int> selectedCustomersIds = {};
  Set<int> selectedOperatorsIds = {};
  int? selectedCountryId;
  int? baseAirportId;
  String? selectedNoiseCategory;
  int? selectedFireCategory;
  String? selectedReferenceCode;
  TextEditingController controllerMtow = TextEditingController();
  TextEditingController controllerRunwayFt = TextEditingController();
  TextEditingController controllerIcao = TextEditingController();
  TextEditingController controllerIata = TextEditingController();
  TextEditingController controllerSeatCap = TextEditingController();
  TextEditingController controllerRegistrationNumber = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  Map<int, Country> countryMap = {};
  Map<int, Customer> customermap = {};
  Map<int, Customers> operators = {};
  List<AircraftType> aircraftTypes = [];
  List<CountryAirport> baseAiports = [];
  List<String> refrenceCodes = [
    '1A',
    '1B',
    '1C',
    '1D',
    '1E',
    '1F',
    '2A',
    '2B',
    '2C',
    '2D',
    '2E',
    '2F',
    '3A',
    '3B',
    '3C',
    '3D',
    '3E',
    '3F',
    '4A',
    '4B',
    '4C',
    '4D',
    '4E',
    '4F'
  ];
  List<String> noiseCategories = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X'
  ];
  List<int> fireCategories = List.generate(10, (index) => index + 1);

  @override
  void didChangeDependencies() {
    context
        .read<AircraftDetailCubit>()
        .loadBasicDetails(widget.aircraft?.aircraftId);
    if (widget.aircraft == null) {
      editBool = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: AbsorbPointer(
            absorbing: !editBool,
            child: BlocBuilder<AircraftDetailCubit, AircraftDetailState>(
              builder: (context, state) {
                if (state.status == AircraftDetailStatus.loading ||
                    state.status == AircraftDetailStatus.initial) {
                  return loadingWidget();
                } else if (state.status == AircraftDetailStatus.sucess) {
                  if (state.aircraftDetails != null && isFirstCall) {
                    isMtowKgs =
                        state.aircraftDetails!.mtowUnit == "kg" ? true : false;
                    mtowValue = state.aircraftDetails!.mtow;
                    controllerRegistrationNumber.text =
                        state.aircraftDetails!.registrationNumber ?? '';
                    controllerSeatCap.value = TextEditingValue(
                        text: state.aircraftDetails!.seatCap.toString());
                    controllerIcao.text = state.aircraftDetails!.icao;
                    controllerIata.text = state.aircraftDetails!.iata ?? '';
                    controllerRunwayFt.text =
                        state.aircraftDetails!.runwayFt?.toString() ?? '';
                    remarkController.text = state.aircraftDetails!.remark ?? '';
                    selectedAircraftType = state.aircraftDetails!.aircraftType;
                    selectedCustomersIds = {};
                    if (state.aircraftDetails!.customers.isNotEmpty) {
                      selectedCustomersIds = state.aircraftDetails!.customers
                          .map((e) => e.customerId)
                          .toSet();
                    }
                    selectedOperatorsIds = {};
                    if (state.aircraftDetails!.operators != null &&
                        state.aircraftDetails!.operators!.isNotEmpty) {
                      selectedOperatorsIds = state.aircraftDetails!.operators!
                          .map((e) => e.customerId)
                          .toSet();
                    }
                    selectedCountryId = state.aircraftDetails!.regCountryId;
                    if (selectedCountryId != null) {
                      context
                          .read<AircraftDetailCubit>()
                          .loadBaseAirport(selectedCountryId!);
                    }
                    if (state.aircraftDetails!.baseAirport != null) {
                      baseAirportId =
                          state.aircraftDetails!.baseAirport!.airportId;
                    }
                    selectedNoiseCategory =
                        state.aircraftDetails!.noiseCategory;
                    selectedFireCategory = state.aircraftDetails!.category;
                    selectedReferenceCode =
                        state.aircraftDetails!.referenceCode;
                    isFirstCall = false;
                  }
                  aircraftTypes.clear();
                  aircraftTypes.addAll(state.aircraftTypes);
                  countryMap.clear();
                  countryMap = {
                    for (var item in state.countries) item.countryId: item
                  };
                  customermap.clear();
                  customermap = {
                    for (var item in state.customers) item.customerId: item
                  };
                  operators.clear();
                  operators = {
                    for (var item in state.operators) item.customerId: item
                  };
                  baseAiports.clear();
                  baseAiports.addAll(state.baseAiports);
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: _aircraftTypedropdownField(
                          labelText: 'Aircraft Type'),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: _getCustomersMultiSelectDropDown(),
                          ),
                          Expanded(
                            child: _getOperatorsMultiSelectDropDown(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: _textFormField(
                              labelText: "Registration Number",
                              value: controllerRegistrationNumber.text,
                              controller: controllerRegistrationNumber,
                            ),
                          ),
                          Expanded(
                            child: _regCountryDropdownField(
                              labelText: 'Reg. Country',
                              dropdownValue: selectedCountryId,
                              items: countryMap.values.toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: _baseAirportDropdownField(
                              labelText: 'Base',
                              dropdownValue: baseAirportId,
                              items: baseAiports,
                            ),
                          ),
                          Expanded(
                            child: _textFormField(
                                labelText: "Seat Capacity",
                                value: controllerSeatCap.text,
                                controller: controllerSeatCap,
                                isInt: true),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: _textFormField(
                              labelText: "ICAO",
                              isReadOnly: true,
                              value: controllerIcao.text,
                              controller: controllerIcao,
                            ),
                          ),
                          Expanded(
                            child: _textFormField(
                              labelText: "IATA",
                              isReadOnly: true,
                              value: controllerIata.text,
                              controller: controllerIata,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: _noiseCategoryDropdownField(
                              labelText: 'Noise Category',
                              dropdownValue: selectedNoiseCategory,
                              items: noiseCategories,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _textFormField(
                                      labelText: "MTOW - " +
                                          (isMtowKgs ? 'kgs' : 'lbs'),
                                      value: mtowValue != null
                                          ? mtowValue.toString()
                                          : '',
                                      controller: controllerMtow,
                                      isDouble: true),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      appText("Lbs"),
                                      Switch(
                                        value: isMtowKgs,
                                        onChanged: (value) {
                                          mtowValue = kgToLbsConverter(
                                                  mtowValue ?? 0, isMtowKgs)
                                              .toDouble();
                                          setState(() {
                                            isMtowKgs = value;
                                          });
                                        },
                                        activeTrackColor: AppColors.greyColor,
                                        activeColor: AppColors.deepLilac,
                                        inactiveTrackColor: AppColors.greyColor,
                                        inactiveThumbColor: AppColors.deepLilac,
                                      ),
                                      appText("Kgs"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: _textFormField(
                                labelText: "Runway(ft)",
                                value: controllerRunwayFt.text,
                                controller: controllerRunwayFt,
                                isInt: true),
                          ),
                          Expanded(
                            child: _refrenceCodeDropdownField(
                              labelText: 'Refrence Code',
                              dropdownValue: selectedReferenceCode,
                              items: refrenceCodes,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: _fireCategoryDropdownField(
                              labelText: 'Fire Category',
                              dropdownValue: selectedFireCategory,
                              items: fireCategories,
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CancelEditSaveButtons(
            editBool: editBool,
            updateObj: updateObj,
            onCancel: () {
              setState(() {
                isFirstCall = true;
                editBool = false;
              });
            },
            onSave: () {
              if (editBool) {
                if (selectedAircraftType == null ||
                    selectedOperatorsIds.isEmpty ||
                    selectedCustomersIds.isEmpty ||
                    controllerRegistrationNumber.text.isEmpty ||
                    selectedCountryId == null ||
                    controllerIcao.text.isEmpty ||
                    controllerIata.text.isEmpty ||
                    controllerMtow.text.isEmpty ||
                    selectedFireCategory == null ||
                    selectedReferenceCode == null) {
                  scafoldErrorMessage(
                      'Please pass all the mandotry fields', context);
                } else {
                  var aircraft = CreateAircraft(
                      aircraftTypeId: selectedAircraftType!.aircraftTypeId!,
                      regCountryId: selectedCountryId!,
                      registrationNumber: controllerRegistrationNumber.text,
                      seatCap: controllerSeatCap.text.isNotEmpty
                          ? int.parse(controllerSeatCap.text)
                          : 0,
                      category: selectedFireCategory!,
                      noiseCategory: selectedNoiseCategory ?? '',
                      mtow: int.parse(controllerMtow.text),
                      defaultUnit: isMtowKgs ? 'kg' : 'lbs',
                      mtowUnit: isMtowKgs ? 'kg' : 'lbs',
                      iata: controllerIata.text,
                      icao: controllerIcao.text,
                      baseAirportId: baseAirportId,
                      runwayFt: controllerRunwayFt.text.isNotEmpty
                          ? int.parse(controllerRunwayFt.text)
                          : null,
                      referenceCode: selectedReferenceCode!,
                      operatorIds: selectedOperatorsIds.toList(),
                      customerIds: selectedCustomersIds.toList());
                  if (widget.aircraft != null) {
                    aircraft.aircraftId = widget.aircraft!.aircraftId;
                    context
                        .read<AircraftDetailCubit>()
                        .updateAircraft(aircraft);
                  } else {
                    context
                        .read<AircraftDetailCubit>()
                        .createAircraft(aircraft);
                  }
                  setState(() => editBool = !editBool);
                }
                context
                    .read<AircraftBloc>()
                    .add(const FetchDetailedAircraftEvent());
              } else {
                setState(() => editBool = !editBool);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _noiseCategoryDropdownField(
      {required String labelText,
      var dropdownValue,
      required List<dynamic> items}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        value: dropdownValue,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: AppColors.powderBlue,
            ),
          ),
          labelText: labelText,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.toString(),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            selectedNoiseCategory = value as String;
          }
        },
      ),
    );
  }

  Widget _fireCategoryDropdownField(
      {required String labelText,
      var dropdownValue,
      required List<dynamic> items}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        value: dropdownValue,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: AppColors.powderBlue,
            ),
          ),
          labelText: labelText,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.toString(),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            selectedFireCategory = value as int;
          }
        },
      ),
    );
  }

  Widget _refrenceCodeDropdownField(
      {required String labelText,
      var dropdownValue,
      required List<dynamic> items}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        value: dropdownValue,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: AppColors.powderBlue,
            ),
          ),
          labelText: labelText,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.toString(),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            selectedReferenceCode = value as String;
          }
        },
      ),
    );
  }

  _getCustomersMultiSelectDropDown() {
    String? label;
    if (selectedCustomersIds.isNotEmpty) {
      List<String> customers = [];
      for (int i = 0; i < selectedCustomersIds.toList().length; i++) {
        if (customermap.containsKey(selectedCustomersIds.toList()[i])) {
          customers
              .add(customermap[selectedCustomersIds.toList()[i]]?.name ?? '');
        }
      }
      label = customers.join(', ');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildDropdownSelector(
          label: 'Customers',
          hint: label!,
          items: customermap.values
              .toList()
              .map((e) => SelectionHelper(
                  e, selectedCustomersIds.contains(e.customerId)))
              .toList()
              .map((e) => DropdownMenuItem<Customer>(
                    child: StatefulBuilder(
                      builder: (context, innerState) {
                        return CheckboxListTile(
                          title: Text(e.data.name),
                          onChanged: (v) {
                            innerState(() {
                              e.isSelected = !e.isSelected;
                            });
                            if (e.isSelected) {
                              selectedCustomersIds.add(e.data.customerId);
                            } else if (!e.isSelected) {
                              selectedCustomersIds.remove(e.data.customerId);
                            }
                            setState(() {});
                          },
                          value: e.isSelected,
                        );
                      },
                    ),
                    value: e.data,
                  ))
              .toList(),
          onChanged: (val) {}),
    );
  }

  _getOperatorsMultiSelectDropDown() {
    String? label;
    if (selectedOperatorsIds.isNotEmpty) {
      List<String> customers = [];
      for (int i = 0; i < selectedOperatorsIds.toList().length; i++) {
        if (operators.containsKey(selectedOperatorsIds.toList()[i])) {
          customers
              .add(operators[selectedOperatorsIds.toList()[i]]?.name ?? '');
        }
      }
      label = customers.join(', ');
    }
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: CustomWidgets().buildDropdownSelector(
          label: 'Operators',
          hint: label!,
          items: operators.values
              .toList()
              .map((e) => SelectionHelper(
                  e, selectedOperatorsIds.contains(e.customerId)))
              .toList()
              .map((e) => DropdownMenuItem<Customers>(
                    child: StatefulBuilder(
                      builder: (context, innerState) {
                        return CheckboxListTile(
                          title: Text(e.data.name ?? ''),
                          onChanged: (v) {
                            innerState(() {
                              e.isSelected = !e.isSelected;
                            });
                            if (e.isSelected) {
                              selectedOperatorsIds.add(e.data.customerId);
                            } else if (!e.isSelected) {
                              selectedOperatorsIds.remove(e.data.customerId);
                            }
                            setState(() {});
                          },
                          value: e.isSelected,
                        );
                      },
                    ),
                    value: e.data,
                  ))
              .toList(),
          onChanged: (val) {}),
    );
  }

  Widget _aircraftTypedropdownField({required String labelText}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<AircraftType>(
        value: selectedAircraftType,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: AppColors.powderBlue,
            ),
          ),
          labelText: labelText,
        ),
        items: aircraftTypes
            .map(
              (item) => DropdownMenuItem<AircraftType>(
                value: item,
                child: Text(
                  item.fullName,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            selectedAircraftType = value;
            controllerIata.text = value.iata ?? '';
            controllerIcao.text = value.icao ?? '';
            selectedNoiseCategory = value.noiseCategory;
            controllerRunwayFt.text =
                value.runwayFt != null ? value.runwayFt.toString() : '';
            selectedFireCategory = value.category;
            selectedReferenceCode = value.referenceCode;
            mtowValue = value.mtow;
            isMtowKgs = value.mtowUnit == "kg" ? true : false;
            controllerSeatCap.text = value.seatCap != null
                ? value.seatCap.toString()
                : controllerSeatCap.text;
            controllerRunwayFt.text = value.runwayFt != null
                ? value.runwayFt.toString()
                : controllerRunwayFt.text;
            setState(() {});
          }
        },
      ),
    );
  }

  int kgToLbsConverter(double value, bool isValueInKg) {
    if (isValueInKg) {
      return (value * 2.2045855379189).round();
    } else {
      return (value / 2.2045855379189).round();
    }
  }

  Widget _regCountryDropdownField(
      {required String labelText,
      int? dropdownValue,
      required List<Country> items}) {
    Map<int, Country> countryMap = {
      for (var item in items) item.countryId: item
    };
    Country? selectedCountry;
    if (dropdownValue != null) {
      if (countryMap.containsKey(dropdownValue)) {
        selectedCountry = countryMap[dropdownValue];
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<Country>(
        value: selectedCountry,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: AppColors.powderBlue,
            ),
          ),
          labelText: labelText,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.countryName ?? item.name,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          selectedCountry = value;
          if (value != null) {
            selectedCountryId = value.countryId;
            context
                .read<AircraftDetailCubit>()
                .loadBaseAirport(selectedCountryId!);
            baseAirportId = null;
          }
        },
      ),
    );
  }

  Widget _baseAirportDropdownField(
      {required String labelText,
      int? dropdownValue,
      required List<CountryAirport> items}) {
    Map<int, CountryAirport> airportMap = {
      for (var item in items) item.airportId: item
    };
    CountryAirport? selectedBase;
    if (dropdownValue != null) {
      if (airportMap.containsKey(dropdownValue)) {
        selectedBase = airportMap[dropdownValue];
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<CountryAirport>(
        value: selectedBase,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: AppColors.powderBlue,
            ),
          ),
          labelText: labelText,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.name ?? '',
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          selectedBase = value;
          if (value != null) {
            baseAirportId = value.airportId;
          }
        },
      ),
    );
  }

  Widget _textFormField(
      {required String labelText,
      String? value,
      required TextEditingController controller,
      bool? isReadOnly,
      bool? isDouble,
      bool? isInt}) {
    controller.text = value ?? '';
    List<TextInputFormatter> formmatter = [];
    if (isDouble != null && isDouble) {
      formmatter.add(FilteringTextInputFormatter.allow(RegExp('[0-9.]+')));
    }
    if (isInt != null && isInt) {
      formmatter.add(FilteringTextInputFormatter.digitsOnly);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: isReadOnly ?? false,
        inputFormatters: formmatter,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: AppColors.powderBlue,
            ),
          ),
          labelText: labelText,
        ),
        controller: controller,
      ),
    );
  }
}
