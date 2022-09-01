import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';

class MAircraftTrips extends StatelessWidget {
  const MAircraftTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 150,
          child: Column(
            children: [
              Container(
                height: 40,
                color: AppColors.defaultColor,
                child: Row(children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('DXB-2200023'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.silver,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        width: 84,
                        height: 22,
                        child: const Text('Completed'),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                  )
                ]),
              ),
              Row(
                children: const [
                  Expanded(
                    child: Text('Reg No.'),
                  ),
                  Expanded(
                    child: Text('A6DXB'),
                  )
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Text('Route'),
                  ),
                  Expanded(
                    child: Text('OMDB,EGLL'),
                  )
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Text('File Status'),
                  ),
                  Expanded(
                    child: Text('Closed'),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 150,
          child: Column(
            children: [
              Container(
                height: 40,
                color: AppColors.defaultColor,
                child: Row(children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('DXB-2200023'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.silver,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        width: 84,
                        height: 22,
                        child: const Text('Completed'),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                  )
                ]),
              ),
              Row(
                children: const [
                  Expanded(
                    child: Text('Reg No.'),
                  ),
                  Expanded(
                    child: Text('A6DXB'),
                  )
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Text('Route'),
                  ),
                  Expanded(
                    child: Text('OMDB,EGLL'),
                  )
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Text('File Status'),
                  ),
                  Expanded(
                    child: Text('Closed'),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
