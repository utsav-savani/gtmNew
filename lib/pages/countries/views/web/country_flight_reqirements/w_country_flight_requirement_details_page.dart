import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gtm/_shared/shared.dart';

class WCountryFlightRequirementsDetailsPage extends StatefulWidget {
  final FlightRequirement flightRequirement;

  const WCountryFlightRequirementsDetailsPage(
      {required this.flightRequirement, Key? key})
      : super(key: key);

  @override
  State<WCountryFlightRequirementsDetailsPage> createState() =>
      _WCountryFlightRequirementsDetailsPageState();
}

class _WCountryFlightRequirementsDetailsPageState
    extends State<WCountryFlightRequirementsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    FlightRequirement flightRequirement = widget.flightRequirement;
    String flightCategory;
    String services;
    String required;
    if (flightRequirement.flightCategories != null) {
      flightCategory = flightRequirement.flightCategories!.join(',');
    } else {
      flightCategory = '';
    }
    if (flightRequirement.services != null) {
      services = flightRequirement.services!.join(',');
    } else {
      services = '';
    }
    if (flightRequirement.reqSpecPermit != null) {
      required = flightRequirement.reqSpecPermit! ? 'Yes' : 'No';
    } else {
      required = 'Not Available';
    }
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Text(flightCategory),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                getListTile(
                    key: 'Flight Category',
                    value: flightCategory,
                    key2: 'Services',
                    value2: services),
                getListTile(
                  key: 'Through',
                  value: flightRequirement.through ?? '',
                ),
                getImageAvailable(
                  fplMatchBool: flightRequirement.fplMatch!,
                  specificBool: flightRequirement.reqSpecPermit!,
                  documentReqBool: flightRequirement.docsRequired!,
                  onlineBool: flightRequirement.isOnline!,
                ),
                getListTile(
                    key: 'Lead Time',
                    value: flightRequirement.leadTime ?? '',
                    key2: 'Permit Validity',
                    value2: flightRequirement.permValidity ?? ''),
                getListTile(
                  key: 'Required',
                  value: required,
                ),
                getListTile(
                  key: 'Notes',
                  value: flightRequirement.notes ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getImageAvailable({
    bool fplMatchBool = false,
    bool specificBool = false,
    bool documentReqBool = false,
    bool onlineBool = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: spacing20),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  fplMatchBool
                      ? SvgPicture.asset(AppImages.notAvailableAsset)
                      : SvgPicture.asset(AppImages.onlineAvailabeAsset),
                  const Padding(
                    padding: EdgeInsets.all(spacing10),
                    child: Text(fplMatch),
                  ),
                ],
              ),
              Row(children: [
                specificBool
                    ? SvgPicture.asset(AppImages.notAvailableAsset)
                    : SvgPicture.asset(AppImages.onlineAvailabeAsset),
                const Padding(
                  padding: EdgeInsets.all(spacing10),
                  child: Text(specific),
                ),
              ])
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  documentReqBool
                      ? SvgPicture.asset(AppImages.notAvailableAsset)
                      : SvgPicture.asset(AppImages.onlineAvailabeAsset),
                  const Padding(
                    padding: EdgeInsets.all(spacing10),
                    child: Text(documentReq),
                  ),
                ],
              ),
              Row(
                children: [
                  onlineBool
                      ? SvgPicture.asset(AppImages.notAvailableAsset)
                      : SvgPicture.asset(AppImages.onlineAvailabeAsset),
                  const Padding(
                    padding: EdgeInsets.all(spacing10),
                    child: Text(online),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  getListTile(
      {String key = '',
      String value = '',
      String key2 = '',
      String value2 = ''}) {
    return Row(
      children: [
        () {
          if (key.isNotEmpty) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            key + ':',
                            style:
                                const TextStyle(color: AppColors.charcoalGrey),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(value,
                              style: const TextStyle(
                                  color: AppColors.brownGrey)))),
                ],
              ),
            );
          } else {
            return Expanded(child: Container());
          }
        }(),
        () {
          if (key2.isNotEmpty) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            key2 + ':',
                            style:
                                const TextStyle(color: AppColors.charcoalGrey),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(value2,
                              style: const TextStyle(
                                  color: AppColors.brownGrey)))),
                ],
              ),
            );
          } else {
            return Expanded(child: Container());
          }
        }(),
      ],
    );
  }
}
