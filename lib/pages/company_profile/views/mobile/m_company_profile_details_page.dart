import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/company_profile/views/mobile/widgets/contacts_page.dart';
import 'package:gtm/pages/company_profile/views/mobile/widgets/documents_widget.dart';
import 'package:gtm/pages/company_profile/views/mobile/widgets/flight_category.dart';
import 'package:gtm/pages/company_profile/views/mobile/widgets/general_info_page.dart';
import 'package:gtm/pages/company_profile/views/mobile/widgets/operational_notes.dart';
import 'package:gtm/pages/company_profile/views/mobile/widgets/preferences_widget.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';
import 'package:gtm/pages/people/views/mobile/header_widget.dart';
import 'package:gtm/pages/widgets/widgets.dart';

class MCompanyProfilePage extends StatefulWidget {
  const MCompanyProfilePage({Key? key}) : super(key: key);

  @override
  State<MCompanyProfilePage> createState() => _MCompanyProfilePageState();
}

class _MCompanyProfilePageState extends State<MCompanyProfilePage> with TickerProviderStateMixin {
  TabType tabType = TabType.tripData;

  List<MHeaderButton> headerList = [
    const MHeaderButton(
      iconText: '1',
      buttonText: 'General Info',
    ),
    const MHeaderButton(
      iconText: '2',
      buttonText: 'Contacts',
    ),
    const MHeaderButton(
      iconText: '3',
      buttonText: 'Operational Notes',
    ),
    const MHeaderButton(
      iconText: '4',
      buttonText: 'Preferences',
    ),
    const MHeaderButton(
      iconText: '5',
      buttonText: 'Documents',
    ),
    const MHeaderButton(
      iconText: '6',
      buttonText: 'Flight Categories',
    ),
  ];

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: tripAppBar(context, 'Company General Info'),
      body: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            controller: _tabController,
            tabs: headerList,
          ),
          height(10),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            ListView(
              children: [
                MGeneralInfoPage(opened: false),
              ],
            ),
            MCompanyContactsPage(opened: false),
            const MCompanyProfileOperationalNotes(),
            const MCompanyProfilePreferences(),
            MCompanyProfileDocuments(opened: false),
            const MCompanyProfileFlightCategory(),
          ])),
        ],
      ),
    );
  }
}
