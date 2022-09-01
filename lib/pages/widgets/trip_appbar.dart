import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar tripAppBar(
  BuildContext context,
  String title, {
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Text(title),
    titleTextStyle: Theme.of(context).textTheme.headline6,
    centerTitle: false,
    actions: actions,
  );
}
