import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:flutter/material.dart';

class PurposeDropdown extends StatefulWidget {
  final List<FlightPurpose> purposes;
  final int? purposeId;
  final Function selectedItemHandler;
  const PurposeDropdown(
      {this.purposeId,
      required this.purposes,
      required this.selectedItemHandler,
      Key? key})
      : super(key: key);

  @override
  State<PurposeDropdown> createState() => _PurposeDropdownState();
}

class _PurposeDropdownState extends State<PurposeDropdown> {
  late List<FlightPurpose> _purposes = <FlightPurpose>[];
  FlightPurpose? _selectedPurpose;

  @override
  void didChangeDependencies() {
    _purposes = widget.purposes;
    // _tripDetail = widget.tripDetail;
    // _loadData();
    super.didChangeDependencies();
  }

  // _loadData() async {
  //   _purposes = await FlightPurposeRepository().getFlightPurposesData();
  //   if (widget.purposeId != null) {
  //     var index = _purposes
  //         .indexWhere((element) => element.flightPurposeId == widget.purposeId);
  //     _selectedPurpose = _purposes[index];
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    if (_purposes.isEmpty) return Container();
    return DropdownButton<FlightPurpose>(
      isExpanded: true,
      underline: const SizedBox(),
      style: const TextStyle(overflow: TextOverflow.ellipsis),
      icon: const Icon(Icons.expand_more_rounded),
      hint: const Text("Select Purpose"),
      items: _purposes.map((item) {
        return DropdownMenuItem<FlightPurpose>(
          child: Text(item.flightPurpose),
          value: item,
        );
      }).toList(),
      onChanged: (value) {
        _selectedPurpose = value!;
        widget.selectedItemHandler(value);
        setState(() {});
      },
      value: _selectedPurpose,
    );
  }
}
