import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';

class MProfileType extends StatefulWidget {
  final bool opened;
  const MProfileType({Key? key, required this.opened}) : super(key: key);

  @override
  State<MProfileType> createState() => _MProfileTypeState();
}

class _MProfileTypeState extends State<MProfileType> {
  List<String> companiesList = ['DXB', 'DXB Test'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.defaultColor)),
                      height: 58,
                      width: 180,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(AppImages.passengerSvg),
                            SvgPicture.asset(AppImages.selectedSvg),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.defaultColor)),
                      height: 58,
                      width: 180,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(AppImages.passengerSvg),
                            SvgPicture.asset(AppImages.selectedSvg),
                          ]),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.defaultColor)),
                      height: 58,
                      width: 180,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(AppImages.passengerSvg),
                            SvgPicture.asset(AppImages.selectedSvg),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.transparent)),
                        height: 58,
                        width: 180,
                        child: const SizedBox()),
                  )
                ],
              ),
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
                          child: Text('Edit'),
                        )))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
