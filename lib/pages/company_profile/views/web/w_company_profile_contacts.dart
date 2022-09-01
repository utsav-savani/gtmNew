import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/company_profile/bloc/contact/customer_contact_bloc.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:gtm/pages/company_profile/views/web/w_contact_details.dart';

class WCompanyProfileContacts extends StatefulWidget {
  const WCompanyProfileContacts({Key? key, required this.companyProfile})
      : super(key: key);
  final CompanyProfile companyProfile;

  @override
  State<WCompanyProfileContacts> createState() =>
      _WCompanyProfileContactsState();
}

class _WCompanyProfileContactsState extends State<WCompanyProfileContacts> {
  bool editBool = false;
  bool isFirstCall = true;
  CompanyProfile? updateObj;
  List<CustomerContact> _contactsList = [];
  List<CustomerContact> _searchList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController seachController = TextEditingController();
  List<String> contactTypes = [
    'Main',
    'Admin',
    'OPS',
    'Sales',
    'Accounts',
    'VR',
    'PR',
    'Personal',
    'Other'
  ];
  String? selectedContactType;
  int? selectedPrefrence;
  CustomerContact? selectedContact;

  @override
  void initState() {
    super.initState();
    context
        .read<CustomerContactBloc>()
        .add(FetchContactsEvent(widget.companyProfile.organizationId));
  }

  showDetailScreen({bool? isNew}) {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
            child: WContactDetails(
              customerId: widget.companyProfile.organizationId,
              contactsList: _contactsList,
              customerContact: isNew != null && isNew ? null : selectedContact,
            ),
          );
        }).then((value) {
      context
          .read<CustomerContactBloc>()
          .add(FetchContactsEvent(widget.companyProfile.organizationId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerContactBloc, CustomerContactState>(
      listener: (context, state) {},
      child: BlocBuilder<CustomerContactBloc, CustomerContactState>(
          builder: (context, state) {
        if (state.status == ContactListStatus.loading ||
            state.status == ContactListStatus.initial) {
          return loadingWidget();
        }
        if (state.status == ContactListStatus.success) {
          _contactsList = state.contacts;
          if (isFirstCall) {
            isFirstCall = false;
            _searchList = _contactsList;
          }
        }
        // MARK Create list of rows
        List<List<Widget>> rows = [];

        _searchList.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        for (var val in _searchList) {
          rows.add([
            appText(val.name, color: AppColors.charcoalGrey),
            appText(val.priority.toString(), color: AppColors.charcoalGrey),
            appText(val.contactType, color: AppColors.charcoalGrey),
            appText('', color: AppColors.charcoalGrey),
          ]);
        }
        List tableColumns = ['Name', 'Priority', 'Type', 'Action'];
        List tableColumnsWidth = [0, 100, 200, 200];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: seachController,
                      onChanged: (value) => updateSearchList(),
                      decoration:
                          const InputDecoration(hintText: 'Search contact'),
                    ),
                    height(10),
                    CmsTableHeader(
                      columns: tableColumns,
                      columnsWidth: tableColumnsWidth,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: rows.length,
                        itemBuilder: (BuildContext context, int index) {
                          Widget actions = GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                appText(
                                  'Remove',
                                  color: AppColors.powderBlue,
                                )
                              ],
                            ),
                          );
                          Widget editActions = GestureDetector(
                              onTap: () {
                                selectedContact = _searchList[index];
                                showDetailScreen();
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: AppColors.blueColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ));
                          var callRecords = _searchList[index].callRecords;
                          if (callRecords.isNotEmpty) {
                            callRecords.sort((a, b) =>
                                a.contactCategoryId > b.contactCategoryId
                                    ? 1
                                    : -1);
                          }
                          int? lastCategory;
                          int lastCount = 0;
                          Widget expWidget = Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.blueGrey,
                                  width: 2.0,
                                ),
                                right: BorderSide(
                                  color: AppColors.blueGrey,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    color: AppColors.paleGrey,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: appText(
                                              'Contact Type',
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: appText(
                                              'Medium',
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: appText(
                                              'Info',
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: appText(
                                              'Purpose',
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          _searchList[index].callRecords.length,
                                      itemBuilder:
                                          (BuildContext cont, int ind) {
                                        var thisRow = callRecords[ind];
                                        if (lastCategory == null) {
                                          lastCount++;
                                          lastCategory =
                                              thisRow.contactCategoryId;
                                        } else if (thisRow.contactCategoryId ==
                                            lastCategory) {
                                          lastCount++;
                                        } else {
                                          lastCategory =
                                              thisRow.contactCategoryId;
                                          lastCount = 1;
                                        }
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          AppColors.powderBlue,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                child: appText(
                                                  thisRow.contactType,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          AppColors.powderBlue,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                child: appText(
                                                  thisRow.medium +
                                                      ' $lastCount',
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          AppColors.powderBlue,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                child: appText(
                                                  thisRow.info,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          AppColors.powderBlue,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                child: appText(
                                                  thisRow.purpose!.isEmpty
                                                      ? ""
                                                      : thisRow.purpose!
                                                          .join(', '),
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                          );
                          return CmsTableRow(
                            isExpandable: true,
                            editBool: editBool,
                            actions: actions,
                            editActions: editActions,
                            expandedWidget: expWidget,
                            columns: tableColumns,
                            columnsWidth: tableColumnsWidth,
                            row: rows[index],
                            itemIndex: index,
                          );
                        }),
                    CmsTableFooter(
                      columnsWidth: tableColumnsWidth,
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDetailScreen(isNew: true);
                      },
                      child: const Text('Create New'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.tableSearchBarColor)),
                    ),
                    width(10),
                    CancelEditSaveButtons(
                      editBool: editBool,
                      updateObj: updateObj,
                      onCancel: () {
                        setState(() => editBool = false);
                      },
                      onSave: () {
                        if (editBool) {}
                        setState(() => editBool = !editBool);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void updateSearchList() {
    if (_contactsList.isNotEmpty && seachController.text.isNotEmpty) {
      List<CustomerContact> temp = [];
      for (int i = 0; i < _contactsList.length; i++) {
        if (_contactsList[i].name.contains(seachController.text)) {
          temp.add(_contactsList[i]);
        }
        _searchList = temp;
      }
    } else {
      _searchList = _contactsList;
    }
    setState(() {});
  }
}
