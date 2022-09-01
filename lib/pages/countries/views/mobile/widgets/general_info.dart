import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';

class MCountriesGeneralInfo extends StatefulWidget {
  MCountriesGeneralInfo({Key? key, required this.opened}) : super(key: key);
  bool opened;

  @override
  State<MCountriesGeneralInfo> createState() => _MCountriesGeneralInfoState();
}

class _MCountriesGeneralInfoState extends State<MCountriesGeneralInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getButton(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: spacing44,
              color: AppColors.defaultColor,
              child: Row(children: const [
                Text(
                  'Country United Arab Emirates',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                Spacer(),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.whiteColor)),
                //   width: 115,
                //   height: 38,
                //   child: const Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: Padding(
                //         padding: EdgeInsets.all(2.0),
                //         child: Text(
                //           'Create New',
                //           style: TextStyle(color: AppColors.whiteColor),
                //         ),
                //       )),
                // ),
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Icon(
                //     Icons.expand_less,
                //     color: Colors.white,
                //   ),
                // )
              ]),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Country Name'),
                controller: TextEditingController()
                  ..text = 'United Arab Emirates',
              ),
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'UAE',
                    decoration: const InputDecoration(labelText: '3-ISO Code'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'Abu Dhabi',
                    decoration: const InputDecoration(labelText: '2-ISO Code'),
                  ),
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'AED',
                    decoration:
                        const InputDecoration(labelText: 'Capital City'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'AED',
                    decoration:
                        const InputDecoration(labelText: 'Currency Code'),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Region'),
                controller: TextEditingController()..text = 'Middle East',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Security'),
                controller: TextEditingController()
                  ..text = 'Insignificant Security Risk',
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Offical Language'),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 77,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.powderBlue),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.powderBlue),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                                width: 112,
                                height: 36,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Arabic'),
                                )),
                            VerticalDivider(),
                            Icon(
                              Icons.cancel_outlined,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.powderBlue),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                                width: 112,
                                height: 36,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('English'),
                                )),
                            VerticalDivider(),
                            Icon(
                              Icons.cancel_outlined,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Emergency Services'),
                    controller: TextEditingController()..text = '-',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = '-',
                    decoration: const InputDecoration(labelText: 'Police'),
                  ),
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Fire'),
                    controller: TextEditingController()..text = '-',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = '998',
                    decoration: const InputDecoration(labelText: 'Ambulance'),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
                controller: TextEditingController()..text = 'Not Available',
              ),
            ),
            // _createNewDocument(),
            // _airportBrief(),
            // _countriesExmp(),
            // _departure(),
            // _attachment(),
          ]),
        ),
      ),
    );
  }

  getButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(spacing8),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.powderBlue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spacing6),
                )),
                minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(spacing128, spacing48)),
              ),
              onPressed: () {},
              child: const Text(cancel)),
        ),
        Padding(
          padding: const EdgeInsets.all(spacing8),
          child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spacing6),
                )),
                minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(spacing128, spacing48)),
              ),
              onPressed: () {},
              child: const Text('Save')),
        )
      ],
    );
  }

  Widget _airportBrief() {
    return Column(
      children: [
        Container(
          height: spacing44,
          color: AppColors.defaultColor,
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Airport Briefing',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.editPersonDetails),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.expand_less,
                color: Colors.white,
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Type')),
              Expanded(child: Text('Other Document'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Issue Date')),
              Expanded(child: Text('7/9/2021'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Expire Date')),
              Expanded(child: Text('Not Available'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Attachment')),
              Expanded(child: Text('1'))
            ],
          ),
        ),
      ],
    );
  }

  Widget _countriesExmp() {
    return Column(
      children: [
        Container(
          height: spacing44,
          color: AppColors.defaultColor,
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Countries Exempt.',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.editPersonDetails),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.expand_less,
                color: Colors.white,
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Type')),
              Expanded(child: Text('Other Document'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Issue Date')),
              Expanded(child: Text('7/9/2021'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Expire Date')),
              Expanded(child: Text('Not Available'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Attachment')),
              Expanded(child: Text('1'))
            ],
          ),
        ),
      ],
    );
  }

  Widget _departure() {
    return Column(
      children: [
        Container(
          height: spacing44,
          color: AppColors.defaultColor,
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'RWY 30 Departure',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.editPersonDetails),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.expand_less,
                color: Colors.white,
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Type')),
              Expanded(child: Text('Other Document'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Issue Date')),
              Expanded(child: Text('7/9/2021'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Expire Date')),
              Expanded(child: Text('Not Available'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Expanded(child: Text('Attachment')),
              Expanded(child: Text('2'))
            ],
          ),
        ),
      ],
    );
  }

  Widget _attachment() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppImages.documentSvg),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('035f5df6d6fxf6tdg'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(Icons.download),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.visibility,
                      )),
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(Icons.delete),
                  )
                ],
              ),
            )),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppImages.documentSvg),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('035f5df6d6fxf6tdg'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(Icons.download),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.visibility,
                      )),
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(Icons.delete),
                  )
                ],
              ),
            )),
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
      ],
    );
  }

  Widget _createNewDocument() {
    return Column(
      children: [
        Container(
          height: spacing44,
          color: AppColors.defaultColor,
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Create New',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.editPersonDetails),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.expand_less,
                color: Colors.white,
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            controller: TextEditingController()..text = 'Enter Name',
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
                  controller: TextEditingController()..text = 'dd/mm/yyyy',
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Type',
            ),
            controller: TextEditingController()..text = 'Select Document Type',
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Checkbox(value: true, onChanged: (onChanged) {}),
            ),
            const Text('UFN')
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 125,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Brief Notes'),
            ),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
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
                        child: Text('Save'),
                      )))
            ],
          ),
        ),
      ],
    );
  }
}
