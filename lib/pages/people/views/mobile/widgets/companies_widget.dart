import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';

class MCompanies extends StatefulWidget {
  final bool opened;
  const MCompanies({Key? key, required this.opened}) : super(key: key);

  @override
  State<MCompanies> createState() => _MCompaniesState();
}

class _MCompaniesState extends State<MCompanies> {
  List<String> companiesList = ['DXB', 'DXB Test'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: spacing44,
          color: AppColors.defaultColor,
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Companies',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(AppImages.editPersonDetails),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.expand_less,
                color: Colors.white,
              ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.powderBlue)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Companies',
                    ),
                    // decoration: InputDecoration(labelText: 'Contact Type'),
                    // controller: TextEditingController()..text = 'Email 1',
                    items: const [],
                    onChanged: (Object? value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search'),
                          controller: TextEditingController()..text = 'Search',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AppImages.addSvg),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: index == 2
                            ? const Text('DXB ')
                            : const Text('DXB Test'),
                      );
                    }),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: 2)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.alternateButtonColor),
                          minimumSize:
                              MaterialStateProperty.all(const Size(177, 44))),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cancel'),
                      ))),
              width(10),
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(177, 44))),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Edit'),
                      )))
            ],
          ),
        )
      ]),
    );
  }
}
