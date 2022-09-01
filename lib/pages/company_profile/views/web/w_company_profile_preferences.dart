import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/company_profile/bloc/prefrence/prefrence_bloc.dart';

class WCompanyProfilePreferences extends StatefulWidget {
  const WCompanyProfilePreferences({Key? key, required this.companyProfile})
      : super(key: key);
  final CompanyProfile companyProfile;

  @override
  State<WCompanyProfilePreferences> createState() =>
      _WCompanyProfilePreferencesState();
}

class _WCompanyProfilePreferencesState
    extends State<WCompanyProfilePreferences> {
  List<String> sections = [
    'Services',
    'Country',
    'Airports',
    'Flight Category',
    'Purposes',
    'Equipment',
  ];

  ScrollController mainListController = ScrollController();
  List<String> tableColumns = ['Priority', 'Notes'];
  List<double> tableColumnsWidth = [100, 0];

  bool editBool = false;
  var updateObj;

  List<Prefrence>? _prefrencesList;

  @override
  void initState() {
    super.initState();
    context.read<PrefrenceBloc>().add(FetchPrefrenceEvent(
        customerId: widget.companyProfile.organizationId, page: 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrefrenceBloc, PrefrenceState>(
      listener: (context, state) {},
      child: BlocBuilder<PrefrenceBloc, PrefrenceState>(
        builder: (context, state) {
          if (state.status == PrefrenceListStatus.loading ||
              state.status == PrefrenceListStatus.initial) {
            return loadingWidget();
          }
          if (state.status == PrefrenceListStatus.success) {
            _prefrencesList = state.prefrences;
          }
          if (_prefrencesList == null || _prefrencesList!.isEmpty) {
            return noDataFoundWidget();
          }
          _prefrencesList!.sort((a, b) {
            return a.priority.toLowerCase().compareTo(b.priority.toLowerCase());
          });
          List<List<Widget>> rows = [];
          log("Preferences: " + _prefrencesList.toString());
          for (var val in _prefrencesList!) {
            rows.add([
              appText(val.priority, color: AppColors.charcoalGrey),
              appText(val.notes ?? "", color: AppColors.charcoalGrey),
            ]);
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                CmsTableHeader(
                  columns: tableColumns,
                  columnsWidth: tableColumnsWidth,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: rows.length,
                    itemBuilder: (BuildContext context, int index) {
                      Widget actions = Container();
                      Widget expWidget = Container(
                        padding: const EdgeInsets.all(8.0),
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
                        child: Container(
                          width: double.infinity,
                          color: AppColors.paleGrey,
                          child: Wrap(direction: Axis.horizontal, children: [
                            _buildSectionWidget(
                              section:
                                  _prefrencesList![index].servicesData ?? [],
                              sectionIndex: 0,
                            ),
                            _buildSectionWidget(
                              section:
                                  _prefrencesList![index].countryData ?? [],
                              sectionIndex: 1,
                            ),
                            _prefrencesList![index].countryWithAirport != null
                                ? _buildSectionWidget(
                                    section: _prefrencesList![index]
                                        .countryWithAirport!
                                        .map((e) => e.airports!
                                            .map((i) => i.name)
                                            .toString())
                                        .toList(),
                                    sectionIndex: 2,
                                  )
                                : Container(),
                            _buildSectionWidget(
                              section:
                                  _prefrencesList![index].flightCategoryData ??
                                      [],
                              sectionIndex: 3,
                            ),
                            _buildSectionWidget(
                              section:
                                  _prefrencesList![index].flightPurpusesData ??
                                      [],
                              sectionIndex: 4,
                            ),
                            _buildSectionWidget(
                              section:
                                  _prefrencesList![index].equipmentsData ?? [],
                              sectionIndex: 5,
                            ),
                          ]),
                        ),
                      );
                      return CmsTableRow(
                        isExpandable: true,
                        expandedWidget: expWidget,
                        editBool: false,
                        actions: actions,
                        columns: tableColumns,
                        columnsWidth: tableColumnsWidth,
                        row: rows[index],
                        itemIndex: index,
                        onTapAction: () {},
                      );
                    }),
                CmsTableFooter(
                  columnsWidth: tableColumnsWidth,
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionWidget(
      {required List<String> section, required int sectionIndex}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: appText(
              sections[sectionIndex],
              color: AppColors.charcoalGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
              height: 246,
              width: 214,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: AppColors.powderBlue,
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, ind) => const Divider(
                          color: AppColors.charcoalGrey,
                        ),
                        itemCount: section.length,
                        itemBuilder: (context, ind) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: appText(
                            section[ind].toString(),
                            color: AppColors.charcoalGrey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ]),
              )),
        ],
      ),
    );
  }
}
