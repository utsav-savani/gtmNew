import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/views/mobile/widgets/alerts.dart';
import 'package:gtm/pages/countries/views/mobile/widgets/flight_requirement.dart';
import 'package:gtm/pages/countries/views/mobile/widgets/general_info.dart';
import 'package:gtm/pages/countries/views/mobile/widgets/health.dart';
import 'package:gtm/pages/countries/views/mobile/widgets/passport_visa_country.dart';
import 'package:gtm/pages/countries/views/mobile/widgets/sanction.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';
import 'package:gtm/pages/people/views/mobile/header_widget.dart';
import 'package:gtm/pages/widgets/widgets.dart';

class MCountriesPage extends StatefulWidget {
  const MCountriesPage({Key? key}) : super(key: key);

  @override
  State<MCountriesPage> createState() => _MCountriesPageState();
}

class _MCountriesPageState extends State<MCountriesPage> with TickerProviderStateMixin {
  TabType tabType = TabType.tripData;

  List<MHeaderButton> headerList = [
    const MHeaderButton(
      iconText: '1',
      buttonText: 'General Info',
    ),
    const MHeaderButton(
      iconText: '2',
      buttonText: 'Health',
    ),
    const MHeaderButton(
      iconText: '3',
      buttonText: 'Passport & Visa',
    ),
    const MHeaderButton(
      iconText: '4',
      buttonText: 'Sanctions',
    ),
    const MHeaderButton(
      iconText: '5',
      buttonText: 'Flight Requirements',
    ),
    const MHeaderButton(
      iconText: '6',
      buttonText: 'Alerts',
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
      appBar: tripAppBar(context, 'Countires General Info'),
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
            MCountriesGeneralInfo(opened: false),
            MCountriesGeneralHealth(opened: false),
            MCountriesGeneralPassportVisa(
              opened: false,
            ),
            MCountriesSanctions(
              opened: false,
            ),
            const MCountriesFlightRequirement(),
            const MCountriesAlerts(),
          ])),
        ],
      ),
    );
  }
}
