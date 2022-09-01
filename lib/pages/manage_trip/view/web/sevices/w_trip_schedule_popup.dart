import 'package:flutter/material.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class WServicePopup1 extends StatefulWidget {
  final TripServiceModalType type;
  final int airportID;
  final int countryID;

  const WServicePopup1(
      {required this.type, this.airportID = 0, this.countryID = 0, Key? key})
      : assert(type == TripServiceModalType.LOCATION && airportID == 0,
            'Cannot load $type modal without airportID'),
        assert(type == TripServiceModalType.OVERFLY && countryID == 0,
            'Cannot load $type modal without countryID'),
        super(key: key);

  @override
  State<WServicePopup1> createState() => _WServicePopup1State();
}

class _WServicePopup1State extends State<WServicePopup1> {
  @override
  Widget build(BuildContext context) {
    TripModalPopupDetail tripModalPopupDetail = const TripModalPopupDetail();
    return Column(
      children: [
        _buildHeading(''),
        _buildFourColumnRow('Service', tripModalPopupDetail.service ?? '',
            'Status', tripModalPopupDetail.serviceStatus ?? ''),
        _buildFourColumnRow('Schedule', tripModalPopupDetail.service ?? '',
            'Schedule Status', tripModalPopupDetail.serviceStatus ?? ''),
        _buildTwoColumnRow('Through', tripModalPopupDetail.through ?? ''),
        _buildTwoColumnRow('Payment', tripModalPopupDetail.payment ?? ''),
      ],
    );
  }

  Widget _buildHeading(String countryName, {VoidCallback? onPressed}) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.paleGrey,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeadingText('$countryName - Flight Requirements'),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: Color(0xffc5cde4),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildStatusWidget(
      bool fplMatch, bool specific, bool documentsRequired, bool online) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.paleGrey,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        color: AppColors.paleGrey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildStatusItem('FPL Match', fplMatch),
              ),
              Expanded(
                flex: 2,
                child: _buildStatusItem('SPECIFIC', specific),
              ),
              Expanded(
                flex: 2,
                child:
                    _buildStatusItem('Documents Required', documentsRequired),
              ),
              Expanded(
                flex: 2,
                child: _buildStatusItem('Online', online),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String statusText, bool isPass) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isPass)
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.jadeGreen,
          )
        else
          const Icon(
            Icons.cancel,
            color: AppColors.redColor,
          ),
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              statusText,
              style:
                  const TextStyle(color: AppColors.charcoalGrey, fontSize: 13),
            ))
      ],
    );
  }

  Widget _buildTwoColumnRow(String heading, String content) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading),
          ),
          Expanded(
            flex: 6,
            child: _buildContentText(content),
          ),
        ],
      ),
    );
  }

  Widget _buildFourColumnRow(
      String heading, String content, String heading2, String content2) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content),
          ),
          Expanded(
            flex: 2,
            child: _buildHeadingText(heading2),
          ),
          Expanded(
            flex: 2,
            child: _buildContentText(content2),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadingText(String heading) {
    return Text(
      heading + ':',
      style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 14),
    );
  }

  Widget _buildContentText(String content) {
    return Text(
      content,
      style: const TextStyle(color: AppColors.brownGrey, fontSize: 14),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.powderBlue,
    );
  }
}
