import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ReviewSubmitTripServiceWidget extends StatelessWidget {
  final TripManagerReview review;

  const ReviewSubmitTripServiceWidget({Key? key, required this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TripReviewCurrentServiceSummary> list = review.currentServiceSummary;
    return Column(
      children: [
        Container(
          height: tableCellHeight,
          alignment: Alignment.centerLeft,
          color: AppColors.deepLilac,
          child: Row(
            children: [
              _buildTableMainHeaderCellWidget(title: "Service Type"),
              _buildTableMainHeaderCellWidget(title: "SEQ"),
              _buildTableMainHeaderCellWidget(title: "Location"),
              _buildTableMainHeaderCellWidget(title: "ON"),
              _buildTableMainHeaderCellWidget(title: "PYMT"),
              _buildTableMainHeaderCellWidget(title: "THRU"),
            ],
          ),
        ),
        if (list.isEmpty) noDataFoundWidget(),
        if (list.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final sector = list[index];
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: tableCellHeight,
                            alignment: Alignment.centerLeft,
                            color: AppColors.paleBlue,
                            child: Row(
                              children: <Widget>[
                                _buildTableSubHeaderCellWidget(
                                    "Sector ${sector.index}: ${sector.departure} - ${sector.arrival} "),
                              ],
                            ),
                          ),
                          if (sector.serviceDetails == null ||
                              sector.serviceDetails!.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: noDataFoundWidget(
                                  text: "No services selected"),
                            ),
                          if (sector.serviceDetails != null &&
                              sector.serviceDetails!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(0),
                              alignment: Alignment.centerLeft,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: sector.serviceDetails!.length,
                                itemBuilder: (context, index) {
                                  final item = sector.serviceDetails![index];
                                  return Container(
                                    height: tableCellHeight,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        _buildTableCellWidget(
                                          contentText: "${item.serviceType}",
                                          index: index,
                                          align: Alignment.centerLeft,
                                        ),
                                        _buildTableCellWidget(
                                          contentText: "${item.seq}",
                                          index: index,
                                          align: Alignment.center,
                                        ),
                                        _buildTableCellWidget(
                                          contentText: "${item.location}",
                                          index: index,
                                          align: Alignment.centerLeft,
                                        ),
                                        _buildTableCellWidget(
                                          contentText: "${item.on}",
                                          index: index,
                                          align: Alignment.centerLeft,
                                        ),
                                        _buildTableCellWidget(
                                          contentText: "${item.payment}",
                                          index: index,
                                          align: Alignment.centerLeft,
                                        ),
                                        _buildTableCellWidget(
                                          contentText: "${item.through}",
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
                );
              },
            ),
          ),
      ],
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
          color: AppColors.charcoalGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
