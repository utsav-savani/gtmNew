import 'package:flutter/material.dart';

class AdvanePassangerInfo extends StatefulWidget {
  const AdvanePassangerInfo({Key? key}) : super(key: key);

  @override
  State<AdvanePassangerInfo> createState() => _AdvanePassangerInfoState();
}

class _AdvanePassangerInfoState extends State<AdvanePassangerInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: const Text('Advance passenger info'),
    );
  }
}
