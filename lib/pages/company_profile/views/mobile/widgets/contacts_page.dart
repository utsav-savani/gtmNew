import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';

class MCompanyContactsPage extends StatefulWidget {
  final bool opened;
  const MCompanyContactsPage({Key? key, required this.opened})
      : super(key: key);

  @override
  State<MCompanyContactsPage> createState() => _MCompanyContactsPageState();
}

class _MCompanyContactsPageState extends State<MCompanyContactsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1500,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                    ),
                    controller: TextEditingController()..text = 'Search',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Create New')),
              )
            ],
          ),
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Operations',
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
          Container(
            color: AppColors.brightPink,
            child: Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Contact Type: OPS'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.expand_less),
                )
              ],
            ),
          ),
          Row(
            children: const [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Medium'),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Email 1'),
              ))
            ],
          ),
          Row(
            children: const [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Info'),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('dxbops@uas.aero'),
              ))
            ],
          ),
          Row(
            children: const [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Purpose'),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Default'),
              ))
            ],
          ),
          Container(
            color: AppColors.brightPink,
            child: Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Contact Type: OPS'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.expand_less),
                )
              ],
            ),
          ),
          Row(
            children: const [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Medium'),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Email 2'),
              ))
            ],
          ),
          Row(
            children: const [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Info'),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('dxbops@uas.aero'),
              ))
            ],
          ),
          Row(
            children: const [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Purpose'),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Default'),
              ))
            ],
          ),
          Container(
            color: AppColors.defaultColor,
            child: Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Customer - Saudi Ara...'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.expand_less),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: TextEditingController()..text = 'Main Contact',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Contact Type',
                        suffixIcon: Icon(Icons.expand_more)),
                    controller: TextEditingController()..text = 'Main',
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Priority',
                      suffixIcon: Icon(Icons.expand_more)),
                  controller: TextEditingController()..text = '1',
                ),
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Customer', suffixIcon: Icon(Icons.expand_more)),
              controller: TextEditingController()..text = 'Select Customer',
            ),
          ),
          Container(
            color: AppColors.brightPink,
            child: Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Contact Details'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.expand_less),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Medium',
                        suffixIcon: Icon(Icons.add_circle)),
                    controller: TextEditingController()..text = 'Select Medium',
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Email 1',
                      suffixIcon: Icon(Icons.delete_forever)),
                  controller: TextEditingController()..text = '1',
                ),
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Phone1',
                        suffixIcon: Icon(Icons.delete_forever)),
                    controller: TextEditingController()..text = '+9615451541',
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Purpose',
                  ),
                  controller: TextEditingController()..text = 'Select Purpose',
                ),
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Designation 1',
                  suffixIcon: Icon(Icons.expand_more)),
              controller: TextEditingController()..text = 'Duty Manager',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 82,
              height: 38,
              child: Row(children: const [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.add_circle),
                ),
                Text('Add')
              ]),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.defaultColor),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          getButton()
        ]),
      ),
    );
  }

  getButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
              child: const Text('Cancel')),
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
}
