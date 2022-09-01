import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/pages/countries/views/web/country_alerts/w_country_alerts_page.dart';

class WCountryAlertsViewHolder extends StatefulWidget {
  final Country country;

  const WCountryAlertsViewHolder({required this.country, Key? key})
      : super(key: key);

  @override
  State<WCountryAlertsViewHolder> createState() =>
      _WCountryAlertsViewHolderState();
}

class _WCountryAlertsViewHolderState
    extends State<WCountryAlertsViewHolder> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) {
              return WCountryAlertsPage(country: widget.country);
            },
            fullscreenDialog: true);
      },
    );
  }
}
