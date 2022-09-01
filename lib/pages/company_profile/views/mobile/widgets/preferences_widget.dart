import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/shared.dart';

class MCompanyProfilePreferences extends StatelessWidget {
  const MCompanyProfilePreferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getButton(),
      body: SingleChildScrollView(
          child: SizedBox(
        height: 1500,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Search', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Container(
            height: spacing44,
            color: AppColors.defaultColor,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Customer: DXB TEST',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MCompanyProfilePage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppImages.editPersonDetails),
                ),
              ),
              const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              const Icon(
                Icons.expand_less,
                color: Colors.white,
              )
            ]),
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Priority'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('1'),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Preferred'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('SAUDI ARABIAN AIR '),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Forbidden'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('-'),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Services'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Aircraft Cleaning Air'),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Country'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('-'),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Airport'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('-'),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Flight Category'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('-'),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Purposes'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('-'),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Equipment'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('-'),
                ),
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Cross Selling'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.check_circle),
                ),
              )
            ],
          ),
          Container(
            height: spacing44,
            color: AppColors.lightBlue,
            child: Row(children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Notes: Not Available',
                  style: TextStyle(color: AppColors.defaultColor),
                ),
              ),
              Spacer(),
              Icon(
                Icons.expand_less,
              )
            ]),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
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
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: 'Email 1',
                        suffixIcon: Icon(Icons.delete_forever)),
                    controller: TextEditingController()..text = '1',
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
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: 'Phone 1',
                        suffixIcon: Icon(Icons.delete_forever)),
                    controller: TextEditingController()..text = '+961675765',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: 'Purpose',
                        suffixIcon: Icon(Icons.expand_more)),
                    controller: TextEditingController()
                      ..text = 'Select Purpose',
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Services', suffixIcon: Icon(Icons.expand_more)),
              controller: TextEditingController()..text = 'Select Services',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Countries', suffixIcon: Icon(Icons.expand_more)),
              controller: TextEditingController()..text = 'Select Countries',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Airports', suffixIcon: Icon(Icons.expand_more)),
              controller: TextEditingController()..text = 'Select Airports',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Flight Categories',
                  suffixIcon: Icon(Icons.expand_more)),
              controller: TextEditingController()
                ..text = 'Select Flight Categories',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Purposes', suffixIcon: Icon(Icons.expand_more)),
              controller: TextEditingController()..text = 'Select Purposes',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Equipment', suffixIcon: Icon(Icons.expand_more)),
              controller: TextEditingController()..text = 'Select Equipment',
            ),
          ),
        ]),
      )),
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
}
