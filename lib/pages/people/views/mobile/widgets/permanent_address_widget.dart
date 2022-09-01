import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/_shared/widgets/_common/widget_size.dart';

class MPermanentAddress extends StatefulWidget {
  final bool opened;
  const MPermanentAddress({Key? key, required this.opened}) : super(key: key);

  @override
  State<MPermanentAddress> createState() => _MPermanentAddressState();
}

class _MPermanentAddressState extends State<MPermanentAddress> {
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
                'Permanent Address',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(AppImages.editPersonDetails),
            const Icon(Icons.expand_less)
          ]),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Apt/House No'),
                  controller: TextEditingController()..text = '44a',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Street'),
                  controller: TextEditingController()..text = '76c',
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Town/Suburb'),
            controller: TextEditingController()..text = 'Mirdife',
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Residence'),
                  controller: TextEditingController()..text = 'Male',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'City',
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AppColors.greyishBrown,
                      )),
                  controller: TextEditingController()..text = '15/08/1974',
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Zip/Post Code'),
                  controller: TextEditingController()
                    ..text = 'Enter Zip/Post Code',
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(
                        onChanged: (onChanged) {},
                        value: false,
                      )),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Not Available'),
                  )
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
