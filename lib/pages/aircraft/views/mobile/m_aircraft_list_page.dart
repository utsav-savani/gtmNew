import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/aircraft/views/mobile/widgets/aircraft_trips.dart';
import 'package:gtm/pages/aircraft/views/mobile/widgets/documents_widget.dart';
import 'package:gtm/pages/aircraft/views/mobile/widgets/general_info.dart';
import 'package:gtm/pages/countries/views/mobile/widgets/health.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';
import 'package:gtm/pages/people/views/mobile/header_widget.dart';
import 'package:gtm/pages/widgets/widgets.dart';

class MAircraftListPage extends StatefulWidget {
  const MAircraftListPage({Key? key}) : super(key: key);

  @override
  State<MAircraftListPage> createState() => _MAircraftListPageState();
}

class _MAircraftListPageState extends State<MAircraftListPage> with TickerProviderStateMixin {
  TabType tabType = TabType.tripData;

  List<MHeaderButton> headerList = [
    const MHeaderButton(
      iconText: '1',
      buttonText: 'Aircraft',
    ),
    const MHeaderButton(
      iconText: '2',
      buttonText: 'General Info',
    ),
    const MHeaderButton(
      iconText: '3',
      buttonText: 'Documents',
    ),
    const MHeaderButton(
      iconText: '4',
      buttonText: 'Trips',
    ),
  ];

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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
            MAircraftsGeneralInfo(opened: false),
            MCountriesGeneralHealth(opened: false),
            MAircraftDocuments(
              opened: false,
            ),
            const MAircraftTrips(),
          ])),
        ],
      ),
    );
  }
}
