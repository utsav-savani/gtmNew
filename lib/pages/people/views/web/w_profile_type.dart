import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:gtm/pages/people/bloc/person_bloc.dart';

class WProfileTypePage extends StatefulWidget {
  const WProfileTypePage({Key? key, required this.people}) : super(key: key);
  final PersonState people;
  @override
  State<WProfileTypePage> createState() => _WProfileTypePageState();
}

class _WProfileTypePageState extends State<WProfileTypePage> {
  bool editBool = false;
  //Roles? profileType;
  PersonState? oldObject;
  late PersonState newObject;
  PersonState? updateObj;

  List<String> rolesContains = [
    'Captain',
    'Crew',
    'Passenger',
    'Vip',
    'Other',
  ];
  Map<String, bool> selectedRoles = {
    "isCaptain": false,
    "isCrew": false,
    "isOther": false,
    "isPassenger": false,
    "isVip": false,
  };

  List<SvgPicture> svgAsset = [
    SvgPicture.asset(AppImages.captainSvg),
    SvgPicture.asset(AppImages.crewSvg),
    SvgPicture.asset(AppImages.passengerSvg),
    SvgPicture.asset(AppImages.vipSvg),
    SvgPicture.asset(AppImages.otherSvg),
  ];

  @override
  void didChangeDependencies() {
    loadInitialData();
    super.didChangeDependencies();
  }

  loadInitialData() {
    if (widget.people.personDetails != null) {
      selectedRoles['isCaptain'] = widget.people.personDetails!.isCaptain;
      selectedRoles['isCrew'] = widget.people.personDetails!.isCrew;
      selectedRoles['isOther'] = widget.people.personDetails!.isOther;
      selectedRoles['isPassenger'] = widget.people.personDetails!.isPassenger;
      selectedRoles['isVip'] = widget.people.personDetails!.isVip;
    }
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        svgAsset.length,
                        (index) => SizedBox(
                          width: spacing88,
                          height: spacing132,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              svgAsset.elementAt(index),
                              Padding(
                                padding: const EdgeInsets.all(spacing6),
                                child: Text(rolesContains.elementAt(index)),
                              ),
                              Checkbox(
                                  shape: const CircleBorder(),
                                  value: selectedRoles[
                                      'is${rolesContains[index]}'],
                                  onChanged: (onChanged) {
                                    if (onChanged != null) {
                                      selectedRoles[
                                              'is${rolesContains[index]}'] =
                                          onChanged;
                                      setState(() {});
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
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
                  Map<String, dynamic> form = {};
                  form.putIfAbsent('formId', () => 4);
                  form.addAll(selectedRoles);
                  context.read<PersonBloc>().add(UpdateCustomerDataEvent(
                      formData: form,
                      customerId: 93,
                      isPassenger: widget.people.isPassenger,
                      guid: widget.people.guid!));
                }
                setState(() => editBool = !editBool);
              },
            ),
          ),
        ],
      ),
    );
  }
}
