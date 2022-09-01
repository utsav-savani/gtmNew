import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

buildTitleBoxWidget(String title) {
  return Expanded(
    child: Container(
      height: reviewSubmiTitleBoxHeight,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Text(title),
    ),
  );
}

buildTableMainHeaderCellWidget({
  required String title,
  required bool isWeb,
}) {
  return Expanded(
    child: Container(
      alignment: Alignment.centerLeft,
      height:
          isWeb ? tableCellHeight : tableCellHeight * webMobileHeightMultiplier,
      padding: const EdgeInsets.all(8),
      child: appText(
        title,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

buildTableSubHeaderCellWidget(String title) {
  return Expanded(
    child: Container(
      alignment: Alignment.centerLeft,
      height: tableCellHeight,
      padding: const EdgeInsets.all(8),
      child: appText(
        title,
        color: AppColors.charcoalGrey,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

buildTableCellWidget({
  required String contentText,
  required int index,
  required Alignment align,
  required bool isWeb,
}) {
  var cellColor =
      (index % 2 != 0) ? AppColors.greyRowOdd : AppColors.greyRowEven;
  return Expanded(
    child: Container(
      alignment: align,
      height:
          isWeb ? tableCellHeight : tableCellHeight * webMobileHeightMultiplier,
      padding: const EdgeInsets.all(8),
      child: appText(contentText, color: AppColors.charcoalGrey),
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 1.0, color: AppColors.lightBlueGrey),
        ),
        color: cellColor,
      ),
    ),
  );
}

noData() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: appText(
        'No Data!',
        color: AppColors.blackColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
