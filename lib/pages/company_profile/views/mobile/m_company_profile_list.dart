import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/company_profile/views/mobile/m_company_profile_details_page.dart';

class MCompanyProfileList extends StatefulWidget {
  const MCompanyProfileList({Key? key}) : super(key: key);

  @override
  State<MCompanyProfileList> createState() => _MCompanyProfileListState();
}

class _MCompanyProfileListState extends State<MCompanyProfileList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
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
        child: SizedBox(
          height: 800,
          child: Column(
            children: [
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
                      'Contact Details',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MCompanyProfilePage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppImages.editPersonDetails),
                    ),
                  ),
                  const Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  )
                ]),
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: const [
                    Expanded(child: Text('Region')),
                    Expanded(child: Text('Middle East'))
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: const [
                    Expanded(child: Text('Country')),
                    Expanded(child: Text('Saudi Arabia'))
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: const [
                    Expanded(child: Text('BDM')),
                    Expanded(child: Text('Khaled Husa..'))
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: const [
                    Expanded(child: Text('CIC Cate..')),
                    Expanded(child: Text('Champions'))
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: const [
                    Expanded(child: Text('Office')),
                    Expanded(child: Text('DXB/GRN..'))
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: const [
                    Expanded(child: Text('Account Status')),
                    Expanded(child: Text('Needs Approval'))
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: const [
                    Expanded(child: Text('Status')),
                    Expanded(child: Text('Active'))
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: const [
                    Expanded(child: Text('Type')),
                    Expanded(child: Text('Customers, O'))
                  ],
                ),
              ),
              Container(
                height: spacing44,
                color: AppColors.defaultColor,
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'BULGARIA AIR',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppImages.editPersonDetails),
                  ),
                  const Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  )
                ]),
              ),
              Container(
                height: 1,
              ),
              Container(
                height: spacing44,
                color: AppColors.defaultColor,
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SAUDI ARABIAN AIR',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppImages.editPersonDetails),
                  ),
                  const Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  )
                ]),
              ),
              Container(
                height: 1,
              ),
              Container(
                height: spacing44,
                color: AppColors.defaultColor,
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SAUDI ARABIAN AIR',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppImages.editPersonDetails),
                  ),
                  const Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
