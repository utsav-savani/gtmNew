// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/constants/string_constants.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';

class ServiceAccordion extends StatefulWidget {
  final GlobalKey? globalKey;
  final String title;
  final Color? listTileColor;
  final Color? titleColor;
  String? departTime;
  String? arrivalTime;
  final bool isCountry;
  final bool isArrivale;
  final bool isDepart;
  bool? isAllBorder;
  Color? iconColor;
  double? visualDensity;

  final Widget content;

  ServiceAccordion({
    Key? key,
    required this.title,
    required this.content,
    this.listTileColor,
    this.titleColor,
    this.departTime,
    this.arrivalTime,
    this.isAllBorder,
    this.iconColor,
    this.visualDensity,
    required this.isCountry,
    required this.isArrivale,
    required this.isDepart,
    this.globalKey,
  }) : super(key: key);
  @override
  _ServiceAccordionState createState() => _ServiceAccordionState();
}

class _ServiceAccordionState extends State<ServiceAccordion> {
  bool _showContent = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            color: widget.listTileColor ?? AppColors.departBoxColor,
            borderRadius: widget.isAllBorder != null && widget.isAllBorder!
                ? BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))
                : null,
            border: widget.isAllBorder != null && widget.isAllBorder!
                ? Border.all(color: AppColors.lightBlueGrey, width: 1)
                : const Border(
                    bottom:
                        BorderSide(color: AppColors.lightBlueGrey, width: 1),
                    top: BorderSide(color: AppColors.lightBlueGrey, width: 1))),
        child: ListTile(
          visualDensity: VisualDensity(vertical: widget.visualDensity ?? 0),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: widget.titleColor ?? Colors.black),
            ),
            widget.isCountry
                ? SvgPicture.asset(
                    'assets/images/flight_over_icon.svg',
                  )
                : Row(
                    children: [
                      widget.isArrivale
                          ? Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/flight_arrive_icon.svg',
                                ),
                                width(5),
                              ],
                            )
                          : Container(),
                      widget.isArrivale
                          ? Text(
                              widget.arrivalTime ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.primaryColor),
                            )
                          : Container(),
                      widget.isArrivale ? width(5) : Container(),
                      widget.isDepart
                          ? Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/flight_depart_icon.svg',
                                ),
                                width(5),
                              ],
                            )
                          : Container(),
                      widget.isDepart
                          ? Text(
                              widget.departTime ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.primaryColor),
                            )
                          : Container(),
                    ],
                  )
          ]),
          trailing: IconButton(
            icon: Icon(
              _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: widget.iconColor ?? Colors.black,
            ),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
      ),
      _showContent ? widget.content : Container()
    ]);
  }
}
