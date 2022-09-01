import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/helpers/utilities.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_logs_page.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class MLogsPage extends StatefulWidget {
  const MLogsPage({Key? key}) : super(key: key);

  @override
  State<MLogsPage> createState() => _MLogsPageState();
}

class _MLogsPageState extends State<MLogsPage> {
  List<Operator> _operators = <Operator>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Logs'.translate()),
      body: const WLogsPage(),
    );
  }
}
