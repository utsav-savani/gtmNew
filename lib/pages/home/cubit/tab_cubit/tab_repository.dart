import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtm/pages/home/home.dart';

class TabRepository {
  final List<GtmTab> gtmTabList = List<GtmTab>.empty(growable: true);

  Future<List<GtmTab>> userSelectedTabs() async {
    return gtmTabList;
  }

  Future<List<GtmTab>> addTabToList(GtmTab addTab) async {
    /// add the tab to the tab repo
    try {
      var stored = gtmTabList.where((element) => element.name == addTab.name);
      if (stored.isEmpty) {
        gtmTabList.add(addTab);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userSelectedTabs();
  }

  Future<List<GtmTab>> removeTabFromList(GtmTab removeTab) async {
    /// remove the tab from the tab repo list
    try {
      var stored =
          gtmTabList.where((element) => element.name == removeTab.name);
      if (stored.isNotEmpty) {
        var remove = stored.where((element) => element.name == removeTab.name);
        if (remove.isNotEmpty) gtmTabList.remove(removeTab);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userSelectedTabs();
  }
}
