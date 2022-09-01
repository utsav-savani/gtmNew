import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/views/web/w_countries_list_page.dart';

class MCountriesPage extends StatefulWidget {
  const MCountriesPage({Key? key}) : super(key: key);

  @override
  State<MCountriesPage> createState() => _MCountriesPageState();
}

class _MCountriesPageState extends State<MCountriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Countries'.translate()),
      body: const WCountriesListPage(),
    );
  }
}
