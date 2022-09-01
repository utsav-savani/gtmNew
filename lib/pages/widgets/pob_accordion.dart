// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';

class PobAccordion extends StatefulWidget {
  final GlobalKey? globalKey;
  final String title;
  final Color? listTileColor;
  final Color? titleColor;
  final String profileUrl;
  final String designation;
  final String country;
  bool? isAllBorder;
  Color? iconColor;
  double? visualDensity;

  final Widget content;

  PobAccordion({
    Key? key,
    required this.title,
    required this.content,
    this.listTileColor,
    this.titleColor,
    this.isAllBorder,
    this.iconColor,
    this.visualDensity,
    required this.profileUrl,
    required this.designation,
    required this.country,
    this.globalKey,
  }) : super(key: key);
  @override
  _PobAccordionState createState() => _PobAccordionState();
}

class _PobAccordionState extends State<PobAccordion> {
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
          title: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image.network(widget.profileUrl)),
              width(10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: widget.titleColor ?? Colors.black),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.designation}, ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.defaultColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.country,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.defaultColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ]),
            ],
          ),
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
