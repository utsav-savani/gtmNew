import 'package:flutter/material.dart';
import 'package:gtm/pages/home/dashboard/view/mobile/_partials/trip_manager_analytics_widget.dart';
import 'package:gtm/pages/home/dashboard/view/mobile/_partials/trip_manager_list_widget.dart';

class MTripManagerDashboardScreen extends StatefulWidget {
  const MTripManagerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<MTripManagerDashboardScreen> createState() =>
      _MTripManagerDashboardScreenState();
}

class _MTripManagerDashboardScreenState
    extends State<MTripManagerDashboardScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TripManagerAnalyticsWidget(),
        TripManagerListWidget(),
      ],
    );
  }
}
