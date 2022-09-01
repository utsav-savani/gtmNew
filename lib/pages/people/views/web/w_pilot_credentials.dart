// ignore_for_file: prefer_const_constructors

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:gtm/pages/people/bloc/person_bloc.dart';
import 'package:people_repository/people_repository.dart';

class WPilotCredentialsPage extends StatefulWidget {
  const WPilotCredentialsPage({Key? key, required this.person})
      : super(key: key);
  final PersonState person;
  @override
  State<WPilotCredentialsPage> createState() => _WPilotCredentialsPageState();
}

class _WPilotCredentialsPageState extends State<WPilotCredentialsPage> {
  bool editBool = false;

  TextEditingController licenceController = TextEditingController();
  TextEditingController issueDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  Country? issueCountry;
  PersonState? oldObject;
  late PersonState newObject;
  PersonState? updateObj;

  bool ufn = false;
  @override
  void didChangeDependencies() {
    if (widget.person.personDetails != null) {
      ufn = widget.person.personDetails!.ufn;
      licenceController.value = TextEditingValue(
          text: widget.person.personDetails!.licenseNumber ?? '');
      issueDateController.value =
          TextEditingValue(text: widget.person.personDetails!.issueDate ?? '');
      expiryDateController.value = TextEditingValue(
          text: widget.person.personDetails!.expirationDate ?? '');
      if (widget.person.countries != null &&
          widget.person.personDetails!.licenseIssuedCountryId != null) {
        issueCountry = widget.person
            .countries![widget.person.personDetails!.licenseIssuedCountryId]!;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spacing20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: spacing20,
                  bottom: spacing52,
                ),
                child: Text(
                  'Pilot Credentials',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              AbsorbPointer(
                absorbing: !editBool,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: getTextFormField(licenceController.text,
                              licenceController, true, false,
                              labelText: 'Licence No:'),
                        ),
                        Flexible(
                          child: DropdownButtonFormField<Country>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(spacing6)),
                                borderSide: BorderSide(
                                  color: AppColors.powderBlue,
                                ),
                              ),
                              labelText: 'Country of issue',
                            ),
                            value: issueCountry,
                            items: widget.person.countries!.values
                                .toList()
                                .map((Country value) {
                              return DropdownMenuItem<Country>(
                                value: value,
                                child: Text(value.countryName ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                issueCountry = value!;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: getTextFormField(issueDateController.text,
                              issueDateController, true, false,
                              labelText: 'Issue Date'),
                        ),
                        Flexible(
                          child: getTextFormField(expiryDateController.text,
                              expiryDateController, true, false,
                              labelText: 'Expiry Date'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(spacing4),
                          child: Checkbox(
                              value: ufn,
                              onChanged: (onChanged) {
                                setState(() {
                                  ufn = !ufn;
                                });
                              }),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(spacing4),
                          child: Text('UFN'),
                        ),
                        const Icon(
                          Icons.info_rounded,
                          color: AppColors.lightBlueGrey,
                          size: spacing12,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
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
                  context.read<PersonBloc>().add(UpdateCustomerDataEvent(
                      formData: PilotCredentials(
                          licenseIssuedCountryId: issueCountry!.countryId,
                          formId: 2,
                          ufn: ufn,
                          licenseNumber: licenceController.text,
                          issueDate: issueDateController.text,
                          expirationDate: expiryDateController.text),
                      customerId: 93,
                      isPassenger: widget.person.isPassenger,
                      guid: widget.person.guid!));
                }
                setState(() => editBool = !editBool);
              },
            ),
          ),
        ],
      ),
    );
  }

  getTextFormField(
      String? value, TextEditingController controller, bool name, bool billing,
      {String? labelText}) {
    controller.text = value!;
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: TextFormField(
        onChanged: (value) {},
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
    );
  }
}
