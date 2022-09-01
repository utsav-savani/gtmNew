// ignore_for_file: prefer_const_constructors

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/people/bloc/person_bloc.dart';
import 'package:people_repository/people_repository.dart';

class WPassportVisaTabPages extends StatefulWidget {
  const WPassportVisaTabPages({Key? key, required this.person})
      : super(key: key);
  final PersonState person;
  @override
  State<WPassportVisaTabPages> createState() => _WPassportVisaTabPagesState();
}

class _WPassportVisaTabPagesState extends State<WPassportVisaTabPages>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<String> stringTabs = [passport, visa];

  TextEditingController pnumberController = TextEditingController();
  TextEditingController pissueDateController = TextEditingController();
  TextEditingController pexpiryDateControlleer = TextEditingController();
  Country? pselectedCountry;
  bool pisActive = false;
  String? selectedPassportType;
  TextEditingController vnumberController = TextEditingController();
  TextEditingController vissueDateController = TextEditingController();
  TextEditingController vexpiryDateControlleer = TextEditingController();
  Country? vselectedCountry;
  bool visActive = false;

  List<String> passportType = [
    'Ordinary Passport',
    'Official Passport',
    'US-Passport Card',
    'Diplomatic Passport',
    'Refugee Travel Document',
    'Emergency Passport',
    'Travel Card'
  ];

  checkActive() {
    if (pissueDateController.text.isNotEmpty &&
        pexpiryDateControlleer.text.isNotEmpty) {
      DateTime issueTime =
          DateFormat('dd-MM-yyyy').parse(pissueDateController.text);
      DateTime expiryTime =
          DateFormat('dd-MM-yyyy').parse(pexpiryDateControlleer.text);
      DateTime now = DateTime.now();
      if (now.compareTo(expiryTime) == -1 && now.compareTo(issueTime) == 1) {
        setState(() {
          pisActive = true;
        });
      }
    }
  }

  visaCheckActive() {
    if (vissueDateController.text.isNotEmpty &&
        vexpiryDateControlleer.text.isNotEmpty) {
      DateTime issueTime =
          DateFormat('dd-MM-yyyy').parse(vissueDateController.text);
      DateTime expiryTime =
          DateFormat('dd-MM-yyyy').parse(vexpiryDateControlleer.text);
      DateTime now = DateTime.now();
      if (now.compareTo(expiryTime) == -1 && now.compareTo(issueTime) == 1) {
        setState(() {
          visActive = true;
        });
      }
    }
  }

  // FilePickerResult? result;
  // List<PlatformFile>? uploadFileList;
  Passport? _passport;
  List<Widget>? selectedFilesPreview;
  List<int>? selectPreference = [1, 2, 3, 4, 5];
  List<PlatformFile> passportFiles = [];
  List<PlatformFile> visaFiles = [];
  String? selectedPreference;

  @override
  void didChangeDependencies() {
    _tabController = TabController(length: stringTabs.length, vsync: this);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: spacing44, bottom: spacing32, left: spacing20),
            child: TabBar(
              controller: _tabController,
              labelPadding: const EdgeInsets.all(spacing12),
              isScrollable: true,
              labelColor: AppColors.deepLilac,
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              unselectedLabelColor: AppColors.powderBlue,
              indicatorColor: AppColors.deepLilac,
              tabs: stringTabs.map((e) => Text(e)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              passportTabView(),
              visaTabView(),
            ]),
          )
        ],
      ),
    );
  }

  Widget passportTabView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _getPrefrenceDropDownMenuField(),
            _getNationalityDropDownMenuField(),
            //  const PassportNumberTextFormField(),
            getTextFormField(
                pnumberController.text, pnumberController, false, false,
                labelText: 'Number'),
          ],
        ),
        Row(
          children: [
            getTextFormField(
                pissueDateController.text, pissueDateController, false, false,
                labelText: 'Issue Date', isCheckActive: true),
            getTextFormField(pexpiryDateControlleer.text,
                pexpiryDateControlleer, false, false,
                labelText: 'Expiry Date', isCheckActive: true),
            _getOfficeTypeDropDownMenuField(),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spacing6),
                      child: Text(pisActive ? 'Active' : 'In Active'),
                    ),
                    Image.asset('assets/images/switch_button.png')
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () async {
                List<PlatformFile> files = (await FilePicker.platform.pickFiles(
                        type: FileType.any,
                        allowMultiple: false,
                        allowedExtensions: null))!
                    .files;
                passportFiles.addAll(files);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(spacing12),
                child: SvgPicture.asset(AppImages.dragDrop),
              ),
            ),
            width(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  passportFiles.length,
                  (index) => Container(
                      alignment: Alignment.centerLeft,
                      height: 30,
                      width: 100,
                      color: AppColors.lightBrown,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(passportFiles[index].name),
                      ))),
            )
          ],
        )
      ],
    );
  }

  Widget visaTabView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _getNationalityDropDownMenuField(),
            getTextFormField(
                vnumberController.text, vnumberController, false, false,
                labelText: 'Number'),
            getTextFormField(
                vissueDateController.text, vissueDateController, false, false,
                labelText: 'Issue Date', isCheckActive: true, isVisa: true),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextFormField(vexpiryDateControlleer.text,
                vexpiryDateControlleer, false, false,
                labelText: 'Expiry Date', isCheckActive: true, isVisa: true),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spacing6),
                      child: Text(visActive ? 'Active' : 'In Active'),
                    ),
                    Image.asset('assets/images/switch_button.png')
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () async {
                List<PlatformFile> files = (await FilePicker.platform.pickFiles(
                        type: FileType.any,
                        allowMultiple: false,
                        allowedExtensions: null))!
                    .files;
                visaFiles.addAll(files);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(spacing12),
                child: SvgPicture.asset(AppImages.dragDrop),
              ),
            ),
            width(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  visaFiles.length,
                  (index) => Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      width: 100,
                      color: AppColors.lightBrown,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(visaFiles[index].name),
                      ))),
            )
          ],
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(exit),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.redColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spacing6),
                )),
                minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(spacing128, spacing48)),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  getTextFormField(
      String? value, TextEditingController controller, bool name, bool billing,
      {String? labelText = '', bool? isCheckActive, bool? isVisa}) {
    controller.text = value!;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: TextFormField(
          onChanged: (value) {
            if (isCheckActive != null && isCheckActive) {
              if (isVisa != null && isVisa) {
                visaCheckActive();
              } else {
                checkActive();
              }
            }
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(spacing6)),
              borderSide: BorderSide(
                color: AppColors.powderBlue,
              ),
            ),
            labelText: labelText ?? '',
          ),
          controller: controller,
        ),
      ),
    );
  }

  Widget _getPrefrenceDropDownMenuField() {
    Set<String> prefrences = {};
    prefrences.addAll(List.generate(10, (index) => "${index + 1}"));
    if (widget.person.personDetails != null &&
        widget.person.personDetails!.personHasPassportDocument != null &&
        widget.person.personDetails!.personHasPassportDocument!.isNotEmpty) {
      for (int i = 0;
          i < widget.person.personDetails!.personHasPassportDocument!.length;
          i++) {
        prefrences.remove(widget
            .person.personDetails!.personHasPassportDocument![i].preference);
      }
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField(
            value: selectedPreference,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(spacing4),
                hintText: 'Select Preference'),
            items: prefrences
                .toList()
                .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e.toString(),
                    )))
                .toList(),
            onChanged: (String? onChanged) {
              setState(() {
                selectedPreference = onChanged;
              });
              debugPrint(selectedPreference.toString());
            }),
      ),
    );
  }

  Widget _getNationalityDropDownMenuField() {
    List<Country> countries = [];
    if (widget.person.countries != null) {
      countries.addAll(widget.person.countries!.values.toList());
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<Country>(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(spacing4),
                hintText: 'Select Nationality'),
            items: countries
                .map((e) => DropdownMenuItem<Country>(
                    value: e,
                    child: Text(
                      e.countryName ?? '',
                    )))
                .toList(),
            onChanged: (onChanged) {
              pselectedCountry = onChanged ?? pselectedCountry;
              setState(() {});
            }),
      ),
    );
  }

  Widget _getOfficeTypeDropDownMenuField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(spacing4),
                hintText: 'Select Passport Type'),
            items: passportType
                .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                    )))
                .toList(),
            onChanged: (onChanged) {
              selectedPassportType = onChanged ?? selectedPassportType;
              setState(() {});
            }),
      ),
    );
  }
}
