import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';

class MGeneralInfoPage extends StatefulWidget {
  final bool opened;
  const MGeneralInfoPage({Key? key, required this.opened}) : super(key: key);

  @override
  State<MGeneralInfoPage> createState() => _MGeneralInfoPageState();
}

class _MGeneralInfoPageState extends State<MGeneralInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1500,
      child: Column(children: [
        Container(
          height: spacing44,
          color: AppColors.defaultColor,
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'DXB Test',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.editPersonDetails),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Parent Company'),
            controller: TextEditingController()..text = 'NA',
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Status',
                  ),
                  controller: TextEditingController()..text = 'Active',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Team'),
                  controller: TextEditingController()..text = 'DXB/YLW',
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
                labelText: 'Country',
                suffixIcon: Icon(
                  Icons.language,
                  color: AppColors.greyishBrown,
                )),
            controller: TextEditingController()..text = 'United Arab Emirates',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Address'),
            controller: TextEditingController()..text = 'Not Available',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration:
                const InputDecoration(labelText: 'Select/ Province of Birth'),
            controller: TextEditingController()..text = 'Select a State',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(4)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Notes'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'BDM'),
            controller: TextEditingController()..text = 'Jimmy Gadallah',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Type'),
            controller: TextEditingController()..text = 'Customer Operator',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
                labelText: 'Region',
                suffixIcon: Icon(
                  Icons.language,
                  color: AppColors.greyishBrown,
                )),
            controller: TextEditingController()..text = 'Middle East',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
                labelText: 'Website',
                suffixIcon: Icon(Icons.table_chart_sharp)),
            controller: TextEditingController()..text = 'https://www.uas.aero',
          ),
        ),
      ]),
    );
  }
}
