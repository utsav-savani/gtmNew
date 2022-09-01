import 'package:flutter/material.dart';
import 'package:gtm/pages/home/dashboard/view/mobile/m_trip_manager_landing_screen.dart';
import 'package:gtm/pages/home/view/web/w_dashboard.dart';
import 'package:gtm/responsive/screen_type_layout.dart';

class HomePage extends StatefulWidget {
  ///
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  ///
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _buildMobile(),
      tablet: _buildWeb(),
      desktop: _buildWeb(),
    );
  }

  Widget _buildWeb() {
    return const WebDashBoard();
  }

  Widget _buildMobile() {
    return const MTripManagerLandingScreen();
  }
}
