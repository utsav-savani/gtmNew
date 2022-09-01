// ignore_for_file: prefer_const_constructors

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/people/bloc/cubit/companies_cubit.dart';
import 'package:gtm/pages/people/bloc/person_bloc.dart';

class WCompaniesPage extends StatefulWidget {
  const WCompaniesPage({Key? key, required this.person}) : super(key: key);
  final PersonState person;
  @override
  State<WCompaniesPage> createState() => _WCompaniesPageState();
}

class _WCompaniesPageState extends State<WCompaniesPage> {
  bool editBool = false;
  int pageNo = 0;
  Set<int> selectedCompanies = {};
  bool isFirstCall = true;
  TextEditingController nameController = TextEditingController();
  Set<int> selectedCustomerIds = {};
  List<Customer> customers = [];
  Map<int, Customer> customerMap = {};
  @override
  void didChangeDependencies() {
    customers.clear();
    customers.addAll(widget.person.customers);
    for (int i = 0; i < customers.length; i++) {
      customerMap.putIfAbsent(customers[i].customerId, () => customers[i]);
    }

    if (widget.person.personDetails != null) {
      if (widget.person.personDetails!.contractedBy != null) {
        for (int i = 0;
            i < widget.person.personDetails!.contractedBy!.length;
            i++) {
          if (customerMap.containsKey(
              widget.person.personDetails!.contractedBy![i].customerId)) {
            selectedCustomerIds
                .add(widget.person.personDetails!.contractedBy![i].customerId);
          }
        }
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CompaniesCubit, CompaniesState>(
        listener: (context, state) {},
        child: BlocBuilder<CompaniesCubit, CompaniesState>(
          builder: (context, state) {
            if (state.status == CompanyStatus.loading) {
              return loadingWidget();
            }

            if (customers.isEmpty) {
              return noDataFoundWidget();
            }
            return Stack(
              children: [
                AbsorbPointer(
                  absorbing: !editBool,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: _getCustomersMultiSelectDropDown(),
                          )),
                        ],
                      ),
                      SingleChildScrollView(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: selectedCustomerIds.length,
                            itemBuilder: (BuildContext context, int index) {
                              return getTextFormField(
                                customerMap.containsKey(
                                        selectedCustomerIds.toList()[index])
                                    ? customerMap[selectedCustomerIds
                                            .toList()[index]]!
                                        .name
                                    : '',
                                selectedCustomerIds.toList()[index],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CancelEditSaveButtons(
                    editBool: editBool,
                    updateObj: null,
                    onCancel: () {
                      setState(() => editBool = false);
                    },
                    onSave: () {
                      if (editBool) {
                        Map<String, dynamic> forms = {};
                        forms.putIfAbsent(
                            'customerId', () => selectedCustomerIds.toList());
                        forms.putIfAbsent('formId', () => 3);
                        context.read<CompaniesCubit>().updatePersonCompanies(
                            form: forms,
                            customerId: 93,
                            isPassenger: widget.person.isPassenger,
                            guid: widget.person.personDetails!.guid!);
                      }
                      setState(() => editBool = !editBool);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _getCustomersMultiSelectDropDown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildDropdown(
          label: 'Select Flight categories',
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

  getTextFormField(String string, int id) {
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: TextFormField(
          readOnly: true,
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: string,
            suffixIcon: GestureDetector(
              onTap: () {
                selectedCustomerIds.remove(id);
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        color: AppColors.powderBlue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          controller: TextEditingController()),
    );
  }
}
