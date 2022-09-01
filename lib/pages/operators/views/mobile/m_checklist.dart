import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/helpers/utilities.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_checklist_page.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class MChecklistPage extends StatefulWidget {
  const MChecklistPage({Key? key}) : super(key: key);

  @override
  State<MChecklistPage> createState() => _MChecklistPageState();
}

class _MChecklistPageState extends State<MChecklistPage> {
  List<Operator> _operators = <Operator>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Checklist'.translate()),
      body: WChecklistPage(),
    );
  }
}
