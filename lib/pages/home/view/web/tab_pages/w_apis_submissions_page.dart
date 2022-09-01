import 'package:flutter/material.dart';
import 'package:gtm/_shared/constants/values_constants.dart';
import 'package:gtm/pages/home/view/web/_common/comming_soon_widget.dart';
import 'package:gtm/pages/home/view/web/w_dashboard.dart';

class WApisSubmissions extends StatefulWidget {
  const WApisSubmissions({Key? key}) : super(key: key);

  @override
  State<WApisSubmissions> createState() => _WApisSubmissionsState();
}

class _WApisSubmissionsState extends State<WApisSubmissions> {
  late double mainWidgetHeight,
      mainWidgetWidth,
      menuItemHeight,
      menuItemWidth,
      sidePanelWidth;
  late Size windowSize;
  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    windowSize = MediaQuery.of(context).size;
    menuItemHeight = sidebarOpen ? openPanelItemHeight : closedPanelItemHeight;
    menuItemWidth = sidebarOpen ? openPanelWidth : closedPanelWidth;
    sidePanelWidth = menuItemWidth;

    mainWidgetHeight = windowSize.height - appBarHeight;
    mainWidgetWidth = windowSize.width - sidePanelWidth;
    return Center(
      child: ComingSoonWidget(
        width: mainWidgetWidth,
        height: mainWidgetHeight,
      ),
    );
  }
}
