import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ReviewSubmitTripScheduleWidget extends StatelessWidget {
  final TripManagerReview review;

  const ReviewSubmitTripScheduleWidget({Key? key, required this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TripReviewFlightDetail> list = review.flightDetails;
    return Column(
      children: <Widget>[
        Container(
          height: tableCellHeight,
          alignment: Alignment.centerLeft,
          color: AppColors.deepLavender,
          child: Row(
            children: <Widget>[
              buildTableMainHeaderCellWidget(title: "#", width: spacing24),
              buildTableMainHeaderCellWidget(title: "Dept."),
              buildTableMainHeaderCellWidget(title: "Arr"),
              buildTableMainHeaderCellWidget(title: "Callsign"),
              buildTableMainHeaderCellWidget(title: "Flight Category"),
              buildTableMainHeaderCellWidget(title: "Purpose"),
              buildTableMainHeaderCellWidget(title: "ETD"),
              buildTableMainHeaderCellWidget(title: "ETA"),
            ],
          ),
        ),
        if (list.isEmpty) noDataFoundWidget(),
        if (list.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              TripReviewFlightDetail item = list[index];
              print(item.etd);
              print(item.eta);
              return Container(
                height: tableCellHeight,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    _buildTableCellWidget(
                      contentText: "${index + 1}",
                      index: index,
                      align: Alignment.centerLeft,
                      width: spacing24,
                    ),
                    _buildTableCellWidget(
                      contentText: "${item.depApt}",
                      index: index,
                      align: Alignment.centerLeft,
                    ),
                    _buildTableCellWidget(
                      contentText: "${item.arrApt}",
                      index: index,
                      align: Alignment.centerLeft,
                    ),
                    _buildTableCellWidget(
                      contentText: "${item.callSign}",
                      index: index,
                      align: Alignment.centerLeft,
                    ),
                    _buildTableCellWidget(
                      contentText: "${item.flightCategory}",
                      index: index,
                      align: Alignment.centerLeft,
                    ),
                    _buildTableCellWidget(
                      contentText: "${item.purpose}",
                      index: index,
                      align: Alignment.centerLeft,
                    ),
                    _buildTableCellWidget(
                      contentText:
                          convertDateTimeYYYYMMDDHHMMStringToHumanReadableFormat(
                        "${item.etd}",
                      ),
                      index: index,
                      align: Alignment.centerLeft,
                    ),
                    _buildTableCellWidget(
                      contentText:
                          convertDateTimeYYYYMMDDHHMMStringToHumanReadableFormat(
                        "${item.eta}",
                      ),
                      index: index,
                      align: Alignment.centerLeft,
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  buildTableMainHeaderCellWidget({required String title, double? width}) {
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
}
