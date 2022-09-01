// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:gtm/pages/people/bloc/person_bloc.dart';
import 'package:gtm/pages/widgets/scafold_error_message.dart';
import 'package:people_repository/people_repository.dart';

enum PersonGender { Male, Female, Others }

enum PersonContactType { Mobile, Phone, Email }

class WPersonalInfoPage extends StatefulWidget {
  const WPersonalInfoPage({
    Key? key,
    required this.person,
  }) : super(key: key);
  final PersonState person;
  @override
  State<WPersonalInfoPage> createState() => _WPersonalInfoPageState();
}

class _WPersonalInfoPageState extends State<WPersonalInfoPage> {
  bool editBool = false;
  Person? person;
  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  late PersonState state;
  PersonContactType? contactType;
  String? gender;
  Country? birthCountry;
  Country? addressCountry;
  City? birthCity;
  City? addressCity;
  Map<int, City> birthCities = {};
  Map<int, Country> countryIdMap = {};
  Map<int, City> addressCities = {};
  List<String> mobiles = [];
  List<String> phones = [];
  List<String> emails = [];
  List<TextEditingController> mobileControllers = [];
  List<TextEditingController> emailControllers = [];
  List<TextEditingController> phoneControllers = [];
  Person? oldObject;
  late Person newObject;
  Person? updateObj;

  @override
  void initState() {
    person = widget.person.personDetails;

    state = widget.person;
    if (person != null) {
      gender = person!.gender;
      phones = person!.personHasPhone != null
          ? person!.personHasPhone!.map((e) => e.phone!).toList()
          : [];
      for (int i = 0; i < phones.length; i++) {
        phoneControllers.add(TextEditingController(text: phones[i]));
      }
      mobiles = person!.personHasMobile != null
          ? person!.personHasMobile!.map((e) => e.mobile!).toList()
          : [];
      for (int i = 0; i < mobiles.length; i++) {
        mobileControllers.add(TextEditingController(text: mobiles[i]));
      }
      emails = person!.personHasEmail != null
          ? person!.personHasEmail!.map((e) => e.email!).toList()
          : [];
      for (int i = 0; i < emails.length; i++) {
        emailControllers.add(TextEditingController(text: emails[i]));
      }
      firstNameController =
          TextEditingController(text: person!.firstMiddleName);
      surNameController = TextEditingController(text: person!.surname);
      addressController = TextEditingController(text: person!.address);
      streetController = TextEditingController(text: person!.street);
      houseNoController = TextEditingController(text: person!.houseNumber);
      dobController = TextEditingController(text: person!.dob);
      countryIdMap = widget.person.countries ?? countryIdMap;
      if (countryIdMap.isNotEmpty) {
        birthCountry = countryIdMap[person!.birthCountryId];
        addressCountry = countryIdMap[person!.countryId];
        if (widget.person.birthCities != null && person!.birthCityId != null) {
          birthCity = widget.person.birthCities![person!.birthCityId];
        }
        if (widget.person.addressCities != null && person!.cityId != null) {
          addressCity = widget.person.addressCities![person!.cityId];
        }
        if (state.addressCities != null) {
          addressCities = state.addressCities!;
        }
        if (state.birthCities != null) {
          birthCities = state.birthCities!;
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: spacing20, right: spacing20, bottom: spacing20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: spacing56,
                      child: Row(
                        children: const [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: spacing20),
                              child: Text(
                                'Primary Data',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: spacing20),
                              child: Text(
                                'Permanent Address',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )),
                  AbsorbPointer(
                      absorbing: !editBool,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          getTextFormField(
                                              firstNameController.text,
                                              firstNameController,
                                              true,
                                              false,
                                              labelText: 'Given'),
                                          SizedBox(
                                            height: 80,
                                            width: 250,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  spacing10),
                                              child: DropdownButtonFormField<
                                                  String>(
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                spacing6)),
                                                    borderSide: BorderSide(
                                                      color:
                                                          AppColors.powderBlue,
                                                    ),
                                                  ),
                                                  labelText: ('Gender'),
                                                ),
                                                value: gender,
                                                items: <String>[
                                                  PersonGender.Male.name,
                                                  PersonGender.Female.name,
                                                  PersonGender.Others.name
                                                ].map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    gender = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 80,
                                            width: 250,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  spacing10),
                                              child: DropdownButtonFormField<
                                                  Country>(
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                spacing6)),
                                                    borderSide: BorderSide(
                                                      color:
                                                          AppColors.powderBlue,
                                                    ),
                                                  ),
                                                  labelText:
                                                      ('Country of birth'),
                                                ),
                                                value: birthCountry,
                                                items: state.countries!.values
                                                    .toList()
                                                    .map((Country value) {
                                                  return DropdownMenuItem<
                                                      Country>(
                                                    value: value,
                                                    child: Text(
                                                        value.countryName ??
                                                            value.name),
                                                  );
                                                }).toList(),
                                                onChanged: (value) async {
                                                  if (value != null &&
                                                      birthCountry != value) {
                                                    birthCountry = value;
                                                    if (value.countryName !=
                                                        null) {
                                                      await updateBirthCity(
                                                          value.countryName!);
                                                    }
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 80,
                                            width: 250,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  spacing10),
                                              child:
                                                  DropdownButtonFormField<City>(
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                spacing6)),
                                                    borderSide: BorderSide(
                                                      color:
                                                          AppColors.powderBlue,
                                                    ),
                                                  ),
                                                  labelText: ('City of birth'),
                                                ),
                                                value: birthCity,
                                                items: birthCities.values
                                                    .toList()
                                                    .map((City value) {
                                                  return DropdownMenuItem<City>(
                                                    value: value,
                                                    child: Text(value.city),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    birthCity = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          getTextFormField(
                                              surNameController.text,
                                              surNameController,
                                              true,
                                              false,
                                              labelText: 'Surname'),
                                          getTextFormField(dobController.text,
                                              dobController, true, false,
                                              labelText: 'Dob'),
                                          getTextFormField(
                                              '',
                                              TextEditingController(),
                                              true,
                                              false,
                                              labelText:
                                                  'State/Provinence of birth'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          getTextFormField(
                                              houseNoController.text,
                                              houseNoController,
                                              true,
                                              false,
                                              labelText: 'Apt/House No'),
                                          getTextFormField(
                                              addressController.text,
                                              addressController,
                                              true,
                                              false,
                                              labelText: 'Town/Suburb'),
                                          _getResidenceDropDownMenuField(),
                                          getTextFormField(zipController.text,
                                              zipController, true, false,
                                              labelText: 'Zip/Post')
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          getTextFormField(
                                              streetController.text,
                                              streetController,
                                              true,
                                              false,
                                              labelText: 'Street'),
                                          _getCityDropDownMenuField()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: spacing20),
                    child: Divider(),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Contact Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: !editBool,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('Contact Type: '),
                        width(10),
                        SizedBox(
                          width: 150,
                          height: 60,
                          child: DropdownButtonFormField<PersonContactType>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(spacing6)),
                                borderSide: BorderSide(
                                  color: AppColors.powderBlue,
                                ),
                              ),
                              labelText: 'Contact Type',
                            ),
                            value: contactType,
                            items: <PersonContactType>[
                              PersonContactType.Mobile,
                              PersonContactType.Email,
                              PersonContactType.Phone
                            ].map((PersonContactType value) {
                              return DropdownMenuItem<PersonContactType>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                contactType = value;
                              });
                            },
                          ),
                        ),
                        width(10),
                        Container(
                          height: 60,
                          width: 70,
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              if (contactType == PersonContactType.Mobile) {
                                if (mobileControllers.length < 3) {
                                  mobileControllers
                                      .add(TextEditingController(text: ''));
                                } else {
                                  // TODO show snackbar
                                }
                              }
                              if (contactType == PersonContactType.Phone) {
                                if (phoneControllers.length < 3) {
                                  phoneControllers
                                      .add(TextEditingController(text: ''));
                                } else {
                                  // TODO show snackbar
                                }
                              }
                              if (contactType == PersonContactType.Email) {
                                if (emailControllers.length < 3) {
                                  emailControllers.add(TextEditingController());
                                } else {
                                  // TODO show snackbarS
                                }
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: 70,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text('Add'),
                              ),
                            ),
                          ),
                        ),
                        width(10),
                        ..._generateContactType()
                      ],
                    ),
                  ),
                  height(10),
                ],
              ),
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
              setState(() => editBool = false);
            },
            onSave: () {
              if (editBool) {
                if (firstNameController.text.isEmpty ||
                    surNameController.text.isEmpty ||
                    gender == null ||
                    dobController.text.isEmpty ||
                    birthCountry == null) {
                  scafoldErrorMessage(
                      'Please fill the mandatory fields', context);
                } else {
                  CreatePerson person = CreatePerson(
                    firstMiddleName: firstNameController.text,
                    surname: surNameController.text,
                    zipNa: zipController.text.isEmpty,
                    formId: 1,
                    gender: gender ?? '',
                    dob: dobController.text,
                    birthCountryId: birthCountry!.countryId,
                    birthCityId: birthCity?.cityId,
                    contacts: AddContact(
                        email: emailControllers.map((e) => e.text).toList()),
                    countryId: addressCountry?.countryId,
                    cityId: addressCity?.cityId,
                    street: streetController.text,
                    houseNumber: houseNoController.text,
                    address: addressController.text,
                  );

                  context.read<PersonBloc>().add(UpdateCustomerDataEvent(
                      formData: person,
                      customerId: state.customers[0].customerId,
                      isPassenger: state.isPassenger,
                      guid: state.guid!));
                }
              }
              setState(() => editBool = !editBool);
            },
          ),
        ),
      ],
    );
  }

  Widget _getResidenceDropDownMenuField() {
    return SizedBox(
      width: 250,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<Country>(
            isExpanded: true,
            value: addressCountry,
            decoration: const InputDecoration(
                labelText: 'Residence',
                contentPadding: EdgeInsets.all(spacing4),
                hintText: 'Residence'),
            items: state.countries!.values
                .toList()
                .map((e) => DropdownMenuItem<Country>(
                    value: e,
                    child: Text(
                      e.countryName ?? e.name,
                    )))
                .toList(),
            onChanged: (onChanged) async {
              if (onChanged != null && onChanged != addressCountry) {
                addressCountry = onChanged;
                if (addressCountry!.countryName != null) {
                  await updateAddressCity(addressCountry!.countryName!);
                }

                setState(() {});
              }
            }),
      ),
    );
  }

  Widget _getCityDropDownMenuField() {
    return SizedBox(
      width: 250,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<City>(
            value: addressCity,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(spacing4),
                hintText: 'City',
                labelText: 'City'),
            items: addressCities.values
                .toList()
                .map((e) => DropdownMenuItem<City>(
                    value: e,
                    child: Text(
                      e.city,
                    )))
                .toList(),
            onChanged: (onChanged) {
              if (onChanged != null) {
                addressCity = onChanged;
                setState(() {});
              }
            }),
      ),
    );
  }

  updateAddressCity(String country) async {
    List<City> temp = await PeopleRepository().fetchCities(country);
    addressCities = {for (var item in temp) item.cityId: item};
    addressCity = null;
  }

  updateBirthCity(String country) async {
    List<City> temp = await PeopleRepository().fetchCities(country);
    birthCities = {for (var item in temp) item.cityId: item};
    birthCity = null;
  }

  getTextFormField(
      String? value, TextEditingController controller, bool name, bool billing,
      {String? labelText}) {
    return SizedBox(
      height: 80,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(spacing6)),
              borderSide: BorderSide(
                color: AppColors.powderBlue,
              ),
            ),
            labelText: (labelText ?? ''),
          ),
          controller: controller,
        ),
      ),
    );
  }

  _generateContactType() {
    List<Widget> contactType = [];
    for (int i = 0; i < emailControllers.length; i++) {
      contactType.add(Text('Email${i + 1}: '));
      contactType.add(width(10));
      contactType.add(getTextFormField(
          emailControllers[i].text, emailControllers[i], false, false));
      contactType.add(SizedBox(
        height: 60,
        child: IconButton(
            onPressed: () {
              emailControllers.removeAt(i);
              setState(() {});
            },
            icon: Icon(Icons.delete)),
      ));
    }
    for (int i = 0; i < phoneControllers.length; i++) {
      contactType.add(Text('Phone${i + 1}: '));
      contactType.add(width(10));
      contactType.add(getTextFormField(
          phoneControllers[i].text, phoneControllers[i], false, false));
      contactType.add(SizedBox(
        height: 60,
        child: IconButton(
            onPressed: () {
              phoneControllers.removeAt(i);
              setState(() {});
            },
            icon: Icon(Icons.delete)),
      ));
    }
    for (int i = 0; i < mobileControllers.length; i++) {
      contactType.add(Text('Mobile${i + 1}: '));
      contactType.add(width(10));
      contactType.add(getTextFormField(
          mobileControllers[i].text, mobileControllers[i], false, false));
      contactType.add(SizedBox(
        height: 60,
        child: IconButton(
            onPressed: () {
              mobileControllers.removeAt(i);
              setState(() {});
            },
            icon: Icon(Icons.delete)),
      ));
    }
    return contactType;
  }
}
