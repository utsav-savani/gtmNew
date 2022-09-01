import 'package:flutter/material.dart';

class SideMenuItem {
  final String icon;
  final String title;
  final String label;
  final String type;
  final Widget page;
  final String? shortname;

  SideMenuItem({
    required this.icon,
    required this.title,
    required this.label,
    required this.type,
    required this.page,
    this.shortname,
  });
}
