import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/utils/app_images.dart';
import 'package:gtm/_shared/widgets/_common/widget_size.dart';

class MPrimaryData extends StatefulWidget {
  final bool opened;
  const MPrimaryData({Key? key, required this.opened}) : super(key: key);

  @override
  State<MPrimaryData> createState() => _MPrimaryDataState();
}

class _MPrimaryDataState extends State<MPrimaryData> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(children: [
        Container(
          height: spacing44,
          color: AppColors.defaultColor,
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Primary Data',
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
            decoration: const InputDecoration(labelText: 'Given Name'),
            controller: TextEditingController()..text = 'Mike',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Sur Name'),
            controller: TextEditingController()..text = 'Smith',
          ),
        ),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Gender'),
                    controller: TextEditingController()..text = 'Male',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'DOB',
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Country Of Birth'),
            controller: TextEditingController()..text = 'New Zealand',
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
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'City of Birth'),
            controller: TextEditingController()..text = 'Sydney',
          ),
        )
      ]),
    );
  }
}
