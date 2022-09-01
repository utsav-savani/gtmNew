import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ReviewSubmitTripPOBWidget extends StatelessWidget {
  final TripManagerReview review;

  const ReviewSubmitTripPOBWidget({Key? key, required this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TripReviewCurrentPOBDetail> list = review.currentPOBDetails;
    if (list.isEmpty) return noDataFoundWidget();
    return Container(
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final pob = list[index];
          return Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    height: tableCellHeight,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      color: AppColors.paleBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(spacing12),
                        topRight: Radius.circular(spacing12),
                      ),
                    ),
                    child: Row(
                      children: [
                        width(spacing12),
                        Text("Departing: ${pob.depApt}"),
                        width(spacing32),
                        Text(
                          "ETD: ${convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(pob.etd ?? '')}",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: tableCellHeight,
                          color: AppColors.deepLavender,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              _buildTableSubHeaderCellWidget("Name"),
                              _buildTableSubHeaderCellWidget("DOB"),
                              _buildTableSubHeaderCellWidget("Passport"),
                              _buildTableSubHeaderCellWidget("Nationality"),
                              _buildTableSubHeaderCellWidget("Type"),
                            ],
                          ),
                        ),
                        if (pob.pobDetails == null || pob.pobDetails!.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: noDataFoundWidget(),
                          ),
                        if (pob.pobDetails != null &&
                            pob.pobDetails!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(0),
                            alignment: Alignment.centerLeft,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: pob.pobDetails!.length,
                              itemBuilder: (context, index) {
                                final item = pob.pobDetails![index];
                                BoxDecoration? _boxDecoration;
                                if (index + 1 == pob.pobDetails!.length) {
                                  _boxDecoration = const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(spacing12),
                                      bottomRight: Radius.circular(spacing12),
                                    ),
                                  );
                                }
                                return Container(
                                  height: tableCellHeight,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(0),
                                  decoration: _boxDecoration,
                                  child: Row(
                                    children: [
                                      _buildTableCellWidget(
                                        contentText:
                                            "${item.surName} ${item.givenName}",
                                        index: index,
                                        align: Alignment.centerLeft,
                                      ),
                                      _buildTableCellWidget(
                                        contentText:
                                            convertDateYYYYMMDDToHumanReadableFormat(
                                                "${item.dob}"),
                                        index: index,
                                        align: Alignment.center,
                                      ),
                                      _buildTableCellWidget(
                                        contentText: "${item.passport}",
                                        index: index,
                                        align: Alignment.centerLeft,
                                      ),
                                      _buildTableCellWidget(
                                        contentText: "${item.nationality}",
                                        index: index,
                                        align: Alignment.centerLeft,
                                      ),
                                      _buildTableCellWidget(
                                        contentText: "${item.type}",
                                        index: index,
                                        align: Alignment.centerLeft,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildTableMainHeaderCellWidget({required String title, double? width}) {
    if (width != null) {
      return _buildTableHeaderContainerWidget(
        child: appText(
          title,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        width: width,
      );
    }
    return Expanded(
      child: Container(
        width: width,
        alignment: Alignment.centerLeft,
        height: tableCellHeight,
        padding: const EdgeInsets.all(8),
        child: appText(
          title,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTableHeaderContainerWidget({
    required Widget child,
    double? width,
  }) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      height: tableCellHeight,
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }

  _buildTableCellWidget({
    required String contentText,
    required int index,
    required Alignment align,
    double? width,
  }) {
    var cellColor = AppColors.greyRowEven;
    if (index % 2 != 0) cellColor = AppColors.greyRowOdd;
    return width != null
        ? _buildContainerWidget(
            child: appText(contentText, color: AppColors.charcoalGrey),
            cellColor: cellColor,
          )
        : Expanded(
            child: _buildContainerWidget(
              child: appText(contentText, color: AppColors.charcoalGrey),
              cellColor: cellColor,
            ),
          );
  }

  Widget _buildContainerWidget({
    required Widget child,
    required Color cellColor,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      height: tableCellHeight,
      padding: const EdgeInsets.all(8),
      child: child,
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 1.0, color: AppColors.lightBlueGrey),
        ),
        color: cellColor,
      ),
    );
  }

  _buildTableSubHeaderCellWidget(String title) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        height: tableCellHeight,
        padding: const EdgeInsets.all(8),
        child: appText(
          title,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
