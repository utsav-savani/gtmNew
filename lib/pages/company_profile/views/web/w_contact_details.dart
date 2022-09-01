import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/company_profile/bloc/contact/cubit/contact_details_cubit.dart';
import 'package:gtm/pages/company_profile/bloc/contact/customer_contact_bloc.dart';

class WContactDetails extends StatefulWidget {
  final CustomerContact? customerContact;
  final List<CustomerContact> contactsList;
  final int customerId;

  const WContactDetails(
      {Key? key,
      this.customerContact,
      required this.contactsList,
      required this.customerId})
      : super(key: key);

  @override
  State<WContactDetails> createState() => _WContactDetailsState();
}

class _WContactDetailsState extends State<WContactDetails> {
  bool editBool = true;
  TextEditingController nameController = TextEditingController();
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
  String? initialContactType;
  int? selectedPriority;
  int? initialPriority;
  Customer? selectedCustomers;
  Set<int> selectedCustomerIds = {};
  Vendor? selectedVendor;
  List<int> selectedVendorIds = [];
  CreateCustomerContact? customerContact;
  List<ContactInfo> contactInfos = [];
  Map<String, Set<int>> map = {};
  List<String> mediums = [
    'Email',
    'Phone',
    'Mobile',
    'Fax',
    'Designation',
    'Skype',
    'Title',
    'Website',
    'SITA',
    'AFTN',
    'Address',
    'Frequency',
    'Notes'
  ];
  List<String> purposes = ['Brief', 'Mailer', 'External'];

  Map<String, int> mediumsMap = {};

  @override
  void initState() {
    context.read<ContactDetailsCubit>().loadContactBasicDetails(
        customerId: widget.customerId, contacts: widget.contactsList);
    for (int i = 0; i < mediums.length; i++) {
      mediumsMap.putIfAbsent(mediums[i].toLowerCase(), () => i + 1);
    }
    if (widget.customerContact != null) {
      context
          .read<ContactDetailsCubit>()
          .getContactDetails(widget.customerContact!.customercontactId);
      selectedContactType = widget.customerContact!.contactType;
      initialContactType = widget.customerContact!.contactType;
      nameController.text = widget.customerContact!.name;
      selectedPriority = widget.customerContact!.priority;
      initialPriority = widget.customerContact!.priority;
      if (widget.customerContact!.linkedCustomers != null &&
          widget.customerContact!.linkedCustomers!.isNotEmpty) {
        selectedCustomerIds.addAll(widget.customerContact!.linkedCustomers!
            .map((e) => e.customerId)
            .toSet());
      }
      if (widget.customerContact!.linkedVendors != null &&
          widget.customerContact!.linkedVendors!.isNotEmpty) {
        selectedVendorIds.addAll(widget.customerContact!.linkedVendors!
            .map((e) => e.vendorId)
            .toSet()
            .toList());
      }
      customerContact = transformResponse(widget.customerContact!);
      if (customerContact != null) {
        contactInfos.addAll(customerContact!.contactInfos);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AbsorbPointer(
                absorbing: !editBool,
                child: contactDetails(
                    customerId: widget.customerId,
                    contactList: widget.contactsList,
                    customerContact: widget.customerContact),
              ),
              CancelEditSaveButtons(
                editBool: editBool,
                updateObj: null,
                onCancel: () {
                  setState(() => editBool = false);
                  Navigator.pop(context);
                },
                onSave: () {
                  if (editBool) {
                    if (widget.customerContact == null) {
                      customerContact = CreateCustomerContact(
                          customerId: widget.customerId,
                          contactInfos: [],
                          contactType: '',
                          name: '',
                          priority: -1);
                    }
                    customerContact!.name = nameController.text;
                    if (selectedPriority != null) {
                      customerContact!.contactType = selectedContactType ?? '';
                      customerContact!.priority = selectedPriority!;
                    }
                    customerContact!.customerIds = selectedCustomerIds.toList();
                    customerContact!.vendorIds = selectedVendorIds.toList();
                    customerContact!.contactInfos = contactInfos;
                    if (widget.customerContact != null) {
                      context
                          .read<ContactDetailsCubit>()
                          .updateContactDetails(customerContact!);
                    } else {
                      context
                          .read<ContactDetailsCubit>()
                          .createContactDetails(customerContact!);
                    }
                    context
                        .read<CustomerContactBloc>()
                        .add(FetchContactsEvent(widget.customerId));
                  }
                  setState(() => editBool = !editBool);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  contactDetails(
      {required int customerId,
      List<CustomerContact>? contactList,
      CustomerContact? customerContact}) {
    return BlocBuilder<ContactDetailsCubit, ContactDetailsState>(
      builder: (context, state) {
        if (state.status == ContactStatus.loading) {
          return loadingWidget();
        }
        if (state.status == ContactStatus.success) {
          map = state.contactTypePriorityMap;
          if (map.isNotEmpty &&
              selectedContactType != null &&
              selectedPriority != null &&
              selectedContactType == initialContactType) {
            Set<int> temp = {};
            temp.add(initialPriority!);
            temp.addAll(map[selectedContactType!.toLowerCase()]!);
            map[selectedContactType!.toLowerCase()] = temp;
          }
        }
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Contact Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Row(
            children: [
              getTextFormField(nameController.text, nameController, 'Name'),
              _getContactTypeDropDownMenuField(),
            ],
          ),
          Row(
            children: [
              _getPriorityDropDownMenuField(state.contactTypePriorityMap),
              // _getCustomerDropDownMenuField(state.customers),
              Expanded(child: _getCustomerMultiSelectDropDown(state.customers))
            ],
          ),
          Row(
            children: [
              Expanded(child: _getVendorMultiSelectDropDown(state.vendors)),
              Expanded(child: Container())
            ],
          ),
          Text(
            'Contact Details',
            style: const TextStyle().copyWith(fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Column(
            children: List.generate(contactInfos.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      _getMediumDropDownMenuField(index),
                      width(10),
                      Container(
                        height: 60,
                        width: 70,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            if (contactInfos[index].medium != null &&
                                mediumsMap.containsKey(contactInfos[index]
                                    .medium!
                                    .toLowerCase())) {
                              ContactInfo info = contactInfos[index];
                              int selectedMedium = mediumsMap[
                                  contactInfos[index].medium!.toLowerCase()]!;
                              b:
                              if (info.category != null &&
                                  info.category!.isNotEmpty) {
                                for (int i = 0;
                                    i < info.category!.length;
                                    i++) {
                                  if (info.category![i].contactcategoryType ==
                                      selectedMedium) {
                                    if (info.category![i].content != null) {
                                      if (info.category![i].content!.length <
                                          3) {
                                        info.category![i].content!.add('');
                                      } else {
                                        // TODO: show an error message
                                      }
                                    } else {
                                      info.category![i].content = [''];
                                    }
                                    break b;
                                  }
                                }
                                info.category!.add(ContactCategory(
                                    contactcategoryType: selectedMedium,
                                    content: ['']));
                              } else {
                                info.category = [];
                                info.category!.add(ContactCategory(
                                    contactcategoryType: selectedMedium,
                                    content: ['']));
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
                      width(30),
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: _getPurposeMultiSelectDropDown(index),
                      ),
                      ..._generateContactFields(index)
                    ],
                  ),
                  index < (contactInfos.length - 1)
                      ? const Divider()
                      : Container()
                ],
              );
            }),
          ),
          Row(
            children: [
              const Expanded(flex: 8, child: Divider()),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    contactInfos.add(ContactInfo());
                    setState(() {});
                  },
                  icon: Row(children: const [Icon(Icons.add), Text('Add')]),
                ),
              ),
              const Expanded(flex: 8, child: Divider()),
            ],
          ),
        ]);
      },
    );
  }

  Widget _getContactTypeDropDownMenuField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<String>(
            value: selectedContactType,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(spacing4),
                hintText: 'Contact Type',
                labelText: 'Contact Type'),
            items: contactTypes
                .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                    )))
                .toList(),
            onChanged: (onChanged) {
              selectedContactType = onChanged ?? selectedContactType;
              selectedPriority = null;
              setState(() {});
            }),
      ),
    );
  }

  Widget _getPriorityDropDownMenuField(Map<String, Set<int>> map) {
    List<int> priorities = [];
    if (selectedContactType != null && selectedContactType!.isNotEmpty) {
      if (map.containsKey(selectedContactType!.toLowerCase())) {
        priorities.addAll(map[selectedContactType!.toLowerCase()]!.toList());
      }
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<int>(
            value: selectedPriority,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(spacing4),
                hintText: 'Priority',
                labelText: 'Priority'),
            items: priorities
                .map((e) => DropdownMenuItem<int>(
                    value: e,
                    child: Text(
                      e.toString(),
                    )))
                .toList(),
            onChanged: (onChanged) {
              selectedPriority = onChanged ?? selectedPriority;
              setState(() {});
            }),
      ),
    );
  }

  _getCustomerMultiSelectDropDown(List<Customer> customers) {
    String? label;
    if (selectedCustomerIds.isNotEmpty) {
      List<String> temp = [];
      Map<int, Customer> customerMap = {};
      for (int i = 0; i < customers.length; i++) {
        customerMap.putIfAbsent(customers[i].customerId, () => customers[i]);
      }
      for (int i = 0; i < selectedCustomerIds.length; i++) {
        if (customerMap.containsKey(selectedCustomerIds.toList()[i])) {
          temp.add(customerMap[selectedCustomerIds.toList()[i]]!.name);
        }
      }
      label = temp.join(', ');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildDropdownSelector(
          label: 'Customers',
          hint: label ?? '',
          items: customers
              .map((e) => SelectionHelper(
                  e, selectedCustomerIds.contains(e.customerId)))
              .toList()
              .map((e) => DropdownMenuItem<String>(
                    child: StatefulBuilder(
                      builder: (context, innerState) {
                        return CheckboxListTile(
                          title: Text(e.data.name),
                          onChanged: (v) {
                            innerState(() {
                              e.isSelected = !e.isSelected;
                            });
                            if (e.isSelected) {
                              selectedCustomerIds.add(e.data.customerId);
                            } else if (!e.isSelected) {
                              selectedCustomerIds.remove(e.data.customerId);
                            }
                            setState(() {});
                          },
                          value: e.isSelected,
                        );
                      },
                    ),
                    value: e.data.name,
                  ))
              .toList(),
          onChanged: (val) {}),
    );
  }

  _getVendorMultiSelectDropDown(List<Vendor> vendors) {
    String? label;
    if (selectedVendorIds.isNotEmpty) {
      List<String> temp = [];
      Map<int, Vendor> vendorMap = {};
      for (int i = 0; i < vendors.length; i++) {
        vendorMap.putIfAbsent(vendors[i].vendorId, () => vendors[i]);
      }
      for (int i = 0; i < selectedVendorIds.length; i++) {
        if (vendorMap.containsKey(selectedVendorIds.toList()[i])) {
          temp.add(vendorMap[selectedVendorIds.toList()[i]]!.name);
        }
      }
      label = temp.join(', ');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildDropdownSelector(
          label: 'Vendors',
          hint: label ?? '',
          items: vendors
              .map((e) =>
                  SelectionHelper(e, selectedVendorIds.contains(e.vendorId)))
              .toList()
              .map((e) => DropdownMenuItem<String>(
                    child: StatefulBuilder(
                      builder: (context, innerState) {
                        return CheckboxListTile(
                          title: Text(e.data.name),
                          onChanged: (v) {
                            innerState(() {
                              e.isSelected = !e.isSelected;
                            });
                            if (e.isSelected) {
                              selectedVendorIds.add(e.data.vendorId);
                            } else if (!e.isSelected) {
                              selectedVendorIds.remove(e.data.vendorId);
                            }
                            setState(() {});
                          },
                          value: e.isSelected,
                        );
                      },
                    ),
                    value: e.data.name,
                  ))
              .toList(),
          onChanged: (val) {}),
    );
  }

  Widget _getMediumDropDownMenuField(int index) {
    return SizedBox(
      width: 150,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(spacing4), hintText: 'Medium'),
            items: mediums
                .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                    )))
                .toList(),
            onChanged: (onChanged) {
              if (onChanged != null) {
                ContactInfo info = contactInfos[index];
                info.medium = onChanged;
                contactInfos[index] = info;
                setState(() {});
              }
            }),
      ),
    );
  }

  _getPurposeMultiSelectDropDown(int index) {
    String? label;
    Set<String> purpose = {};
    if (contactInfos[index].purposes != null &&
        contactInfos[index].purposes!.isNotEmpty) {
      purpose
          .addAll(contactInfos[index].purposes!.map((e) => e.trim()).toList());
      label = purpose.join(', ');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildDropdown(
          label: label ?? 'Purpose',
          items: purposes
              .map((e) => SelectionHelper(e, purpose.contains(e.trim())))
              .toList()
              .map((e) => DropdownMenuItem<String>(
                    child: StatefulBuilder(
                      builder: (context, innerState) {
                        return CheckboxListTile(
                          title: Text(e.data),
                          onChanged: (v) {
                            innerState(() {
                              e.isSelected = !e.isSelected;
                            });
                            if (e.isSelected) {
                              purpose.add(e.data);
                              contactInfos[index].purposes = purpose.toList();
                            } else if (!e.isSelected) {
                              purpose.remove(e.data);
                              contactInfos[index].purposes = purpose.toList();
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

  List<Widget> _generateContactFields(int index) {
    List<Widget> contactTypes = [];
    if (contactInfos[index].category != null) {
      for (int i = 0; i < contactInfos[index].category!.length; i++) {
        String medium =
            mediums[contactInfos[index].category![i].contactcategoryType - 1];
        if (contactInfos[index].category![i].content != null) {
          for (int j = 0;
              j < contactInfos[index].category![i].content!.length;
              j++) {
            contactTypes.add(
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                child: Text(
                  '$medium${j + 1}: ',
                  textAlign: TextAlign.center,
                ),
              ),
            );
            contactTypes.add(SizedBox(
              height: 60,
              width: 180,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: spacing10),
                child: TextFormField(
                  onChanged: (value) {
                    contactInfos[index].category![i].content![j] = value;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(spacing6)),
                      borderSide: BorderSide(
                        color: AppColors.powderBlue,
                      ),
                    ),
                  ),
                  controller: TextEditingController(
                      text: contactInfos[index].category![i].content![j]),
                ),
              ),
            ));
            contactTypes.add(SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spacing10),
                child: IconButton(
                    onPressed: () {
                      contactInfos[index].category![i].content!.removeAt(j);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete)),
              ),
            ));
          }
        }
      }
    }
    return contactTypes;
  }

  getTextFormField(
      String? value, TextEditingController controller, String labelText) {
    controller.text = value!;
    return Expanded(
      child: Padding(
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
      ),
    );
  }

  CreateCustomerContact transformResponse(CustomerContact contactDetail) {
    Set<int> customerIds = {};
    Set<int> vendorIds = {};
    List<ContactInfo> contactInfos = [];
    if (contactDetail.linkedCustomers != null &&
        contactDetail.linkedCustomers!.isNotEmpty) {
      for (int i = 0; i < contactDetail.linkedCustomers!.length; i++) {
        customerIds.add(contactDetail.linkedCustomers![i].customerId);
      }
    }
    if (contactDetail.linkedVendors != null &&
        contactDetail.linkedVendors!.isNotEmpty) {
      for (int i = 0; i < contactDetail.linkedVendors!.length; i++) {
        vendorIds.add(contactDetail.linkedVendors![i].vendorId);
      }
    }
    Map<int, Map<int, List<String>>> typeContactIdContentMap = {};
    Map<int, List<String>> purposeContactTypeIdMap = {};
    if (contactDetail.callRecords.isNotEmpty) {
      Map<int, List<CallRecord>> recordContactTypeIdMap = {};
      for (int i = 0; i < contactDetail.callRecords.length; i++) {
        purposeContactTypeIdMap.putIfAbsent(
            contactDetail.callRecords[i].customerContactTypeId,
            () => contactDetail.callRecords[i].purpose ?? []);
        if (recordContactTypeIdMap
            .containsKey(contactDetail.callRecords[i].customerContactTypeId)) {
          List<CallRecord> temp = recordContactTypeIdMap[
              contactDetail.callRecords[i].customerContactTypeId]!;
          temp.add(contactDetail.callRecords[i]);
          recordContactTypeIdMap[
              contactDetail.callRecords[i].customerContactTypeId] = temp;
        } else {
          recordContactTypeIdMap.putIfAbsent(
              contactDetail.callRecords[i].customerContactTypeId,
              () => [contactDetail.callRecords[i]]);
        }
      }
      if (recordContactTypeIdMap.isNotEmpty) {
        List<int> typeIds = recordContactTypeIdMap.keys.toList();
        typeIds.sort();
        for (int i = 0; i < typeIds.length; i++) {
          List<CallRecord> records = recordContactTypeIdMap[typeIds[i]]!;
          Map<int, List<String>> tempContent = {};
          for (int j = 0; j < records.length; j++) {
            if (tempContent.containsKey(records[j].contactCategoryId)) {
              List<String> temp = tempContent[records[j].contactCategoryId]!;
              temp.add(records[j].info);
              tempContent[records[i].contactCategoryId] = temp;
            } else {
              tempContent.putIfAbsent(
                  records[j].contactCategoryId, () => [records[j].info]);
            }
          }
          typeContactIdContentMap.putIfAbsent(typeIds[i], () => tempContent);
        }
      }
    }
    if (typeContactIdContentMap.isNotEmpty) {
      List<int> typeIds = typeContactIdContentMap.keys.toList();
      typeIds.sort();
      for (int i = 0; i < typeIds.length; i++) {
        ContactInfo info = ContactInfo();
        info.category = [];
        info.purposes = purposeContactTypeIdMap[typeIds[i]];
        List<int> contactIds =
            typeContactIdContentMap[typeIds[i]]!.keys.toList();
        contactIds.sort();
        for (int j = 0; j < contactIds.length; j++) {
          info.category!.add(ContactCategory(
              contactcategoryType: contactIds[j],
              content: typeContactIdContentMap[typeIds[i]]![contactIds[j]]));
        }
        contactInfos.add(info);
      }
    }
    return CreateCustomerContact(
        name: contactDetail.name,
        priority: contactDetail.priority,
        customercontactId: contactDetail.customercontactId,
        customerId: contactDetail.customerId,
        contactType: contactDetail.contactType,
        vendorIds: vendorIds.toList(),
        customerIds: customerIds.toList(),
        contactInfos: contactInfos);
  }
}
