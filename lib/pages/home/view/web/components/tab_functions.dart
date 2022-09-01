import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/home/cubit/tab_cubit/tab_cubit.dart';
import 'package:gtm/pages/home/models/gtm_tab.dart';

bool tabClosingClick = false;

void openTab(GtmTab gtmTab, BuildContext context) {
  context.read<TabCubit>().addTab(gtmTab);
}

void closeTab(String title, BuildContext context) async {
  if (!tabClosingClick) {
    tabClosingClick = true;
    //retrieve from gtmTabList the Gtm object  that has title
    List<GtmTab> _tabs = await context.read<TabCubit>().getActiveTabs();
    var gtmTab = _tabs.where((element) => element.name == title);
    if (gtmTab.isNotEmpty) {
      log("found tab to remove: " + gtmTab.elementAt(0).name);
      await context.read<TabCubit>().removeTab(gtmTab.elementAt(0));
    }
    tabClosingClick = false;
  }
}
