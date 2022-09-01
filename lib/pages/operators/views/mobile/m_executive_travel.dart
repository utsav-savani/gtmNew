import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/helpers/utilities.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_executive_traveldesk_page.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class MExecutiveTravelPage extends StatefulWidget {
  const MExecutiveTravelPage({Key? key}) : super(key: key);

  @override
  State<MExecutiveTravelPage> createState() => _MExecutiveTravelPageState();
}

class _MExecutiveTravelPageState extends State<MExecutiveTravelPage> {
  List<Operator> _operators = <Operator>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Executive Travel'.translate()),
      body: const WExecutiveTravelDeskPage(),
    );
  }
}
