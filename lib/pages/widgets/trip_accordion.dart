// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';

class TripAccordion extends StatefulWidget {
  final Widget titleWidget;
  final GlobalKey? globalKey;
  final Color? listTileColor;
  final Color? titleColor;

  final double? visualDensity;
  final String? eta;
  final String? sector;
  final Widget content;

  const TripAccordion({
    Key? key,
    required this.titleWidget,
    required this.content,
    this.eta,
    this.listTileColor,
    this.titleColor,
    this.visualDensity,
    this.sector,
    this.globalKey,
  }) : super(key: key);
  @override
  _TripAccordionState createState() => _TripAccordionState();
}

class _TripAccordionState extends State<TripAccordion> {
  bool _showContent = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius _borderRadius = BorderRadius.all(Radius.circular(10));
    if (_showContent) {
      _borderRadius = BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.defaultColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.listTileColor ?? AppColors.departBoxColor,
              borderRadius: _borderRadius,
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    _showContent = !_showContent;
                    setState(() {});
                  },
                  visualDensity: VisualDensity(
                    vertical: widget.visualDensity ?? 0,
                  ),
                  title: widget.titleWidget,
                ),
              ],
            ),
          ),
          _showContent ? widget.content : Container()
        ],
      ),
    );
  }
}
