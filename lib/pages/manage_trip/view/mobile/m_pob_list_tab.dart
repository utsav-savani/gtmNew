// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_state.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_partials/m_pob_detail_widget.dart';
import 'package:gtm/pages/widgets/trip_accordion.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class MPobListTab extends StatefulWidget {
  final String guid;
  const MPobListTab({Key? key, required this.guid}) : super(key: key);

  @override
  State<MPobListTab> createState() => _MPobListTabState();
}

class _MPobListTabState extends State<MPobListTab> {
  @override
  void didChangeDependencies() {
    fetchPOBList(widget.guid);
    super.didChangeDependencies();
  }

  fetchPOBList(String guid) {
    POBListBloc pobListBloc = BlocProvider.of<POBListBloc>(context);
    pobListBloc.add(FetchPOBList(guid: guid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 124,
          child: BlocBuilder<POBListBloc, POBListState>(
            builder: (context, listState) {
              switch (listState.status) {
                case FetchPOBListState.initial:
                case FetchPOBListState.loading:
                  return loadingWidget();
                case FetchPOBListState.success:
                  return _buildPOBList(listState.tripPOBListSchedule!.persons);
                case FetchPOBListState.failure:
                  return noDataFoundWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  _buildPOBList(List<TripPobSchedule> tripPOBListSchedule) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tripPOBListSchedule.length,
      itemBuilder: (BuildContext context, int index) {
        TripPobSchedule item = tripPOBListSchedule[index];
        if (item.tripsequenceNumber.toString().trim() == "") return Container();
        if (item.destinationpointwithicaoiata == null ||
            item.destinationpointwithicaoiata == "") return Container();
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: TripAccordion(
            visualDensity: -3,
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item.destinationpointwithicaoiata}",
                  style: const TextStyle(color: AppColors.whiteColor),
                ),
                width(8),
                Column(
                  children: [
                    if (item.eTa != null)
                      Row(
                        children: [
                          svgToIcon(
                            appImagesName: AppImages.arrivalIcon,
                            color: AppColors.whiteColor,
                          ),
                          width(4),
                          Text(
                            convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                              "${item.eTD}",
                            ),
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: spacing13,
                            ),
                          ),
                        ],
                      ),
                    if (item.eTD != null)
                      Row(
                        children: [
                          svgToIcon(
                            appImagesName: AppImages.departureIcon,
                            color: AppColors.whiteColor,
                          ),
                          width(4),
                          Text(
                            convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                              "${item.eTD}",
                            ),
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: spacing13,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
            listTileColor: AppColors.deepLavender,
            titleColor: AppColors.whiteColor,
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.paleGrey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: _buildPOBDetailedWidget(item),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPOBDetailedWidget(TripPobSchedule pobSchedule) {
    List<TripPobScheduleDetail>? _persons = pobSchedule.pobLists;
    if (_persons == null || _persons.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8),
          child: noDataFoundWidget(text: "No Data Found"),
        ),
      );
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _persons.length,
      itemBuilder: (BuildContext context, int index) {
        TripPobScheduleDetail item = _persons[index];
        String _fullName =
            "${item.firstName.toString().camelCase()} ${item.lastName.toString().camelCase()}";
        String? _type;
        if (item.type.toString().toUpperCase() == "CAPTAIN") _type = "CAPT";
        if (item.type.toString().toUpperCase() == "PASSENGER") _type = "PAX";
        if (item.type.toString().toUpperCase() == "CREW") _type = "CREW";
        return InkWell(
          onTap: () => _pobDetailWidgetModal(item.personId!),
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: spacing40,
                    child: _buildPOBDetailedInnerWidget(
                      title: "Type",
                      value: "$_type",
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - spacing224,
                    child: _buildPOBDetailedInnerWidget(
                      title: "Name",
                      value: _fullName,
                    ),
                  ),
                  SizedBox(
                    width: spacing88,
                    child: _buildPOBDetailedInnerWidget(
                      title: "Passport",
                      value:
                          "${item.nationalityISOCode ?? ''} ${item.passportNumber ?? ''}",
                    ),
                  ),
                  if (item.dob != null && item.dob != "" && item.dob != "null")
                    SizedBox(
                      width: spacing72,
                      child: _buildPOBDetailedInnerWidget(
                        title: "DOB",
                        value: convertDateYYYYMMDDStringToHumanReadableFormat(
                          item.dob ?? '',
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPOBDetailedInnerWidget({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(title, fontSize: 12),
        height(2),
        SizedBox(
          height: 20,
          child: Text(
            "$value",
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _pobDetailWidgetModal(int personId) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return POBDetailWidget(personId: personId);
      },
    );
  }
}
