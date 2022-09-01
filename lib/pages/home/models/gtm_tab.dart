import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GtmTab extends Equatable {
  final String name;
  final Widget tab;
  Widget? page;
  final bool isActive;
  final String? shortname;
  GtmTab({
    required this.name,
    required this.tab,
    this.page,
    required this.isActive,
    this.shortname,
  });

  @override
  List<Object?> get props => [name, tab, page, isActive, shortname];
}
