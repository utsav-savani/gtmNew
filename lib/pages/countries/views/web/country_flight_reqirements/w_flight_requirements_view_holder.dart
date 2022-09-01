import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/pages/countries/views/web/country_flight_reqirements/w_country_flight_requirements_page.dart';

class WCountryFlightRequirementsViewHolder extends StatefulWidget {
  final Country country;

  const WCountryFlightRequirementsViewHolder({required this.country, Key? key})
      : super(key: key);

  @override
  State<WCountryFlightRequirementsViewHolder> createState() => _WCountryFlightRequirementsViewHolderState();
}

class _WCountryFlightRequirementsViewHolderState extends State<WCountryFlightRequirementsViewHolder> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return WCountryFlightRequirementsPage(country: widget.country);
        },fullscreenDialog: true);
      },
    );

  }
}
