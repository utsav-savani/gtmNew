import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/people/views/mobile/m_people_list_page.dart';
import 'package:gtm/pages/people/views/web/w_people_list_page.dart';

class PeoplePage extends StatefulWidget {
  ///
  const PeoplePage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: PeoplePage());

  ///
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PeoplePage());
  }

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > web) {
          return const WPeopleListPage();
        } else {
          return const MPeopleListPage();
        }
      },
    );
  }
}
