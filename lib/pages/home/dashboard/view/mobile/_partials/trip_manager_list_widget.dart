// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/section_header_widget.dart';
import 'package:gtm/_shared/widgets/trip_status_card_widget.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripManagerListWidget extends StatefulWidget {
  const TripManagerListWidget({Key? key}) : super(key: key);

  @override
  State<TripManagerListWidget> createState() => _TripManagerListWidgetState();
}

class _TripManagerListWidgetState extends State<TripManagerListWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 172,
        child: BlocBuilder<TripBloc, TripListState>(
          builder: (BuildContext context, TripListState state) {
            switch (state.status) {
              case FetchTripStatus.initial:
              case FetchTripStatus.loading:
                return loadingWidget();
              case FetchTripStatus.success:
                if (state.trips == null || state.trips!.isEmpty) {
                  return emptyStateWidget(text: "No Trips Found");
                }
                List<Trip> trips = state.trips ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: trips.length,
                  itemBuilder: (BuildContext context, int index) {
                    final trip = trips[index];
                    return _buildListViewWidget(trip: trip);
                  },
                );
              case FetchTripStatus.failure:
                return errorWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildListViewWidget({required Trip trip}) {
    String? startDate;
    startDate = trip.start;
    if (startDate != "") {
      startDate = convertDateStringToHumanReadableFormat(startDate);
    }
    String? endDate;
    endDate = trip.end;
    if (endDate != "") {
      endDate = convertDateStringToHumanReadableFormat(endDate);
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(minHeight: 144),
      child: InkWell(
        onTap: () => _navigateToDetailScreen(trip),
        child: Card(
          child: Column(
            children: [
              SectionHeaderWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    underLineText(
                      child: Text(
                        trip.tripNumber,
                        style: const TextStyle(color: AppColors.whiteColor),
                      ),
                      color: AppColors.whiteColor,
                    ),
                    Row(
                      children: [
                        appText(
                          "Reg No.",
                          textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        width(4),
                        Text(
                          trip.regNo,
                          style: const TextStyle(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                    TripStatusCardWidget(tripStatuss: trip.tripStatus),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _buildListMultipeRow(
                      label1: 'Operator',
                      value1: trip.operator.camelCase(),
                      label2: 'Callsign',
                      value2: trip.callsign,
                    ),
                    height(4),
                    _buildListMultipeRow(
                      label1: 'Aircraft Type',
                      value1: trip.acType.camelCase(),
                      label2: 'Start',
                      value2: startDate,
                    ),
                    height(4),
                    _buildListMultipeRow(
                      label1: 'File Status',
                      value1: trip.fileStatus.camelCase(),
                      label2: 'End',
                      value2: endDate,
                    ),
                    if (trip.route != null) height(4),
                    if (trip.route != null)
                      _buildTripListCardLabelValue(
                        context,
                        label: 'Route',
                        value: trip.route!.join(', '),
                      ),
                    height(4),
                    _buildTripListCardLabelValue(
                      context,
                      label: 'Flight Category',
                      value: trip.flightCategory.camelCase(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListMultipeRow({
    required String label1,
    required String label2,
    required String value1,
    required String value2,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 84,
            child: appText(
              label1,
              textStyle: const TextStyle(color: AppColors.brownGrey),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 244,
            child: Text(
              "$value1",
              style: const TextStyle(fontSize: spacing13),
            ),
          ),
          SizedBox(
            width: 136,
            child: _buildTripListCardLabelValue(
              context,
              label: label2,
              value: value2,
              width: 54,
            ),
          ),
        ],
      ),
    );
  }

  Row _buildTripListCardLabelValue(
    context, {
    required String label,
    required String value,
    TextStyle? textStyle,
    fontSize,
    color,
    fontWeight,
    textAlign,
    double? width,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: width ?? 84,
          child: appText(
            label,
            textStyle: const TextStyle(
              color: AppColors.brownGrey,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(width: 2),
        SizedBox(
          height: 16,
          child: Text(
            "$value",
            textAlign: textAlign ?? TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: textStyle ??
                TextStyle(
                  fontSize: fontSize != null ? fontSize.toDouble() : 13,
                  color: color ?? AppColors.blackColor,
                  fontWeight: fontWeight ?? FontWeight.normal,
                ),
          ),
        ),
      ],
    );
  }

  void _navigateToDetailScreen(Trip trip) {
    context.push(Routes.tripDetailsScreen, extra: trip.guid);
  }
}
