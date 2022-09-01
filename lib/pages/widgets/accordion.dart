import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';

class Accordion extends StatefulWidget {
  final GlobalKey? globalKey;
  final String title;
  final String guid;
  final String tripNumber;
  final String? tripStatus;
  final Color? listTileColor;
  final bool? isDashboard;
  final bool? isClip;
  final bool? isLast;
  final Widget content;

  const Accordion({
    Key? key,
    required this.title,
    this.tripStatus,
    this.isDashboard,
    this.isClip,
    this.isLast,
    required this.content,
    this.listTileColor,
    required this.guid,
    required this.tripNumber,
    this.globalKey,
  }) : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;

  @override
  void initState() {
    _showContent = !widget.isDashboard!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: widget.listTileColor ?? AppColors.defaultColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Stack(children: [
            (widget.isDashboard == null || widget.isDashboard!)
                ? Positioned(
                    left: MediaQuery.of(context).size.width * 0.45,
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorFromTripStatus(widget.tripStatus),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        toCamleCase(widget.tripStatus),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ))
                : Container(),
            ListTile(
              title: InkWell(
                onTap: () {
                  if (widget.isDashboard == null || widget.isDashboard!) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ManageTrip(
                          guid: widget.guid,
                          key: widget.globalKey,
                        ),
                        settings: RouteSettings(
                          arguments: {
                            'guid': widget.guid,
                            'tripNumber': widget.tripNumber,
                          },
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            (widget.isDashboard == null || widget.isDashboard!)
                                ? Colors.white
                                : Colors.black,
                      ),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: (widget.isDashboard == null || widget.isDashboard!)
                      ? Colors.white
                      : Colors.black,
                ),
                onPressed: () {
                  _showContent = !_showContent;
                  setState(() {});
                },
              ),
            ),
          ]),
        ),
        _showContent
            ? widget.content
            : (widget.isClip != null && !widget.isClip!)
                ? Container()
                : Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Wrap(
                          clipBehavior: Clip.antiAlias,
                          children: [widget.content],
                        ),
                      ),
                      (widget.isLast != null && widget.isLast!)
                          ? height(50)
                          : Container()
                    ],
                  )
      ]),
    );
  }
}
