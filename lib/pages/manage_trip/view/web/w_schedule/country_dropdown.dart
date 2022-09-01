import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class CountryDropdown extends StatefulWidget {
  final int? countryId;
  final List<Country> countries;
  final Function selectedItemHandler;
  const CountryDropdown(
      {this.countryId,
      required this.countries,
      required this.selectedItemHandler,
      Key? key})
      : super(key: key);

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  late List<Country> _countries = <Country>[];
  Country? _selectedItem;

  @override
  void didChangeDependencies() {
    _countries = widget.countries;
    if (widget.countryId != null) {
      var index = _countries.indexWhere((element) {
        //print("${element.countryId}, ${widget.countryId}");
        return element.countryId == widget.countryId;
      });
      //print("${widget.countryId} ===  $index");
      if (index >= 0) _selectedItem = _countries[index];
      //print(_selectedItem);
    }
    // _loadData();
    super.didChangeDependencies();
  }

  // _loadData() async {
  //   CountryRepository _repo = CountryRepository();
  //   _countries = await _repo.getCountries();
  //   if (widget.countryId != null) {
  //     var index = _countries.indexWhere((element) {
  //       print("${element.countryId}, ${widget.countryId}");
  //       return element.countryId == widget.countryId;
  //     });
  //     print("${widget.countryId} ===  $index");
  //     if (index >= 0) _selectedItem = _countries[index];
  //     print(_selectedItem);
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    if (_countries.isEmpty) return Container();
    return DropdownButtonFormField<Country>(
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
      items: _countries.map((item) {
        return DropdownMenuItem<Country>(
          child: Wrap(
            children: [
              Text(
                item.name!,
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
    );
  }
}
