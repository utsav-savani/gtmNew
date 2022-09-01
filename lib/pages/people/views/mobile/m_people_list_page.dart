import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/utils/app_images.dart';
import 'package:gtm/pages/people/views/mobile/widgets/people_details.dart';

class MPeopleListPage extends StatefulWidget {
  const MPeopleListPage({Key? key}) : super(key: key);

  @override
  State<MPeopleListPage> createState() => _MPeopleListPageState();
}

class _MPeopleListPageState extends State<MPeopleListPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 44,
                      child: Row(
                        children: const [Icon(Icons.search), Text('Search')],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
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
            SizedBox(
              height: 1000,
              child: Column(children: [
                _details(),
                _details(),
                _details(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _details() {
    return Column(
      children: [
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
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MPeopleDetailsPage()),
                    );
                  },
                  child: SvgPicture.asset(AppImages.editPersonDetails)),
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
            ),
          ]),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Expanded(child: Text('Name')),
                        Expanded(child: Text('Mike'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Expanded(child: Text('Operators')),
                        Expanded(child: Text('Hou Test'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Expanded(child: Text('Positions')),
                        Expanded(child: Text('Captain Crew Passenger'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Expanded(child: Text('Residence')),
                        Expanded(child: Text('United Arab Emirates'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Action'),
                        Expanded(
                            flex: 5,
                            child: Icon(
                              Icons.visibility_outlined,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
              height: 200,
              child: Card(
                color: AppColors.paleGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero)),
                child: Icon(Icons.expand_more),
              ),
            )
          ],
        ),
      ],
    );
  }
}
