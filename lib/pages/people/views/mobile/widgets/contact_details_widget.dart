import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';

class MContactDetails extends StatefulWidget {
  final bool opened;
  const MContactDetails({Key? key, required this.opened}) : super(key: key);

  @override
  State<MContactDetails> createState() => _MContactDetailsState();
}

class _MContactDetailsState extends State<MContactDetails> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(children: [
        Container(
          height: spacing44,
          color: AppColors.defaultColor,
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Contact Details',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(AppImages.editPersonDetails),
            const Icon(Icons.expand_less)
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Contact Type'),
            controller: TextEditingController()..text = 'Email 1',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Mobile'),
            controller: TextEditingController()..text = '+9715558549444',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Email 1'),
            controller: TextEditingController()..text = 'dxb@uas.com',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Email 2'),
            controller: TextEditingController()..text = 'dxb@uas.com',
          ),
        ),
      ]),
    );
  }
}
