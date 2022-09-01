import 'package:flutter/material.dart';
import 'package:gtm/_shared/constants/string_constants.dart';

class WAircraftPage extends StatefulWidget {
  //final Function closePageTrigger;
  const WAircraftPage({/* required this.closePageTrigger */ Key? key})
      : super(key: key);

  @override
  State<WAircraftPage> createState() => _WAircraftPageState();
}

class _WAircraftPageState extends State<WAircraftPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(aircraft),
    );
  }
}
