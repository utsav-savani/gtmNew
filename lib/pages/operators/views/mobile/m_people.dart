import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/people/views/mobile/m_people_list_page.dart';

class MPeoplePage extends StatefulWidget {
  const MPeoplePage({Key? key}) : super(key: key);

  @override
  State<MPeoplePage> createState() => _MPeoplePageState();
}

class _MPeoplePageState extends State<MPeoplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('People'.translate()),
      body: const MPeopleListPage(),
    );
  }
}
