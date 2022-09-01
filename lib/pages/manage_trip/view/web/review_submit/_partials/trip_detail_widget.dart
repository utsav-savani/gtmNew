import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class WReviewSubmitDetailWidget extends StatelessWidget {
  final TripManagerReview review;

  const WReviewSubmitDetailWidget({Key? key, required this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: spacing140,
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: spacing140,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              _buildFirstCardView(),
              width(12),
              _buildSecondCardView(),
              width(12),
              _buildThirdCardView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstCardView() {
    return _buildCommonCardView(
      children: [
        _buildDetailsRowWidget('TRIP NO', "${review.tripNumber}"),
        height(12),
        _buildDetailsRowWidget('CUSTOMER', "${review.customer}"),
        height(12),
        _buildDetailsRowWidget('OPERATOR', "${review.operator}"),
      ],
    );
  }

  Widget _buildSecondCardView() {
    return _buildCommonCardView(
      children: [
        _buildDetailsRowWidget('A/C TYPE', review.acType),
        height(12),
        _buildDetailsRowWidget('MTOW', "${review.mtow} ${review.mtow}"),
        height(12),
        _buildDetailsRowWidget('A/C REG', review.acReg),
        height(12),
        _buildWidgetDetailsRowWidget(
          'SUB REG',
          Wrap(
            direction: Axis.vertical,
            children: review.subAircrafts.map((i) => Text(i.name)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildThirdCardView() {
    return _buildCommonCardView(children: [
      _buildDetailsRowWidget('CREATED BY', "${review.createdBy}"),
      height(12),
      _buildDetailsRowWidget('REQUESTED', "${review.requested}"),
      height(12),
      _buildDetailsRowWidget('REFERENCE', "${review.reference}"),
    ]);
  }

  Widget _buildCommonCardView({required List<Widget> children}) {
    return Container(
      height: spacing140,
      constraints: const BoxConstraints(
        minWidth: spacing140,
        maxWidth: spacing340,
      ),
      padding: const EdgeInsets.all(spacing12),
      decoration: _boxDecoration(),
      child: ListView(
        shrinkWrap: true,
        children: children,
      ),
    );
  }

  _buildDetailsRowWidget(String title, String? details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: reviewSubmitDetailsBoxTitleWidth,
          child: label(title),
        ),
        appText(
          details,
          color: AppColors.charcoalGrey,
        ),
      ],
    );
  }

  _buildWidgetDetailsRowWidget(String title, Widget? details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: reviewSubmitDetailsBoxTitleWidth,
          child: label(title),
        ),
        details ?? Container(),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: AppColors.lightBlueGrey,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(spacing8),
      ),
    );
  }
}
