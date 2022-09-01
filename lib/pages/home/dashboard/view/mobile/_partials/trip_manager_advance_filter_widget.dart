import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/_mobile/back_icon_section_widget.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_bloc.dart';
import 'package:gtm/pages/home/dashboard/dashboard_event.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PeriodFilter {
  final String name;
  final String shortname;
  PeriodFilter({required this.name, required this.shortname});
}

class TripManagerAdvanceFilterWidget extends StatefulWidget {
  const TripManagerAdvanceFilterWidget({Key? key}) : super(key: key);

  @override
  State<TripManagerAdvanceFilterWidget> createState() =>
      _TripManagerAdvanceFilterWidgetState();
}

class _TripManagerAdvanceFilterWidgetState
    extends State<TripManagerAdvanceFilterWidget> {
  bool _showDateRangePicker = false;
  SearchBy _selectedSearchBy = SearchBy.schedule;

  PeriodFilter? _selectedPeriodFilter;
  PickerDateRange? _initialSelectedRange;
  String? _fromDate;
  String? _toDate;

  final List<PeriodFilter> _periodList = [
    PeriodFilter(name: "Today", shortname: "TODAY"),
    PeriodFilter(name: "Yesterday", shortname: "YESTERDAY"),
    PeriodFilter(name: "Next 7 days", shortname: "NEXT7DAYS"),
    PeriodFilter(name: "Next 30 days", shortname: "NEXT30DAYS"),
    PeriodFilter(name: "Current Month", shortname: "CURRENTMONTH"),
    PeriodFilter(name: "Previous Month", shortname: "PREVIOUSMONTH"),
  ];

  final TextEditingController _dateRangeTextEditingController =
      TextEditingController();
  late TripBloc _tripBloc;
  late TripStatisticBloc _tripStatisticBloc;

  @override
  void didChangeDependencies() {
    _tripBloc = BlocProvider.of(context);
    _tripStatisticBloc = BlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 112,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Align(
            alignment: Alignment.centerLeft,
            child: BackIconSectionWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      appText("Search By:"),
                      width(8),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: SearchBy.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = SearchBy.values[index];
                          return _buildSearchByWidget(
                            title: item.name,
                            isActive: item == _selectedSearchBy,
                            shortname: item,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                height(12),
                Row(
                  children: [
                    appText("Select Date:"),
                    width(16),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: _dateRangeTextEditingController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: "Select Date",
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          onTap: () {
                            _showDateRangePicker = true;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                height(12),
                Row(
                  children: [
                    appText("Select Period:"),
                    width(8),
                    SizedBox(
                      width: 160,
                      height: 36,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.lightBlue,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<PeriodFilter>(
                            hint: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Period",
                                style: TextStyle(
                                  color: AppColors.blueGrey,
                                ),
                              ),
                            ),
                            items: _periodList
                                .map<DropdownMenuItem<PeriodFilter>>(
                                    (PeriodFilter value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: appText(
                                    value.name,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                            isDense: true,
                            onChanged: (PeriodFilter? selectedItem) =>
                                _syncPeriodSelection(selectedItem),
                            value: _selectedPeriodFilter,
                          ),
                        ),
                      ),
                    ),
                    width(20),
                    InkWell(
                      onTap: () => _filterButtonTriggered(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: appText("Search", color: AppColors.defaultColor),
                      ),
                    ),
                  ],
                ),
                height(12),
                InkWell(
                  onTap: () => _resetButtonTriggered(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: appText("Reset", color: AppColors.blueColor),
                  ),
                ),
              ],
            ),
          ),
          if (_showDateRangePicker)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: AppColors.brownGrey,
                    offset: Offset(0, 0.2),
                  )
                ],
              ),
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                enableMultiView: true,
                viewSpacing: 20,
                showActionButtons: true,
                selectionShape: DateRangePickerSelectionShape.rectangle,
                headerStyle: const DateRangePickerHeaderStyle(
                  textAlign: TextAlign.left,
                ),
                initialSelectedRange: _initialSelectedRange,
                onSubmit: (val) => _syncDateSelection(val as PickerDateRange),
                onCancel: () {
                  _showDateRangePicker = false;
                  setState(() {});
                },
              ),
            ),
        ],
      ),
    );
  }

  void _filterButtonTriggered() {
    DateTime? fromDate;
    if (_fromDate != null) fromDate = DateTime.parse(_fromDate!);
    DateTime? toDate;
    if (_toDate != null) toDate = DateTime.parse(_toDate!);

    FilterTripsByDate filterTripsByDate = FilterTripsByDate(
      fromDate: fromDate,
      searchBy: _selectedSearchBy,
      toDate: toDate,
    );

    _tripBloc.add(filterTripsByDate);
    _tripStatisticBloc.add(filterTripsByDate);
    Navigator.pop(context);
  }

  void _resetButtonTriggered() {
    FilterTripsByDate filterTripsByDate = FilterTripsByDate(
      fromDate: null,
      searchBy: _selectedSearchBy,
      toDate: null,
    );

    _tripBloc.add(filterTripsByDate);
    _tripStatisticBloc.add(filterTripsByDate);
    Navigator.pop(context);
  }

  Widget _buildSearchByWidget({
    required String title,
    required SearchBy shortname,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () {
        _selectedSearchBy = shortname;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: appText(
          title.capitalize(),
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.defaultColor : AppColors.deepLavender,
          ),
        ),
      ),
    );
  }

  void _syncDateSelection(PickerDateRange date) {
    _fromDate = systemDefinedFormat(date.startDate!);
    _toDate = systemDefinedFormat(date.endDate!);
    final String startDate = convertDateToHumanReadableFormat(date.startDate!);
    final String endDate = convertDateToHumanReadableFormat(date.endDate!);
    _dateRangeTextEditingController.text = "$startDate - $endDate";
    _showDateRangePicker = false;
    setState(() {});
  }

  void _syncPeriodSelection(PeriodFilter? selectedItem) {
    _selectedPeriodFilter = selectedItem;
    print(selectedItem!.shortname);
    String? startDate;
    String? endDate;
    switch (selectedItem.shortname) {
      case "TODAY":
        _fromDate = today();
        _toDate = today();
        break;
      case "YESTERDAY":
        _fromDate = yesterday();
        _toDate = yesterday();
        break;
      case "NEXT7DAYS":
        _fromDate = today();
        _toDate = next7Days();
        break;
      case "NEXT30DAYS":
        _fromDate = today();
        _toDate = next30Days();
        break;
      case "CURRENTMONTH":
        _fromDate = currentMonthStartDate();
        _toDate = currentMonthEndDate();
        break;
      case "PREVIOUSMONTH":
        _fromDate = previousMonthStartDate();
        _toDate = previousMonthEndDate();
        break;
      default:
    }
    startDate = convertDateToHumanReadableFormat(DateTime.parse(_fromDate!));
    endDate = convertDateToHumanReadableFormat(DateTime.parse(_toDate!));
    _dateRangeTextEditingController.text = "$startDate - $endDate";
    setState(() {});
  }
}
