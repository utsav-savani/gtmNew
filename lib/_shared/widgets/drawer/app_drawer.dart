import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/widgets/drawer/m_app_drawer_screen.dart';
import 'package:gtm/_shared/widgets/drawer/w_app_drawer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, required this.userData}) : super(key: key);

  ///logged in user data
  final User userData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return AppDrawerWeb(userData: userData);
        } else {
          return const MAppDrawerScreen();
        }
      },
    );
  }
}
