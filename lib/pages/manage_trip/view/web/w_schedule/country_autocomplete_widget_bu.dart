import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gtm/_shared/helpers/utilities.dart';
import 'package:gtm/_shared/shared.dart';

class CountryAutocompleteWidgetBU extends StatefulWidget {
  final int? countryId;
  final List<Country> countries;
  final Function selectedItemHandler;
  const CountryAutocompleteWidgetBU(
      {this.countryId,
      required this.countries,
      required this.selectedItemHandler,
      Key? key})
      : super(key: key);

  @override
  State<CountryAutocompleteWidgetBU> createState() =>
      _CountryAutocompleteWidgetBUState();
}

class _CountryAutocompleteWidgetBUState
    extends State<CountryAutocompleteWidgetBU> {
  late List<Country> _countries = <Country>[];
  late Country _selectedItem;
  String? _selectedCountryItem;
  String? _selectedCountryCode;

  @override
  void didChangeDependencies() {
    _countries = widget.countries;
    if (widget.countryId != null) {
      var index = _countries.indexWhere((element) {
        return element.countryId == widget.countryId;
      });
      if (index >= 0) {
        _selectedItem = _countries[index];
        _selectedCountryItem = _selectedItem.name;
        _selectedCountryCode = _selectedItem.code;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_countries.isEmpty) return Container();
    return TypeAheadField<Country?>(
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
        controller: TextEditingController()
          ..text = _selectedCountryItem != null
              ? "${getFlag(_selectedCountryCode ?? '')} $_selectedCountryItem"
              : "",
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          hintText: 'Select Country',
        ),
      ),
      suggestionsCallback: (pattern) async {
        return _countries;
      },
      itemBuilder: (context, Country? suggestion) {
        final country = suggestion!;

        return ListTile(
          title: Text("${country.name}"),
        );
      },
      noItemsFoundBuilder: (context) => const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No Users Found.',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      onSuggestionSelected: (Country? suggestion) {
        _selectedItem = suggestion!;
        _selectedCountryItem = _selectedItem.name;
        _selectedCountryCode = _selectedItem.code3;

        widget.selectedItemHandler(_selectedItem);
        setState(() {});
      },
    );
  }
}
