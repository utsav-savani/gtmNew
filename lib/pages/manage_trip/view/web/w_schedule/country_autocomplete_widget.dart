import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gtm/_shared/shared.dart';

class CountryAutocompleteWidget extends StatefulWidget {
  final int? countryId;
  final List<Country> countries;
  final Function selectedItemHandler;
  const CountryAutocompleteWidget({
    this.countryId,
    required this.countries,
    required this.selectedItemHandler,
    Key? key,
  }) : super(key: key);

  @override
  State<CountryAutocompleteWidget> createState() =>
      _CountryAutocompleteWidgetState();
}

class _CountryAutocompleteWidgetState extends State<CountryAutocompleteWidget> {
  late List<Country> _countries = <Country>[];
  Country? _selectedItem;
  String? _selectedCountryItem;
  int? _selectedCountryId;
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
        _selectedCountryItem = _selectedItem!.name;

        _selectedCountryId = _selectedItem!.countryId;
        _selectedCountryCode = _selectedItem!.code;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_countries.isEmpty) return Container();
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        style: DefaultTextStyle.of(context).style.copyWith(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Select Country',
          suffix: InkWell(
            onTap: () {
              _selectedCountryItem = null;
              _selectedCountryId = null;
              _selectedCountryCode = null;
              setState(() {});
            },
            child: const Icon(
              Icons.clear_rounded,
              size: 20,
              color: AppColors.iconGrey,
            ),
          ),
        ),
        controller: TextEditingController()
          ..text = _selectedCountryItem != null
              ? "${getFlag(_selectedCountryCode ?? '')} $_selectedCountryItem"
              : "",
      ),
      suggestionsCallback: (pattern) async {
        if (pattern.isNotEmpty) {
          final splitted = pattern.split(" ");
          splitted.removeAt(0);

          pattern = splitted.join(" ");
          //print(pattern);
        }
        return _countries;
      },
      itemBuilder: (context, Country country) {
        return ListTile(
          leading: Text(getFlag(country.code ?? '') + ' ' + country.name),
        );
      },
      onSuggestionSelected: (Country value) {
        _selectedItem = value;
        _selectedCountryItem = _selectedItem!.name;
        _selectedCountryId = _selectedItem!.countryId;
        _selectedCountryCode = _selectedItem!.code;
        //print("$_selectedCountryId");
        widget.selectedItemHandler(_selectedItem);
        setState(() {});
      },
    );
  }
}
