import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/bloc/general_info/country_general_info_bloc.dart';
import 'package:gtm/pages/countries/cubit/country_cubit/country_cubit_cubit.dart';

class WCompanyProfileGeneralInfoPage extends StatefulWidget {
  final CompanyProfile companyProfile;
  const WCompanyProfileGeneralInfoPage({
    Key? key,
    required this.companyProfile,
  }) : super(key: key);

  @override
  State<WCompanyProfileGeneralInfoPage> createState() =>
      _WCompanyProfileGeneralInfoPageState();
}

class _WCompanyProfileGeneralInfoPageState
    extends State<WCompanyProfileGeneralInfoPage> {
  List<String> statusList = ['Active', 'InActive', 'Potential/Lead'];
  List<String> notAvailableList = ['Not Available'];
  List<String> regionList = [
    'Africa',
    'Asia',
    'Australia and Oceania',
    'Eastern Europe',
    'Europe',
    'Caribbean',
    'Central America',
    'Central Asia',
    'Middle East',
    'North America',
    'South America',
    'South Asia',
    'Far East'
  ];

  bool editBool = false;
  List<Country>? _countries;
  TextEditingController websiteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  List<Teams> selectedTeams = [];
  List<String> teams = [];
  Country? selectedCountry;
  CompanyProfile? oldObject;
  late CompanyProfile newObject;
  CompanyProfile? updateObj;
  @override
  void didChangeDependencies() {
    context.read<CountryCubit>().getCountries();
    oldObject = widget.companyProfile;
    newObject = widget.companyProfile;
    updateObj = newObject;
    websiteController.text = widget.companyProfile.website ?? '';
    addressController.text = widget.companyProfile.billingAddress ?? '';
    notesController.text = widget.companyProfile.notes ?? '';
    if (widget.companyProfile.teams != null &&
        widget.companyProfile.teams!.isNotEmpty) {
      teams = widget.companyProfile.teams!.map((e) => e.officeName).toList();
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    newObject = widget.companyProfile;
  }

  String setValue(value) {
    return value;
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text(confirm),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: const Text(confirm),
      onPressed: () {},
    );
    AlertDialog alert = AlertDialog(
      title: const Text(confirmUpdate),
      content: const Text(pleaseConfirm),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CountryCubit, CountryCubitState>(
          builder: (context, state) {
            if (state.status == FetchCountryStatus.success) {
              _countries = state.countries;
              if (_countries != null && _countries!.isNotEmpty) {
                Map<int, Country> countryMap = {
                  for (var item in _countries!) item.countryId!: item
                };
                selectedCountry = countryMap[widget.companyProfile.countryId];
              }
            }
            return _countries == null
                ? loadingWidget()
                : state.status == FetchGeneralInfoStatus.loading
                    ? loadingWidget()
                    : Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AbsorbPointer(
                                  absorbing: !editBool,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  spacing8),
                                              child: Text(
                                                companyName +
                                                    widget.companyProfile
                                                        .customerName!,
                                                style: const TextStyle(
                                                    color: AppColors.blueGrey,
                                                    fontSize: spacing14),
                                              ),
                                            ),
                                            getSelectableDropDownMenuField(
                                              labelText: status,
                                              stringItems: statusList,
                                              status: true,
                                              selectedValue:
                                                  widget.companyProfile.status,
                                            ),
                                            getTextFormField(
                                                teams.join(', '),
                                                TextEditingController(),
                                                false,
                                                false,
                                                'Teams'),
                                            getSelectableCountryDropDownMenuField(
                                              stringItems: _countries,
                                              labelText: country,
                                            ),
                                            getTextFormField(
                                                addressController.text,
                                                addressController,
                                                false,
                                                true,
                                                address),
                                            getTextFormFieldForHtml(
                                                notesController.text,
                                                notesController,
                                                false,
                                                false,
                                                notes),
                                          ],
                                        ),
                                      ),
                                      const VerticalDivider(),
                                      Expanded(
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(spacing8),
                                              child: Text(
                                                parentCompany,
                                                style: TextStyle(
                                                    color: AppColors.blueGrey,
                                                    fontSize: spacing14),
                                              ),
                                            ),
                                            getSelectableBDMDropDownMenuField(
                                              labelText: bdm,
                                            ),
                                            getSelectableCustomerTypeDropDownMenuField(
                                              labelText: type,
                                              stringItems: widget
                                                  .companyProfile.customerType!,
                                            ),
                                            getSelectableDropDownMenuField(
                                              labelText: region,
                                              stringItems: regionList,
                                              selectedValue: widget
                                                  .companyProfile.regionName,
                                            ),
                                            getTextFormField(
                                                websiteController.text,
                                                websiteController,
                                                true,
                                                false,
                                                website),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //
                        ],
                      );
          },
        ),
      ),
    );
  }

  getTextFormFieldForHtml(String value, TextEditingController controller,
      bool isWebSiteText, bool billing, String labelText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    controller.text = value.replaceAll(exp, ' ');
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: TextFormField(
        onChanged: (value) {
          if (isWebSiteText) {
            updateObj = newObject.copyWith(website: value);
          } else if (billing) {
            updateObj = newObject.copyWith(billingAddress: value);
          } else {
            updateObj = newObject.copyWith(notes: value);
          }
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(spacing6)),
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

  getTextFormField(String? value, TextEditingController controller,
      bool isWebSiteText, bool billing, String labelText) {
    controller.text = value!;
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: TextFormField(
        onChanged: (value) {},
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(spacing6)),
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

  getSelectableDropDownMenuField({
    List<String>? stringItems,
    String? labelText,
    bool? status,
    String? selectedValue,
  }) {
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: DropdownButtonFormField(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        items: stringItems!
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(),
        onChanged: (String? onChanged) {
          if (status!) {
            updateObj = newObject.copyWith(status: onChanged);
          } else {
            updateObj = newObject.copyWith(regionName: onChanged);
          }
        },
      ),
    );
  }

  getSelectableTeamsDropDownMenuField({
    required List<Teams> stringItems,
    String? labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: DropdownButtonFormField(
        decoration: InputDecoration(labelText: labelText),
        items: stringItems.map((team) {
          return DropdownMenuItem<Teams>(
            value: team,
            child: SizedBox(
              width: 400,
              child: CheckboxListTile(
                  title: Text(team.officeName),
                  value: selectedTeams
                          .where((element) =>
                              element.officeName == team.officeName)
                          .isEmpty
                      ? false
                      : true,
                  onChanged: (onChanged) {
                    setState(() {
                      if (onChanged!) {
                        selectedTeams.add(team);
                      } else {
                        selectedTeams.remove(team);
                      }
                    });
                  }),
            ),
          );
        }).toList(),
        onChanged: (team) {
          updateObj!.copyWith(teams: selectedTeams);
        },
      ),
    );
  }

  getSelectableCountryDropDownMenuField({
    required List<Country>? stringItems,
    String? labelText,
  }) {
    Country? currentItem = widget.companyProfile.country;
    List<DropdownMenuItem<Country>> dropDownItems = [];
    for (Country country in stringItems!) {
      dropDownItems.add(
        DropdownMenuItem<Country>(
          value: country,
          child: Text(
            country.name!,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        value: selectedCountry,
        items: dropDownItems,
        onChanged: (Country? country) {
          updateObj = newObject.copyWith(countryId: country!.countryId);
        },
      ),
    );
  }

  getSelectableBDMDropDownMenuField({
    String? labelText,
  }) {
    debugPrint(widget.companyProfile.toString());
    List<String> bdms = [];
    if (widget.companyProfile.bdm != null &&
        widget.companyProfile.bdm!.isNotEmpty) {
      for (int i = 0; i < widget.companyProfile.bdm!.length; i++) {
        if (widget.companyProfile.bdm![i].name != null) {
          bdms.add(widget.companyProfile.bdm![i].name!);
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: DropdownButtonFormField(
        value: bdms.join(', '),
        decoration: InputDecoration(
          labelText: labelText,
        ),
        items: bdms
            .map(
              (bdm) => DropdownMenuItem<String>(
                value: bdm,
                child: Text(
                  bdm,
                ),
              ),
            )
            .toList(),
        onChanged: (bdm) {},
      ),
    );
  }

  getSelectableCustomerTypeDropDownMenuField({
    List<CustomerType>? stringItems,
    String? labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: TextFormField(
        decoration: const InputDecoration(labelText: 'Customer Types'),
        controller: TextEditingController(
            text: widget.companyProfile.customerType != null
                ? widget.companyProfile.customerType!
                    .map((e) => e.customerType)
                    .toList()
                    .join(', ')
                : ''),
      ),
    );
  }

  getListTile(String key, String value) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(spacing10),
            child: Text(
              key + ':',
              style: const TextStyle(color: AppColors.charcoalGrey),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(spacing10),
            child: Text(
              value,
              style: const TextStyle(color: AppColors.brownGrey),
            ),
          ),
        ),
      ],
    );
  }
}
