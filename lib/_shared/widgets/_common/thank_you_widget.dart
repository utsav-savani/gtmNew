import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';

class ThankYouWidget extends StatelessWidget {
  final String? tabTitle;

  const ThankYouWidget({this.tabTitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _windowSize = MediaQuery.of(context).size;
    bool _isWeb = _windowSize.width >= web;
    return Scaffold(
      body: Center(
        child: Container(
          height: _windowSize.height * 0.8,
          width: _windowSize.width * 0.8,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                height: _windowSize.height * 0.8,
                width: _windowSize.width * 0.8,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: svgToIcon(
                        appImagesName: AppImages.checkedIcon,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(30),
                      alignment: Alignment.center,
                      child: appText(
                        "Thank You",
                        fontSize: 24,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: appText(
                        "Your request was submitted successfully,\none of our operations specialist will contact you momentarialy",
                        fontSize: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 26,
                right: 26,
                child: CloseButtonWidget(
                  onTap: () {
                    //print(tabTitle);
                    String t = 'Trip: ' + tabTitle!;
                    _isWeb ? closeTab(t, context) : Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
