import 'package:flutter/material.dart';
import 'package:gtm/_shared/constants/values_constants.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';

Widget tabHeader(fixed, tabTitle, context) {
  return Tab(
    text: tabTitle,
  );
}

Widget tabHeader1(fixed, tabTitle, context) {
  return Tab(
    child: Container(
      width: tabTitleBoxWidth,
      height: tabTitleBoxHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.paleGrey,
            Colors.white,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: tabHeaderActionIcons,
            width: tabHeaderActionIcons,
            child: fixed
                ? Container()
                : InkWell(
                    onTap: () => closeTab(tabTitle, context),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.powderBlue,
                    ),
                  ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: appText(
                tabTitle,
                color: AppColors.charcoalGrey,
              ),
            ),
          ),
          SizedBox(
            height: tabHeaderActionIcons,
            width: tabHeaderActionIcons,
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.refresh,
                color: AppColors.powderBlue,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
