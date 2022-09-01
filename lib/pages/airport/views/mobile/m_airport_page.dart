import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/airport/views/mobile/widgets/alerts.dart';
import 'package:gtm/pages/airport/views/mobile/widgets/contacts.dart';
import 'package:gtm/pages/airport/views/mobile/widgets/documents.dart';
import 'package:gtm/pages/airport/views/mobile/widgets/flight_requirement.dart';
import 'package:gtm/pages/airport/views/mobile/widgets/general_info.dart';
import 'package:gtm/pages/airport/views/mobile/widgets/weather.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';
import 'package:gtm/pages/people/views/mobile/header_widget.dart';
import 'package:gtm/pages/widgets/widgets.dart';

class MAirportsDetailsPage extends StatefulWidget {
  const MAirportsDetailsPage({Key? key}) : super(key: key);

  @override
  State<MAirportsDetailsPage> createState() => _MAirportsDetailsPageState();
}

class _MAirportsDetailsPageState extends State<MAirportsDetailsPage> with TickerProviderStateMixin {
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
      buttonText: 'Flight Requirements',
    ),
    const MHeaderButton(
      iconText: '4',
      buttonText: 'Alerts',
    ),
    const MHeaderButton(
      iconText: '5',
      buttonText: 'Weather',
    ),
    const MHeaderButton(
      iconText: '6',
      buttonText: 'NOTAMS',
    ),
    const MHeaderButton(
      iconText: '7',
      buttonText: 'Documents',
    ),
  ];

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: tripAppBar(context, 'Airport General Info'),
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
            MAirportsGeneralInfo(opened: false),
            const MAirportContacts(),
            const MAirportFlightRequirement(),
            const MAirportsAlerts(),
            MAirportWeather(
              opened: false,
            ),
            MAirportWeather(
              opened: false,
            ),
            MAirportDocuments(
              opened: false,
            ),
          ])),
        ],
      ),
    );
  }
}
