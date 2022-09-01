import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/helpers/utilities.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_usermanagement_page.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class MUserManagement extends StatefulWidget {
  const MUserManagement({Key? key}) : super(key: key);

  @override
  State<MUserManagement> createState() => _MUserManagementState();
}

class _MUserManagementState extends State<MUserManagement> {
  List<Operator> _operators = <Operator>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('User Management'.translate()),
      body: const WUserManagementPage(),
    );
  }
}
