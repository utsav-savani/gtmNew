import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class AirportDropdown extends StatefulWidget {
  final int? airportId;
  final Function selectedItemHandler;
  const AirportDropdown(
      {this.airportId, required this.selectedItemHandler, Key? key})
      : super(key: key);

  @override
  State<AirportDropdown> createState() => _AirportDropdownState();
}

class _AirportDropdownState extends State<AirportDropdown> {
  late List<Airport> _airports = <Airport>[];
  Airport? _selectedItem;

  @override
  void didChangeDependencies() {
    // _tripDetail = widget.tripDetail;
    _loadData();
    super.didChangeDependencies();
  }

  _loadData() async {
    AirportRepository _repo = AirportRepository();
    _repo.setPage("1");
    _repo.setLimit("10");
    _airports = await _repo.getAirports();
    if (widget.airportId != null) {
      var index = _airports.indexWhere((element) {
        print("${element.airportId}, ${widget.airportId}");
        return element.airportId == widget.airportId;
      });
      print("${widget.airportId} ===  $index");
      if (index >= 0) _selectedItem = _airports[index];
      print(_selectedItem);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_airports.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Location"),
        DropdownButtonFormField<Airport>(
          isExpanded: true,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(
              spacing20,
              spacing20,
              spacing20,
              0,
            ),
          ),
          hint: const Text("Select Location"),
          items: _airports.map((item) {
            return DropdownMenuItem<Airport>(
              child: Wrap(
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              value: item,
            );
          }).toList(),
          onChanged: (value) {
            _selectedItem = value!;
            setState(() {});
            widget.selectedItemHandler(value);
          },
          value: _selectedItem,
        ),
        if (_selectedItem != null)
          Padding(
            padding: const EdgeInsets.all(spacing4),
            child: Text(
              "${_selectedItem!.city}",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
      ],
    );
  }
}
