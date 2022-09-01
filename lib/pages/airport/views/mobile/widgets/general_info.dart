import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class MAirportsGeneralInfo extends StatefulWidget {
  MAirportsGeneralInfo({Key? key, required this.opened}) : super(key: key);
  bool opened;

  @override
  State<MAirportsGeneralInfo> createState() => _MAirportsGeneralInfoState();
}

class _MAirportsGeneralInfoState extends State<MAirportsGeneralInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomFilter(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 2000,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search)),
                        controller: TextEditingController()..text = 'Search',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('View Brief')),
                  )
                ],
              ),
            ),
            Container(
              height: spacing44,
              color: AppColors.defaultColor,
              child: Row(children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Airport Dubai International Airport',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
            Wrap(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Civil'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Civil'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Civil'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Civil'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Civil'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Civil'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
              ],
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Icao Code'),
                    controller: TextEditingController()..text = 'omdb',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'omaaAuh',
                    decoration: const InputDecoration(labelText: 'Alternative'),
                  ),
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Icao Code'),
                    controller: TextEditingController()..text = 'omdb',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'omaaAuh',
                    decoration: const InputDecoration(labelText: 'Alternative'),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController()..text = 'Some country',
                decoration: const InputDecoration(labelText: 'Country'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController()..text = 'Some country',
                decoration: const InputDecoration(labelText: 'Country'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController()..text = 'Some country',
                decoration: const InputDecoration(labelText: 'Country'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController()..text = 'Some country',
                decoration: const InputDecoration(labelText: 'Country'),
              ),
            ),
            Container(
              height: spacing44,
              color: AppColors.defaultColor,
              child: Row(children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Runway Information',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Icao Code'),
                    controller: TextEditingController()..text = 'omdb',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'omaaAuh',
                    decoration: const InputDecoration(labelText: 'Alternative'),
                  ),
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Icao Code'),
                    controller: TextEditingController()..text = 'omdb',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'omaaAuh',
                    decoration: const InputDecoration(labelText: 'Alternative'),
                  ),
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Icao Code'),
                    controller: TextEditingController()..text = 'omdb',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: TextEditingController()..text = 'omaaAuh',
                    decoration: const InputDecoration(labelText: 'Alternative'),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget bottomFilter() {
    return Container(
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      child: Column(children: [
                        Container(
                          color: AppColors.defaultColor,
                          height: 48,
                          child: Row(children: const [
                            Expanded(
                                child: Text(
                              'Columns',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            )
                          ]),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 48,
                          child: Row(children: const [
                            Expanded(child: Text('Name')),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.expand_circle_down),
                            )
                          ]),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 48,
                          child: Row(children: const [
                            Expanded(child: Text('Customers')),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.expand_circle_down),
                            )
                          ]),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 48,
                          child: Row(children: const [
                            Expanded(child: Text('Positions')),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.expand_circle_down),
                            )
                          ]),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 48,
                          child: Row(children: const [
                            Expanded(child: Text('Residence')),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.expand_circle_down),
                            )
                          ]),
                        ),
                      ]),
                      height: 350,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                    );
                  },
                );
              },
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.filter_alt),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'FILTERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.menu),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'COLUMNS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF4527a0),
              Color(0xFF7b1fa2),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
