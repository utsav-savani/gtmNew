import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/helpers/utilities.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/aircraft/views/web/w_aircraft_list_page.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class MAircraftsPage extends StatefulWidget {
  const MAircraftsPage({Key? key}) : super(key: key);

  @override
  State<MAircraftsPage> createState() => _MAircraftsPageState();
}

class _MAircraftsPageState extends State<MAircraftsPage> {
  List<Operator> _operators = <Operator>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Aircrafts'.translate()),
      body: const WAircraftListPage(),
    );
  }
}
