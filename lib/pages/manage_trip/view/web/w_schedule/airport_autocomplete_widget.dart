import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gtm/_shared/shared.dart';

class AirportAutocompleteWidget extends StatefulWidget {
  final int? airportId;
  final Airport? airport;
  final Function selectedItemHandler;
  const AirportAutocompleteWidget({
    this.airportId,
    this.airport,
    required this.selectedItemHandler,
    Key? key,
  }) : super(key: key);

  @override
  State<AirportAutocompleteWidget> createState() =>
      _AirportAutocompleteWidgetState();
}

class _AirportAutocompleteWidgetState extends State<AirportAutocompleteWidget> {
  late List<Airport> _airports = <Airport>[];
  Airport? _selectedItem;
  String? _selectedAirportName;
  int? _selectedAirportId;
  String? _selectedAirportCity;

  @override
  void initState() {
    _loadData();
    // TODO: implement initState
    super.initState();
  }

  _loadData() async {
    AirportRepository _repo = AirportRepository();
    try {
      _airports = await _repo.getAirports();
      if (widget.airport != null) {
        _selectedItem = widget.airport;
      } else if (widget.airportId != null) {
        var index = _airports.indexWhere((element) {
          print("${element.airportId}, ${widget.airportId}");
          return element.airportId == widget.airportId;
        });
        print("${widget.airportId} ===  $index");
        if (index >= 0) {
          _selectedItem = _airports[index];
        }
        print(_selectedItem);
      }
      if (_selectedItem != null) {
        _selectedAirportName = _selectedItem!.name;
        _selectedAirportId = _selectedItem!.airportId;
        if (_selectedItem!.city != null) {
          _selectedAirportCity = _selectedItem!.city!;
        }
      }
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // if (_airports.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            style: DefaultTextStyle.of(context).style.copyWith(),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Location',
            ),
            controller: TextEditingController()
              ..text =
                  _selectedAirportName != null ? "$_selectedAirportName" : "",
          ),
          suggestionsCallback: (pattern) async {
            return await AirportRepository().getAirportsWeb(pattern);
          },
          itemBuilder: (context, Airport airport) {
            return ListTile(
              leading: Text(
                "${airport.iata}/${airport.icao}, ${airport.name}, ${airport.city}",
              ),
            );
          },
          onSuggestionSelected: (Airport value) {
            _selectedItem = value;
            _selectedAirportName = _selectedItem!.name;
            _selectedAirportId = _selectedItem!.airportId;
            _selectedAirportCity = _selectedItem!.city;
            print("$_selectedAirportName");
            print("$_selectedAirportId");
            widget.selectedItemHandler(_selectedItem);
            setState(() {});
          },
        ),
        if (_selectedAirportCity != null) appText(_selectedAirportCity),
      ],
    );
  }
}
