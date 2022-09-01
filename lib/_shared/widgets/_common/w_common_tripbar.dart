import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/w_dashboard.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class CommonTripBar extends StatefulWidget {
  const CommonTripBar({
    Key? key,
    required this.tripDetail,
    required this.onHeaderVisibilityChange,
  }) : super(key: key);
  final TripDetail tripDetail;
  final BoolCallback onHeaderVisibilityChange;

  @override
  State<CommonTripBar> createState() => _CommonTripBarState();
}

class _CommonTripBarState extends State<CommonTripBar> {
  late double mainWidgetHeight,
      mainWidgetWidth,
      menuItemHeight,
      menuItemWidth,
      sidePanelWidth;
  late Size windowSize;
  bool showHeader = true;

  final ribbonColor = AppColors.paleGrey;

  bool _customerOperator = true;

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    windowSize = MediaQuery.of(context).size;
    menuItemHeight = sidebarOpen ? openPanelItemHeight : closedPanelItemHeight;
    menuItemWidth = sidebarOpen ? openPanelWidth : closedPanelWidth;

    sidePanelWidth = menuItemWidth;
    mainWidgetWidth = windowSize.width - sidePanelWidth;

    return Container(
      color: ribbonColor,
      alignment: Alignment.centerLeft,
      height: tripDataRibbonHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: showHeader,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: showHeader ? tripDataRibbonHeight : 0,
                  decoration: BoxDecoration(
                    color: ribbonColor,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Trip
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: ribbonFormElementHeight,
                              width: ribbonFormElementShort,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(ribbonTextPadding),
                              decoration: _boxDecoration(),
                              child: appText(widget.tripDetail.tripNumber ?? '',
                                  color: AppColors.charcoalGrey),
                            ),
                            Positioned(
                              left: 10,
                              top: -10,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                color: ribbonColor,
                                child: appText(tripId, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Customer/Operator
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: ribbonFormElementHeight,
                              width: ribbonFormElementLong,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(ribbonTextPadding),
                              decoration: _boxDecoration(),
                              child: appText(
                                  _customerOperator
                                      ? widget.tripDetail.customerName ?? ''
                                      : widget.tripDetail.operatorName ?? '',
                                  color: AppColors.charcoalGrey),
                            ),
                            Positioned(
                              left: 10,
                              top: -10,
                              child: InkWell(
                                onTap: () {
                                  _customerOperator = true;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  child: appText(customer, fontSize: 12),
                                  decoration: BoxDecoration(
                                    color: ribbonColor,
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: _customerOperator
                                            ? AppColors.deepLilac
                                            : ribbonColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: -10,
                              child: InkWell(
                                onTap: () {
                                  _customerOperator = false;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  child: appText("Operator", fontSize: 12),
                                  decoration: BoxDecoration(
                                    color: ribbonColor,
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: _customerOperator
                                            ? ribbonColor
                                            : AppColors.deepLilac,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Primary AC/ Subtitutes
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Row(
                              children: [
                                _buildCustomTextField(
                                    value: (widget.tripDetail.primaryAircraft
                                            ?.registrationNumber) ??
                                        ''),
                                Container(
                                  height: ribbonFormElementHeight,
                                  width: ribbonFormElementShort,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ribbonTextPadding,
                                    vertical: spacing6,
                                  ),
                                  decoration: _boxDecoration(),
                                  child: _buildSubAircraftWidget(
                                    aircrafts:
                                        widget.tripDetail.childAircraft ?? [],
                                  ),
                                ),
                              ],
                            ),
                            _buildLabel(text: primaryAC),
                            _buildLabel(
                              text: subsituteAc,
                              left: ribbonFormElementShort + 10,
                            ),
                          ],
                        ),
                      ),

                      // Trip/File Status
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Row(
                              children: [
                                _buildCustomTextField(
                                  value: widget.tripDetail.tripStatus ?? '',
                                ),
                                _buildCustomTextField(
                                  value: widget.tripDetail.fileStatus ?? '',
                                ),
                              ],
                            ),
                            _buildLabel(text: tripStatus),
                            _buildLabel(
                              text: fileStatus,
                              left: ribbonFormElementShort + 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel({required String text, double? left, double? top}) {
    return Positioned(
      left: left ?? 10,
      top: top ?? -10,
      child: Container(
        padding: const EdgeInsets.all(2),
        child: appText(text, fontSize: 12),
        decoration: BoxDecoration(
          color: ribbonColor,
        ),
      ),
    );
  }

  Widget _buildCustomTextField({required String value}) {
    return Container(
      height: ribbonFormElementHeight,
      width: ribbonFormElementShort,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(ribbonTextPadding),
      decoration: _boxDecoration(),
      child: appText(
        value,
        color: AppColors.charcoalGrey,
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(formItemCorner),
      border: Border.all(
        width: 2,
        color: AppColors.lightBlueGrey,
      ),
    );
  }

  Widget _buildSubAircraftWidget({required List<PrimaryAircraft> aircrafts}) {
    return ListView(
      shrinkWrap: true,
      children: [
        Wrap(
          direction: Axis.vertical,
          children: aircrafts.map((i) => Text(i.registrationNumber)).toList(),
        ),
      ],
    );
  }
}

class SelectionHelper<T> {
  T data;
  bool isSelected;

  SelectionHelper(this.data, this.isSelected);
}

class SubAircraftSelectionHelper<T> {
  T? selected;
  List<T> items;

  SubAircraftSelectionHelper({this.selected, this.items = const []});
}
