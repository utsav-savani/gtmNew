import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/airport/views/web/w_airport_list_screen.dart';

class MAirportsPage extends StatefulWidget {
  const MAirportsPage({Key? key}) : super(key: key);

  @override
  State<MAirportsPage> createState() => _MAirportsPageState();
}

class _MAirportsPageState extends State<MAirportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Airports'.translate()),
      body: const WAirportListPage(),
    );
  }
}
