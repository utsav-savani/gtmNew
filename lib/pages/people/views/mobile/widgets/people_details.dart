import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';
import 'package:gtm/pages/people/views/mobile/widgets/companies_widget.dart';
import 'package:gtm/pages/people/views/mobile/widgets/contact_details_widget.dart';
import 'package:gtm/pages/people/views/mobile/widgets/documents_widget.dart';
import 'package:gtm/pages/people/views/mobile/widgets/passport_visa_widget.dart';
import 'package:gtm/pages/people/views/mobile/widgets/permanent_address_widget.dart';
import 'package:gtm/pages/people/views/mobile/widgets/primary_data_widget.dart';
import 'package:gtm/pages/people/views/mobile/header_widget.dart';
import 'package:gtm/pages/people/views/mobile/widgets/profile_type_widget.dart';
import 'package:gtm/pages/widgets/widgets.dart';

class MPeopleDetailsPage extends StatefulWidget {
  const MPeopleDetailsPage({Key? key}) : super(key: key);

  @override
  State<MPeopleDetailsPage> createState() => _MPeopleDetailsPageState();
}

class _MPeopleDetailsPageState extends State<MPeopleDetailsPage> with TickerProviderStateMixin {
  TabType tabType = TabType.tripData;

  List<MHeaderButton> headerList = [
    const MHeaderButton(
      iconText: '1',
      buttonText: 'Personal Info',
    ),
    const MHeaderButton(
      iconText: '2',
      buttonText: 'Companies',
    ),
    const MHeaderButton(
      iconText: '3',
      buttonText: 'Profile Type',
    ),
    const MHeaderButton(
      iconText: '4',
      buttonText: 'Passport & Visa',
    ),
    const MHeaderButton(
      iconText: '5',
      buttonText: 'Documents',
    ),
  ];

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: tripAppBar(context, 'People Details'),
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
              children: [MPrimaryData(opened: false), MPermanentAddress(opened: false), MContactDetails(opened: false)],
            ),
            MCompanies(opened: false),
            MProfileType(opened: false),
            MPassportVisa(opened: false),
            MDocuments(opened: false),
          ])),
        ],
      ),
    );
  }
}
