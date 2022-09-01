import 'dart:typed_data';

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:gtm/pages/people/bloc/person_bloc.dart';
import 'package:gtm/pages/widgets/scafold_error_message.dart';
import 'package:people_repository/people_repository.dart';
import 'package:universal_html/html.dart';

class WPassportVisaPage extends StatefulWidget {
  const WPassportVisaPage({Key? key, required this.person}) : super(key: key);
  final PersonState person;
  @override
  State<WPassportVisaPage> createState() => _WPassportVisaPageState();
}

class _WPassportVisaPageState extends State<WPassportVisaPage>
    with TickerProviderStateMixin {
  bool editBool = false;
  bool isEditScreenOpened = false;
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
  int? passportId;
  int? visaId;
  Country? vselectedCountry;
  bool visActive = false;
  bool isOneTab = false;
  String? selectedTab;
  Passport? _passportData;
  Visa? _visaData;
  List<Widget>? selectedFilesPreview;
  List<Object> passportFiles = [];
  List<PlatformFile> visaFiles = [];
  String? selectedPreference;
  PersonState? oldObject;
  late PersonState newObject;
  PersonState? updateObj;
  Uint8List? uploadedImage;
  List<String> passportType = [
    'Ordinary Passport',
    'Official Passport',
    'US-Passport Card',
    'Diplomatic Passport',
    'Refugee Travel Document',
    'Emergency Passport',
    'Travel Card'
  ];

  resetFields() {
    pnumberController = TextEditingController();
    pissueDateController = TextEditingController();
    pexpiryDateControlleer = TextEditingController();
    pselectedCountry = null;
    passportId = null;
    visaId = null;
    pisActive = false;
    selectedPassportType = null;
    vnumberController = TextEditingController();
    vissueDateController = TextEditingController();
    vexpiryDateControlleer = TextEditingController();
    vselectedCountry = null;
    visActive = false;
    selectedPreference = null;
    _tabController = TabController(length: stringTabs.length, vsync: this);
  }

  checkActive() {
    if (pissueDateController.text.isNotEmpty &&
        pexpiryDateControlleer.text.isNotEmpty) {
      DateTime issueTime =
          DateFormat('yyyy-MM-dd').parse(pissueDateController.text);
      DateTime expiryTime =
          DateFormat('yyyy-MM-dd').parse(pexpiryDateControlleer.text);
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
          DateFormat('yyyy-MM-dd').parse(vissueDateController.text);
      DateTime expiryTime =
          DateFormat('yyyy-MM-dd').parse(vexpiryDateControlleer.text);
      DateTime now = DateTime.now();
      if (now.compareTo(expiryTime) == -1 && now.compareTo(issueTime) == 1) {
        setState(() {
          visActive = true;
        });
      }
    }
  }

  _firstWidget() => SizedBox(
        height: spacing196,
        width: spacing212,
        child: Card(
          color: AppColors.paleGrey,
          child: Center(
            child: Column(children: [
              const Expanded(child: Icon(Icons.add)),
              Expanded(child: appText('Add Passport/Visa', fontSize: 16)),
            ]),
          ),
        ),
      );

  Widget _buildPassportOrVisaWidgetList(
      {required Person? person, required bool isOneTab}) {
    return Container(
      alignment: Alignment.center,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        InkWell(
          onTap: () {
            resetFields();
            setState(() {
              isEditScreenOpened = true;
              isOneTab = false;
            });
          },
          child: _firstWidget(),
        ),
        (person != null &&
                person.personHasPassportDocument != null &&
                person.personHasPassportDocument!.isNotEmpty)
            ? Row(
                children: _buildPassportWidget(
                        passportList: person.personHasPassportDocument)
                    .toList())
            : const SizedBox(),
        (person != null &&
                person.personHasVisaDocument != null &&
                person.personHasVisaDocument!.isNotEmpty)
            ? Row(
                children:
                    _buildVisaWidget(visaList: person.personHasVisaDocument!))
            : const SizedBox()
      ]),
    );
  }

  List<Widget> _buildPassportWidget({List<Passport>? passportList}) {
    return List.generate(
        passportList!.length,
        (index) => SizedBox(
              height: spacing220,
              width: spacing212,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 12),
                                    child:
                                        SvgPicture.asset(AppImages.passportSvg),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isEditScreenOpened = true;
                                      passportId = passportList[index]
                                          .personPassportDocumentId;
                                      pnumberController.text =
                                          passportList[index].number ?? '';
                                      selectedPreference =
                                          passportList[index].preference;
                                      if (passportList[index].countryId !=
                                          null) {
                                        pselectedCountry =
                                            widget.person.countries![
                                                passportList[index].countryId];
                                        pissueDateController.text =
                                            passportList[index].issueDate ?? '';
                                        pexpiryDateControlleer.text =
                                            passportList[index].expireDate ??
                                                '';
                                        selectedPassportType =
                                            passportList[index].type;
                                        isOneTab = true;
                                        selectedTab = passport;
                                        _passportData = passportList[index];
                                        _tabController = TabController(
                                            length: 1, vsync: this);
                                        checkActive();
                                        setState(() {});
                                      }
                                    },
                                    child: const Text(
                                      edit,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: AppColors.deepSkyBlue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: appText(widget
                                    .person.personDetails!.firstMiddleName)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    passport + 'No.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(passportList
                                      .elementAt(index)
                                      .personPassportDocumentId
                                      .toString())
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nationality',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    passportList
                                        .elementAt(index)
                                        .nationality
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 0, right: 12),
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: appText(
                                      remove,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: appText(
                              '',
                            )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Issue Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(passportList
                                      .elementAt(index)
                                      .issueDate
                                      .toString())
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Expiry Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(passportList
                                      .elementAt(index)
                                      .expireDate
                                      .toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )).toList();
  }

//  const Icon(
//                         Icons.remove_circle,
//                         color: AppColors.red,
//                         size: 14,
//                       ),
//                       InkWell(onTap: () {}, child: appText(remove)),

  List<Widget> _buildVisaWidget({required List<Visa> visaList}) {
    return List.generate(
        visaList.length,
        (index) => SizedBox(
              height: spacing220,
              width: spacing212,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 12),
                                    child: SvgPicture.asset(AppImages.visaSvg),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isEditScreenOpened = true;
                                      isOneTab = true;
                                      selectedTab = visa;
                                      vselectedCountry =
                                          widget.person.countries![
                                              visaList[index].countryId];
                                      vnumberController.text =
                                          visaList[index].number ?? '';
                                      vissueDateController.text =
                                          visaList[index].issueDate ?? '';
                                      vexpiryDateControlleer.text =
                                          visaList[index].expireDate ?? '';
                                      _tabController =
                                          TabController(length: 1, vsync: this);
                                      _visaData = visaList[index];
                                      visaId =
                                          visaList[index].personVisaDocumentId;
                                      visaCheckActive();
                                      setState(() {});
                                    },
                                    child: const Text(
                                      edit,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: AppColors.deepSkyBlue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: appText(
                              widget.person.personDetails!.firstMiddleName,
                            )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    visa + 'No.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(visaList
                                      .elementAt(index)
                                      .personVisaDocumentId
                                      .toString())
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nationality',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    visaList
                                            .elementAt(index)
                                            .personVisaIssueCountry!
                                            .name ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 0, right: 12),
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: appText(
                                      remove,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: appText(
                              '',
                            )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Issue Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(visaList
                                      .elementAt(index)
                                      .issueDate
                                      .toString())
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Expiry Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(visaList
                                      .elementAt(index)
                                      .expireDate
                                      .toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )).toList();
  }

  @override
  void didChangeDependencies() {
    _tabController = TabController(length: stringTabs.length, vsync: this);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spacing20),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: spacing20,
                          bottom: spacing52,
                        ),
                        child: Text(
                          'Passport & Visa',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      !isEditScreenOpened
                          ? AbsorbPointer(
                              absorbing: !editBool,
                              child: SizedBox(
                                  height: spacing220,
                                  child: _buildPassportOrVisaWidgetList(
                                    person: widget.person.personDetails,
                                    isOneTab: isOneTab,
                                  )),
                            )
                          : AbsorbPointer(
                              absorbing: !editBool,
                              child: SizedBox(
                                height: spacing440,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: spacing44,
                                          bottom: spacing32,
                                          left: spacing20),
                                      child: TabBar(
                                        controller: _tabController,
                                        labelPadding:
                                            const EdgeInsets.all(spacing12),
                                        isScrollable: true,
                                        labelColor: AppColors.deepLilac,
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        unselectedLabelColor:
                                            AppColors.powderBlue,
                                        indicatorColor: AppColors.deepLilac,
                                        tabs: (!isOneTab
                                                ? stringTabs
                                                : [selectedTab!])
                                            .map((e) => Text(e))
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                          controller: _tabController,
                                          children: [...tabViews()]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
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
                isEditScreenOpened = false;
                isOneTab = false;
                setState(() {});
              },
              onSave: () {
                if (editBool) {
                  savePassport();
                  saveVisa();
                }
                setState(() => editBool = !editBool);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> tabViews() {
    List<Widget> widgets = [];
    if (!isOneTab) {
      widgets.add(passportTabView());
      widgets.add(visaTabView());
    } else if (selectedTab == passport) {
      widgets.add(passportTabView());
    } else {
      widgets.add(visaTabView());
    }
    return widgets;
  }

  Widget passportTabView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _getPrefrenceDropDownMenuField(),
            _getNationalityDropDownMenuField(false),
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
                      padding: const EdgeInsets.all(spacing6),
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
                passportFiles.add(_startFilePicker());
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
                  _passportData != null &&
                          _passportData!.crewPassportDocumentFiles != null
                      ? _passportData!.crewPassportDocumentFiles!.length
                      : 0,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            color: AppColors.lightBrown,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(_passportData!
                                      .crewPassportDocumentFiles![index].name ??
                                  'file'),
                            )),
                      )),
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
            _getNationalityDropDownMenuField(true),
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
                      padding: const EdgeInsets.all(spacing6),
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
                _startFilePicker();
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
                  _visaData != null && _visaData!.crewVisaDocumentFiles != null
                      ? _visaData!.crewVisaDocumentFiles!.length
                      : 0,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            width: 100,
                            color: AppColors.lightBrown,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_visaData!
                                      .crewVisaDocumentFiles![index].name ??
                                  'file'),
                            )),
                      )),
            )
          ],
        ),
      ],
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
      if (prefrences.length != 10 && selectedPreference != null) {
        List<String> temp = prefrences.toList();
        temp.add(selectedPreference!);
        temp.sort(((a, b) => int.parse(a) > int.parse(b) ? 1 : -1));
        prefrences = temp.toSet();
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

  Widget _getNationalityDropDownMenuField(bool isVisa) {
    List<Country> countries = [];
    if (widget.person.countries != null) {
      countries.addAll(widget.person.countries!.values.toList());
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<Country>(
            value: isVisa ? vselectedCountry : pselectedCountry,
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
              if (!isVisa) {
                pselectedCountry = onChanged ?? pselectedCountry;
              } else {
                vselectedCountry = onChanged ?? vselectedCountry;
              }
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
            value: selectedPassportType != null &&
                    passportType.contains(selectedPassportType)
                ? selectedPassportType
                : null,
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

  getTextFormField(
      String? value, TextEditingController controller, bool name, bool billing,
      {String? labelText = '', bool? isCheckActive, bool? isVisa}) {
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
            enabledBorder: const OutlineInputBorder(
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

  savePassport() {
    if (selectedPreference != null &&
        pselectedCountry != null &&
        pnumberController.text.isNotEmpty &&
        pissueDateController.text.isNotEmpty &&
        pexpiryDateControlleer.text.isNotEmpty &&
        selectedPassportType != null &&
        selectedPassportType!.isNotEmpty) {
      scafoldSuccessMessage('Passport data saved successfully', context);
      context.read<PersonBloc>().add(UploadPassportEvent(
          passportFiles,
          UploadDoc(
              guid: widget.person.personDetails!.guid!,
              id: 0,
              name: pnumberController.text,
              personPassportDocumentId: passportId,
              docTypeId: 1,
              prefrence: selectedPreference != null
                  ? int.parse(selectedPreference!)
                  : null,
              customerId: widget.person.personDetails != null &&
                      widget.person.personDetails!.contractedBy != null &&
                      widget.person.personDetails!.contractedBy!.isNotEmpty
                  ? widget.person.personDetails!.contractedBy!.first.customerId
                  : null,
              number: pnumberController.text,
              issueDate: pissueDateController.text,
              expiryDate: pexpiryDateControlleer.text,
              type: selectedPassportType ?? '',
              isActive: pisActive,
              total: passportFiles.length,
              overwriteoptional: false,
              countryId: pselectedCountry!.countryId,
              nationality: pselectedCountry!.countryName!,
              documentType: 'passport')));
    }
  }

  saveVisa() {
    if (vselectedCountry != null &&
        vnumberController.text.isNotEmpty &&
        vissueDateController.text.isNotEmpty &&
        vexpiryDateControlleer.text.isNotEmpty) {
      scafoldSuccessMessage('Visa data saved successfully', context);
      context.read<PersonBloc>().add(UploadVisaEvent(
          visaFiles,
          UploadDoc(
            visaId: visaId,
            countryId: vselectedCountry!.countryId,
            docTypeId: 1,
            expiryDate: vexpiryDateControlleer.text,
            guid: widget.person.personDetails!.guid!,
            id: 0,
            isActive: visActive,
            issueDate: vissueDateController.text,
            name: vnumberController.text,
            number: vnumberController.text,
            overwriteoptional: false,
            total: visaFiles.length,
            documentType: 'visa',
          )));
    }
  }

  _startFilePicker() async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();
    Object? output;
    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files != null && files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            output = reader.result;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {});
        });

        reader.readAsArrayBuffer(file);
      }
    });
    return output;
  }
}
