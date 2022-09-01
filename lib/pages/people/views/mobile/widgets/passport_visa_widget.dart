import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';

class MPassportVisa extends StatefulWidget {
  final bool opened;
  const MPassportVisa({Key? key, required this.opened}) : super(key: key);

  @override
  State<MPassportVisa> createState() => _MPassportVisaState();
}

class _MPassportVisaState extends State<MPassportVisa>
    with TickerProviderStateMixin {
  TabController? _tabController;

  List<String> stringList = ['Passport', 'Visa'];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Passport & Visa',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.whiteColor)),
                width: 115,
                height: 38,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add_circle_outline,
                          color: AppColors.whiteColor,
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            'Add New',
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        )
                      ]),
                ),
              ),
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
            child: TabBar(
                controller: _tabController,
                tabs: stringList
                    .map((e) => SizedBox(
                        height: 42,
                        child: Text(
                          e,
                          style: const TextStyle(color: AppColors.defaultColor),
                        )))
                    .toList()),
          ),
          SizedBox(
            height: 850,
            child: TabBarView(controller: _tabController, children: [
              _passportWidget(),
              _visaWidget(),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _passportWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Preference'),
            controller: TextEditingController()..text = 'Select Preference',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Nationality'),
            controller: TextEditingController()..text = 'Select Nationality',
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Issue Date',
                      suffixIcon: Icon(Icons.calendar_month)),
                  controller: TextEditingController()..text = 'dd/mm/yyyy',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      suffixIcon: Icon(Icons.calendar_month)),
                  controller: TextEditingController()
                    ..text = 'Select Preference',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Select'),
                  controller: TextEditingController()
                    ..text = 'Select Passport Type',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Checkbox(value: false, onChanged: (onChanged) {}),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('In Active'),
                    )
                  ],
                ),
              ),
            )
          ],
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
                        child: Text('Add'),
                      )))
            ],
          ),
        ),
        SizedBox(
          height: 500,
          child: Column(children: [
            Container(
              height: spacing44,
              color: AppColors.brightPink,
              child: Row(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Argentina',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppImages.editPersonDetails)),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(AppImages.passportSvg),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Name on Passport'),
                      controller: TextEditingController()..text = 'Karl Smith',
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Passport Number'),
                controller: TextEditingController()..text = '123456',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Nationality'),
                controller: TextEditingController()..text = 'ARG',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Issue Date',
                          suffixIcon: Icon(Icons.calendar_month)),
                      controller: TextEditingController()..text = 'dd/mm/yyyy',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Expiry Date',
                          suffixIcon: Icon(Icons.calendar_month)),
                      controller: TextEditingController()
                        ..text = 'Select Preference',
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }

  Widget _visaWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Country'),
            controller: TextEditingController()..text = 'Select Country',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Number'),
            controller: TextEditingController()..text = 'Enter Number',
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Issue Date',
                      suffixIcon: Icon(Icons.calendar_month)),
                  controller: TextEditingController()..text = 'dd/mm/yyyy',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      suffixIcon: Icon(Icons.calendar_month)),
                  controller: TextEditingController()
                    ..text = 'Select Preference',
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(value: false, onChanged: (onChanged) {}),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('In Active'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
                labelText: 'Attachment',
                suffix: Text('Upload'),
                suffixIcon: Icon(Icons.link)),
            controller: TextEditingController()..text = 'Browse',
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
                        child: Text('Add'),
                      )))
            ],
          ),
        ),
      ],
    );
  }
}
