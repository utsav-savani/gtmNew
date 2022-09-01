import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

import '../../_shared/utils/app_images.dart';

class IntroScreenSkeleton extends StatelessWidget {
  const IntroScreenSkeleton(
      {Key? key, required this.headerName, required this.widgetToDarw})
      : super(key: key);

  final String headerName;
  final Widget widgetToDarw;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultColor.withOpacity(0.05),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.blackColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      AppImages.logoHand,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: svgToIcon(
                      appImagesName: AppImages.uasLogoIcon,
                      color: AppColors.charcoalGrey,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: AppColors.logoMatchBackground,
                  ),
                  Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.defaultColor.withOpacity(0.05),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  height(MediaQuery.of(context).size.height *
                                      0.03),
                                  Text(
                                    'GLOBAL TRIP MANAGER',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            fontSize: 28,
                                            fontWeight: FontWeight.w900),
                                  ),
                                  height(MediaQuery.of(context).size.height *
                                      0.04),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        headerName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.7)),
                                      )),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Divider(
                                        endIndent:
                                            MediaQuery.of(context).size.width *
                                                0.83,
                                        thickness: 2,
                                        color: Colors.black.withOpacity(0.7),
                                      )),
                                  height(MediaQuery.of(context).size.height *
                                      0.04),
                                  widgetToDarw
                                ],
                              )))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
