import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_state.dart';
import 'package:gtm/pages/home/dashboard/dashboard_event.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripManagerAnalyticsWidget extends StatefulWidget {
  const TripManagerAnalyticsWidget({Key? key}) : super(key: key);

  @override
  State<TripManagerAnalyticsWidget> createState() =>
      _TripManagerAnalyticsWidgetState();
}

class _TripManagerAnalyticsWidgetState
    extends State<TripManagerAnalyticsWidget> {
  late final TripBloc mTripBloc;

  TripStatisticType _tripStatisticType = TripStatisticType.total;

  @override
  void didChangeDependencies() {
    mTripBloc = BlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripStatisticBloc, TripStatisticsState>(
      builder: (context, state) {
        TripStatistic tripStatistic = state.tripStatistic ??
            const TripStatistic(
              total: 0,
              completed: 0,
              inProgress: 0,
              draft: 0,
              cancelled: 0,
            );
        switch (state.status) {
          case FetchTripStatisticsStatus.initial:
          case FetchTripStatisticsStatus.loading:
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: loadingWidget(),
            );
          case FetchTripStatisticsStatus.success:
            return SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 4,
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildAnalyticsCard(
                      borderColor: AppColors.lightBlueGrey,
                      title: 'Total',
                      value: "${tripStatistic.total}",
                      tripStatisticType: TripStatisticType.total,
                    ),
                    _buildAnalyticsCard(
                      borderColor: AppColors.palePeach,
                      title: 'Draft',
                      value: "${tripStatistic.draft}",
                      tripStatisticType: TripStatisticType.draft,
                    ),
                    _buildAnalyticsCard(
                      borderColor: AppColors.apricot,
                      title: 'In Progress',
                      value: "${tripStatistic.inProgress}",
                      tripStatisticType: TripStatisticType.inProgress,
                    ),
                    _buildAnalyticsCard(
                      borderColor: AppColors.greenish,
                      title: 'Completed',
                      value: "${tripStatistic.completed}",
                      tripStatisticType: TripStatisticType.completed,
                    ),
                    _buildAnalyticsCard(
                      borderColor: AppColors.redColor,
                      title: 'Cancelled',
                      value: "${tripStatistic.cancelled}",
                      tripStatisticType: TripStatisticType.cancelled,
                    ),
                  ],
                ),
              ),
            );
          case FetchTripStatisticsStatus.failure:
            return errorWidget();
        }
      },
    );
  }

  Widget _buildAnalyticsCard({
    required String title,
    required String value,
    required Color borderColor,
    required TripStatisticType tripStatisticType,
  }) {
    Color? _color =
        tripStatisticType == _tripStatisticType ? borderColor : null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.charcoalGrey,
            ),
          ),
          height(8),
          Container(
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                width: 2,
                color: borderColor,
              ),
            ),
            child: InkWell(
              onTap: () {
                if (_tripStatisticType == tripStatisticType) {
                  _tripStatisticType = TripStatisticType.total;
                } else {
                  _tripStatisticType = tripStatisticType;
                }
                mTripBloc.add(
                  FilterByTripStatistics(tripStatisticType: _tripStatisticType),
                );
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 24.0,
                ),
                child: Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
