import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/company_profile/cubit/company_flight_category_cubit.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';

class WCompanyProfileFlightCategories extends StatefulWidget {
  final CompanyProfile companyProfile;
  const WCompanyProfileFlightCategories({
    Key? key,
    required this.companyProfile,
  }) : super(key: key);

  @override
  State<WCompanyProfileFlightCategories> createState() =>
      _WCompanyProfileFlightCategoriesState();
}

class _WCompanyProfileFlightCategoriesState
    extends State<WCompanyProfileFlightCategories> {
  List<FlightCategory> _flightCategoryList = [];
  Map<int, FlightCategory> flightMap = {};
  bool editBool = false;
  bool isFirstCall = true;
  Set<int> selectedFlightCategoriesIds = {};

  CompanyProfile? oldObject;
  late CompanyProfile newObject;
  CompanyProfile? updateObj;

  @override
  void didChangeDependencies() {
    context
        .read<CompanyFlightCategoryCubit>()
        .getCompanyProfileFlightCategory(widget.companyProfile.customerId);
    oldObject = widget.companyProfile;
    newObject = widget.companyProfile;
    updateObj = newObject;
    super.didChangeDependencies();
  }

  searchFlight({String searchText = ''}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocListener<CompanyFlightCategoryCubit, CompanyFlightCategoryState>(
        listener: (context, state) {},
        child:
            BlocBuilder<CompanyFlightCategoryCubit, CompanyFlightCategoryState>(
          builder: (context, state) {
            if (state.status == CompanyFlightCategoryStatus.loading ||
                state.status == CompanyFlightCategoryStatus.initial) {
              return loadingWidget();
            }
            if (state.status == CompanyFlightCategoryStatus.success) {
              _flightCategoryList = state.flightcategories;
              if (_flightCategoryList.isNotEmpty) {
                for (int i = 0; i < _flightCategoryList.length; i++) {
                  flightMap.putIfAbsent(
                      _flightCategoryList[i].flightCategoryId!,
                      () => _flightCategoryList[i]);
                }
              }
              if (state.customerFlightCategoryList != null && isFirstCall) {
                selectedFlightCategoriesIds.addAll(state
                    .customerFlightCategoryList!
                    .map((e) => e.flightCategoryId)
                    .toSet());
              }
              isFirstCall = false;
            }
            if (_flightCategoryList.isEmpty) {
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
                            child: _getFlightcategoriesMultiSelectDropDown(),
                          )),
                        ],
                      ),
                      SingleChildScrollView(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: selectedFlightCategoriesIds.length,
                            itemBuilder: (BuildContext context, int index) {
                              return getTextFormField(
                                flightMap.containsKey(
                                            selectedFlightCategoriesIds
                                                .toList()[index]) &&
                                        flightMap[selectedFlightCategoriesIds
                                                    .toList()[index]]!
                                                .category !=
                                            null
                                    ? flightMap[selectedFlightCategoriesIds
                                            .toList()[index]]!
                                        .category!
                                    : '',
                                selectedFlightCategoriesIds.toList()[index],
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
                    updateObj: updateObj,
                    onCancel: () {
                      setState(() => editBool = false);
                    },
                    onSave: () {
                      if (editBool) {
                        context
                            .read<CompanyFlightCategoryCubit>()
                            .updateFlightcategory(
                                customerId:
                                    widget.companyProfile.organizationId,
                                categoryIds:
                                    selectedFlightCategoriesIds.toList());
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

  _getFlightcategoriesMultiSelectDropDown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomWidgets().buildDropdown(
          label: 'Select Flight categories',
          items: _flightCategoryList
              .map((e) => SelectionHelper(
                  e, selectedFlightCategoriesIds.contains(e.flightCategoryId)))
              .toList()
              .map((e) => DropdownMenuItem<String>(
                    child: StatefulBuilder(
                      builder: (context, innerState) {
                        return CheckboxListTile(
                          title: Text(e.data.category ?? ''),
                          onChanged: (v) {
                            innerState(() {
                              e.isSelected = !e.isSelected;
                            });
                            if (e.isSelected) {
                              selectedFlightCategoriesIds
                                  .add(e.data.flightCategoryId!);
                            } else if (!e.isSelected) {
                              selectedFlightCategoriesIds
                                  .remove(e.data.flightCategoryId);
                            }
                            setState(() {});
                          },
                          value: e.isSelected,
                        );
                      },
                    ),
                    value: e.data.category,
                  ))
              .toList(),
          onChanged: (val) {}),
    );
  }

  getSelectableFlightDropDownMenuField({
    List<CompanyProfileFlightCategory>? items,
    String? labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(spacing10),
      child: Expanded(
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: labelText,
          ),
          items: items!
              .map((fligthCategory) =>
                  DropdownMenuItem<CompanyProfileFlightCategory>(
                      value: fligthCategory,
                      child: Text(
                        fligthCategory.flightCategory!.category!,
                      )))
              .toList(),
          onChanged: (CompanyProfileFlightCategory? flightCategory) {
            //updateObj = newObject.copyWith(bdm: [bdm!]);
          },
        ),
      ),
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
                selectedFlightCategoriesIds.remove(id);
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
