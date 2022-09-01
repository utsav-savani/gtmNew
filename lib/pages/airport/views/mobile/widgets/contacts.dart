import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class MAirportContacts extends StatelessWidget {
  const MAirportContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Phone 1'),
                controller: TextEditingController()..text = '97147023520',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController()..text = 'Phone 2',
                decoration: const InputDecoration(labelText: '97147023520'),
              ),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Phone 1: Custome/ Phone: Immigration'),
            ),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.powderBlue),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        )
      ],
    );
  }
}
