// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gtm/_shared/libraries/app_alert.dart';
import 'package:gtm/_shared/libraries/app_loader.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/row_stripped_widget.dart';
import 'package:gtm/_shared/widgets/section_header_widget.dart';
import 'package:gtm/pages/widgets/trip_accordion.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class MReviewSubmitTab extends StatefulWidget {
  final TabController? tabController;
  final String guid;

  const MReviewSubmitTab({
    this.tabController,
    required this.guid,
    Key? key,
  }) : super(key: key);

  @override
  State<MReviewSubmitTab> createState() => _MReviewSubmitTabState();
}

class _MReviewSubmitTabState extends State<MReviewSubmitTab> {
  bool _isLoading = false;

  late TripManagerReview _tripManagerReview;
  late String _guid;

  late bool _isWeb;

  @override
  void initState() {
    _guid = widget.guid;
    _getTripReviewDetails();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _getTripReviewDetails() async {
    _isLoading = true;
    _tripManagerReview =
        await TripManagerReviewRepository().getTripReviewDetails(guid: _guid);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _guid = widget.guid;
    _isWeb = MediaQuery.of(context).size.width >= web;
    if (_isLoading) return loadingWidget();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              children: [
                SectionHeaderWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Trip Info Summary',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildTripInfoSummaryWidget(),
              ],
            ),
          ),
          height(10),
          Card(
            child: Column(
              children: [
                SectionHeaderWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text(
                          'Schedule Summary',
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                _scheduleSummaryWidget(context),
              ],
            ),
          ),
          height(10),
          Card(
            child: Column(
              children: [
                SectionHeaderWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text(
                          'Service Summary',
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                _serviceSummaryWidget(context),
              ],
            ),
          ),
          height(10),
          Card(
            child: Column(
              children: [
                SectionHeaderWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text(
                          'POB Summary',
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                _pobDetailsWidget(context),
              ],
            ),
          ),
          height(10),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              AppLoader(context).show(
                title: 'Saving Trip Details...',
              );
              try {
                bool res = await TripManagerReviewRepository()
                    .saveTripDetails(guid: _guid);
                AppLoader(context).hide();
                if (res) {
                  AppAlert.show(
                    context,
                    title: "Success",
                    body: "The data saved successfully",
                    buttonText: "Okay",
                  );
                }
              } catch (e) {
                //print(e);
              }
            },
          ),
          height(40),
        ],
      ),
    );
  }

  Widget _scheduleSummaryWidget(BuildContext context) {
    return Column(
        children:
            List.generate(_tripManagerReview.flightDetails.length, (index) {
      TripReviewFlightDetail _flightDetail =
          _tripManagerReview.flightDetails[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Material(
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: TripAccordion(
            visualDensity: -3,
            titleWidget: Text(
                '${_flightDetail.depApt ?? ''} / ${_flightDetail.arrApt ?? ''}'),
            eta: _flightDetail.eta ?? '',
            listTileColor: AppColors.deepLavender,
            titleColor: AppColors.whiteColor,
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(children: [
                Container(
                  height: 42,
                  decoration: const BoxDecoration(
                    color: AppColors.paleGrey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      width(10),
                      if (_flightDetail.depApt != null)
                        svgToIcon(
                          appImagesName: AppImages.departureIcon,
                          width: 34,
                          height: 24,
                          color: AppColors.blueGrey,
                        ),
                      if (_flightDetail.depApt != null) width(5),
                      if (_flightDetail.depApt != null)
                        Text(_flightDetail.depApt!),
                      if (_flightDetail.depApt != null) width(5),
                      if (_flightDetail.arrApt != null)
                        svgToIcon(
                          height: 24,
                          width: 34,
                          appImagesName: AppImages.arrivalIcon,
                          color: AppColors.blueGrey,
                        ),
                      if (_flightDetail.arrApt != null) width(5),
                      if (_flightDetail.arrApt != null)
                        Text(_flightDetail.arrApt!),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            if (_flightDetail.etd != null)
                              Row(
                                children: [
                                  _buildLabel('ETD(Z)', width: 60),
                                  Text(
                                    convertDateTimeStringToHumanReadableFormat(
                                      _flightDetail.etd!,
                                    ),
                                  )
                                ],
                              ),
                            if (_flightDetail.eta != null)
                              Row(
                                children: [
                                  _buildLabel('ETA(Z)', width: 60),
                                  Text(
                                    convertDateTimeStringToHumanReadableFormat(
                                      _flightDetail.eta!,
                                    ),
                                  )
                                ],
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          children: [
                            _buildLabel('Purpose'),
                            Text("${_flightDetail.purpose}")
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          _buildLabel('CallSign'),
                          Text("${_flightDetail.callSign}"),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      _buildLabel('Flight Category'),
                      Text("${_flightDetail.flightCategory}")
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    }));
  }

  Widget _serviceSummaryWidget(BuildContext context) {
    List<TripReviewCurrentServiceSummary> _currentServiceSummary =
        _tripManagerReview.currentServiceSummary;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _currentServiceSummary.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _currentServiceSummary[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Sector ${item.index}"),
            ),
            _buildServiceDetailedWidget(item),
          ],
        );
      },
    );
  }

  Widget _buildServiceDetailedWidget(
      TripReviewCurrentServiceSummary currentServiceSummary) {
    return Column(
      children: [
        TripAccordion(
          visualDensity: -3,
          titleWidget: Text(
            '${currentServiceSummary.departure ?? ''} / ${currentServiceSummary.arrival ?? ''}',
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
                child: _buildCurrentSummaryServices(currentServiceSummary),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentSummaryServices(
      TripReviewCurrentServiceSummary currentServiceSummary) {
    if (currentServiceSummary.serviceDetails == null ||
        currentServiceSummary.serviceDetails!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8),
        child: noDataFoundWidget(text: "No Service Found"),
      );
    }
    List<TripReviewCurrentServiceDetail> _serviceDetails =
        currentServiceSummary.serviceDetails!;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _serviceDetails.length,
      itemBuilder: (BuildContext context, int index) {
        TripReviewCurrentServiceDetail item = _serviceDetails[index];
        String _arrDepOvf = "DEP";
        String? _icon = AppImages.departureIcon;
        if (item.on == "ARR") {
          _icon = AppImages.arrivalIcon;
          _arrDepOvf = "ARR";
        }
        if (item.on == "OVF") {
          _icon = null;
          _arrDepOvf = "OVF";
        }
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Column(
                  children: [
                    label("SEQ"),
                    label("${item.seq}"),
                  ],
                ),
                width(12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${item.serviceType}"),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.sky,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22.0,
                                vertical: 4,
                              ),
                              child: Text(
                                _arrDepOvf,
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      height(4),
                      Row(
                        children: [
                          Row(
                            children: [
                              if (_icon != null)
                                svgToIcon(
                                  appImagesName: _icon,
                                  color: AppColors.blueGrey,
                                  width: 24,
                                  height: 20,
                                ),
                              width(4),
                              label("${item.location}"),
                            ],
                          ),
                          width(20),
                          Column(
                            children: [
                              Text(
                                "Through",
                                style: TextStyle(color: AppColors.powderBlue),
                              ),
                              Text("${item.through}"),
                            ],
                          ),
                          width(20),
                          Column(
                            children: [
                              Text(
                                "Payment",
                                style: TextStyle(color: AppColors.powderBlue),
                              ),
                              Text("${item.payment}"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _pobDetailsWidget(BuildContext context) {
    List<TripReviewCurrentPOBDetail> _currentPOBDetails =
        _tripManagerReview.currentPOBDetails;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _currentPOBDetails.length,
      itemBuilder: (BuildContext context, int index) {
        TripReviewCurrentPOBDetail item = _currentPOBDetails[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.marineBlue.withOpacity(0.12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    label("${item.tripsequenceNumber}. "),
                    if (item.depApt != null)
                      Expanded(
                        child: label("${item.depApt}"),
                      ),
                    Spacer(),
                    label(
                      convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                        "${item.etd}",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildPOBDetailedWidget(item),
          ],
        );
      },
    );
  }

  Widget _buildPOBDetailedWidget(TripReviewCurrentPOBDetail pobDetail) {
    if (pobDetail.pobDetails == null || pobDetail.pobDetails!.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8),
          child: noDataFoundWidget(text: "No Data Found"),
        ),
      );
    }
    List<TripReviewCurrentPOBDetailedDetail> _personDetail =
        pobDetail.pobDetails!;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _personDetail.length,
      itemBuilder: (BuildContext context, int index) {
        TripReviewCurrentPOBDetailedDetail item = _personDetail[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5.6,
                  child: _buildPOBDetailedInnerWidget(
                    title: "Type",
                    value: "${item.type}",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: _buildPOBDetailedInnerWidget(
                    title: "Given Name",
                    value: "${item.givenName}",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5.8,
                  child: _buildPOBDetailedInnerWidget(
                    title: "Nationality",
                    value: "${item.nationality}",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5.4,
                  child: _buildPOBDetailedInnerWidget(
                    title: "Passport",
                    value: "${item.passport}",
                  ),
                ),
                if (item.dob != null)
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5.4,
                    child: _buildPOBDetailedInnerWidget(
                      title: "DOB",
                      value: convertDateYYYYMMDDStringToHumanReadableFormat(
                        "${item.dob}",
                      ),
                    ),
                  ),
              ],
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
        label(title),
        Text(value),
      ],
    );
  }

  Widget _buildLabel(str, {double? width}) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.2,
      child: label(str),
    );
  }

  // _buildEditBox(manageTripTab, index) {
  //   return InkWell(
  //       child: Container(
  //         alignment: Alignment.center,
  //         width: manageTripEditBoxWidth,
  //         child: appText('Edit', color: AppColors.highLightText),
  //       ),
  //       onTap: () {
  //         widget.tabController!.animateTo(index);
  //       });
  // }

  // _buildScheduleSectionTable(List<dynamic> list) {
  //   return Column(
  //     children: <Widget>[
  //       Container(
  //         height: tableCellHeight * webMobileHeightMultiplier,
  //         alignment: Alignment.centerLeft,
  //         color: AppColors.tableSearchBarColor,
  //         child: Row(
  //           children: <Widget>[
  //             _buildTableMainHeaderCellWidget("DEPT"),
  //             _buildTableMainHeaderCellWidget("ARR"),
  //             _buildTableMainHeaderCellWidget("CALLSIGN"),
  //             _buildTableMainHeaderCellWidget("FLIGHT CATEGORY"),
  //             _buildTableMainHeaderCellWidget("PURPOSE"),
  //             _buildTableMainHeaderCellWidget("ETD"),
  //             _buildTableMainHeaderCellWidget("ETA"),
  //           ],
  //         ),
  //       ),
  //       list.isEmpty
  //           ? noData()
  //           : ListView.builder(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: list.length,
  //               itemBuilder: (context, index) {
  //                 final item = list[index];
  //                 return Container(
  //                   height: _isWeb
  //                       ? tableCellHeight
  //                       : tableCellHeight * webMobileHeightMultiplier,
  //                   alignment: Alignment.centerLeft,
  //                   padding: const EdgeInsets.all(0),
  //                   child: Row(
  //                     children: [
  //                       _buildTableCellWidget(
  //                         "${item.depApt}",
  //                         index,
  //                         Alignment.centerLeft,
  //                       ),
  //                       _buildTableCellWidget(
  //                           "${item.arrApt}", index, Alignment.center),
  //                       _buildTableCellWidget(
  //                         "${item.callSign}",
  //                         index,
  //                         Alignment.centerLeft,
  //                       ),
  //                       _buildTableCellWidget(
  //                         "${item.flightCategory}",
  //                         index,
  //                         Alignment.centerLeft,
  //                       ),
  //                       _buildTableCellWidget(
  //                         "${item.purpose}",
  //                         index,
  //                         Alignment.centerLeft,
  //                       ),
  //                       _buildTableCellWidget(
  //                         "${item.etd}",
  //                         index,
  //                         Alignment.centerLeft,
  //                       ),
  //                       _buildTableCellWidget(
  //                         "${item.eta}",
  //                         index,
  //                         Alignment.centerLeft,
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //     ],
  //   );
  // }

  _buildServicesSectionTable(List<dynamic> list) {
    return Column(
      children: [
        Container(
          height: tableCellHeight,
          alignment: Alignment.centerLeft,
          color: AppColors.tableSearchBarColor,
          child: Row(
            children: [
              _buildTableMainHeaderCellWidget("Service Type"),
              _buildTableMainHeaderCellWidget("SEQ"),
              _buildTableMainHeaderCellWidget("Location"),
              _buildTableMainHeaderCellWidget("ON"),
              _buildTableMainHeaderCellWidget("PYMT"),
              _buildTableMainHeaderCellWidget("THRU"),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(0),
          alignment: Alignment.centerLeft,
          child: list.isEmpty
              ? noData()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final sector = list[index];
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: tableCellHeight,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: <Widget>[
                                    _buildTableSubHeaderCellWidget(
                                        "Sector ${sector.index}: ${sector.departure} - ${sector.arrival} "),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(0),
                                alignment: Alignment.centerLeft,
                                child: sector.serviceDetails.isEmpty
                                    ? noData()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: sector.serviceDetails.length,
                                        itemBuilder: (context, index) {
                                          final item =
                                              sector.serviceDetails[index];
                                          return Container(
                                            height: tableCellHeight,
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.all(0),
                                            child: Row(
                                              children: [
                                                _buildTableCellWidget(
                                                    "${item.serviceType}",
                                                    index,
                                                    Alignment.centerLeft),
                                                _buildTableCellWidget(
                                                    "${item.seq}",
                                                    index,
                                                    Alignment.center),
                                                _buildTableCellWidget(
                                                    "${item.location}",
                                                    index,
                                                    Alignment.centerLeft),
                                                _buildTableCellWidget(
                                                    "${item.on}",
                                                    index,
                                                    Alignment.centerLeft),
                                                _buildTableCellWidget(
                                                    "${item.payment}",
                                                    index,
                                                    Alignment.centerLeft),
                                                _buildTableCellWidget(
                                                    "${item.through}",
                                                    index,
                                                    Alignment.centerLeft),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  // _buildPOBSectionTable(List<dynamic> list) {
  //   return Container(
  //     alignment: Alignment.centerLeft,
  //     child: list.isEmpty
  //         ? noData()
  //         : ListView.builder(
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemCount: list.length,
  //             itemBuilder: (context, index) {
  //               final sector = list[index];
  //               return Column(
  //                 children: [
  //                   Container(
  //                     height: _isWeb
  //                         ? tableCellHeight
  //                         : tableCellHeight * webMobileHeightMultiplier,
  //                     alignment: Alignment.centerLeft,
  //                     color: AppColors.tableSearchBarColor,
  //                     child: Row(
  //                       children: [
  //                         _buildTableMainHeaderCellWidget("DEPARTING: "),
  //                         _buildTableMainHeaderCellWidget("${sector.depApt}"),
  //                         _buildTableMainHeaderCellWidget("ETD: "),
  //                         _buildTableMainHeaderCellWidget("${sector.etd}"),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     alignment: Alignment.centerLeft,
  //                     child: Column(
  //                       children: <Widget>[
  //                         Container(
  //                           height: tableCellHeight,
  //                           alignment: Alignment.centerLeft,
  //                           child: Row(
  //                             children: <Widget>[
  //                               _buildTableSubHeaderCellWidget("Name"),
  //                               _buildTableSubHeaderCellWidget("DOB"),
  //                               _buildTableSubHeaderCellWidget("Passport"),
  //                               _buildTableSubHeaderCellWidget("Nationality"),
  //                               _buildTableSubHeaderCellWidget("Type"),
  //                             ],
  //                           ),
  //                         ),
  //                         Container(
  //                           padding: const EdgeInsets.all(0),
  //                           alignment: Alignment.centerLeft,
  //                           child: sector.pobDetails.isEmpty
  //                               ? noData()
  //                               : ListView.builder(
  //                                   shrinkWrap: true,
  //                                   physics:
  //                                       const NeverScrollableScrollPhysics(),
  //                                   itemCount: sector.pobDetails.length,
  //                                   itemBuilder: (context, index) {
  //                                     final item = sector.pobDetails[index];
  //                                     return Container(
  //                                       height: tableCellHeight,
  //                                       alignment: Alignment.centerLeft,
  //                                       padding: const EdgeInsets.all(0),
  //                                       child: Row(
  //                                         children: [
  //                                           _buildTableCellWidget(
  //                                               "${item.surName} ${item.givenName}",
  //                                               index,
  //                                               Alignment.centerLeft),
  //                                           _buildTableCellWidget("${item.dob}",
  //                                               index, Alignment.center),
  //                                           _buildTableCellWidget(
  //                                               "${item.passport}",
  //                                               index,
  //                                               Alignment.centerLeft),
  //                                           _buildTableCellWidget(
  //                                               "${item.nationality}",
  //                                               index,
  //                                               Alignment.centerLeft),
  //                                           _buildTableCellWidget(
  //                                               "${item.type}",
  //                                               index,
  //                                               Alignment.centerLeft),
  //                                         ],
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             },
  //           ),
  //   );
  // }

  // _buildTitleBox(String title) {
  //   return Container(
  //     height: reviewSubmiTitleBoxHeight,
  //     padding: const EdgeInsets.only(top: 8),
  //     alignment: Alignment.centerLeft,
  //     child: Text(title),
  //   );
  // }

  _buildTableMainHeaderCellWidget(String title) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        height: _isWeb
            ? tableCellHeight
            : tableCellHeight * webMobileHeightMultiplier,
        padding: const EdgeInsets.all(8),
        child: appText(
          title,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildTableSubHeaderCellWidget(String title) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        height: tableCellHeight,
        padding: const EdgeInsets.all(8),
        child: appText(
          title,
          color: AppColors.charcoalGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildTableCellWidget(String contentText, int index, Alignment align) {
    var cellColor =
        (index % 2 != 0) ? AppColors.greyRowOdd : AppColors.greyRowEven;
    return Expanded(
      child: Container(
        alignment: align,
        height: _isWeb
            ? tableCellHeight
            : tableCellHeight * webMobileHeightMultiplier,
        padding: const EdgeInsets.all(8),
        child: appText(contentText, color: AppColors.charcoalGrey),
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(width: 1.0, color: AppColors.blueGrey),
          ),
          color: cellColor,
        ),
      ),
    );
  }

  noData() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: appText(
          'No Data!',
          color: AppColors.blackColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildTripInfoSummaryWidget() {
    String _subreg = "";
    for (TripReviewSubaircraft item in _tripManagerReview.subAircrafts) {
      if (_subreg != "") {
        _subreg = "$_subreg, ${item.name}";
      } else {
        _subreg = "$_subreg ${item.name}";
      }
    }

    return Column(children: [
      RowStrippedWidget(
        title: 'Trip No.',
        details: "${_tripManagerReview.tripNumber}".camelCase(),
        isLight: false,
      ),
      RowStrippedWidget(
        title: 'Customer',
        details: "${_tripManagerReview.customer}".camelCase(),
      ),
      RowStrippedWidget(
        title: 'Operator',
        details: "${_tripManagerReview.operator}".camelCase(),
        isLight: false,
      ),
      RowStrippedWidget(
        title: 'A/C Type',
        details: "${_tripManagerReview.acType}",
      ),
      RowStrippedWidget(
        title: 'A/C Reg',
        details: "${_tripManagerReview.acReg}",
        isLight: false,
      ),
      RowStrippedWidget(
        title: 'Sub Reg',
        details: _subreg,
        isLight: false,
      ),
      RowStrippedWidget(
        title: 'Created By',
        details: "${_tripManagerReview.createdBy}",
      ),
      RowStrippedWidget(
        title: 'Requested',
        details: "${_tripManagerReview.requested}",
        isLight: false,
      ),
      RowStrippedWidget(
        title: 'Reference',
        details: "${_tripManagerReview.reference}",
        isLight: false,
      ),
    ]);
  }
}
