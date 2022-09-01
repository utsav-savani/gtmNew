import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/bloc/home_bloc.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripListStatisticsWidget extends StatefulWidget {
  final TripStatistic tripStatistic;
  final String? selectedCard;
  const TripListStatisticsWidget(
      {Key? key, required this.tripStatistic, this.selectedCard})
      : super(key: key);

  @override
  State<TripListStatisticsWidget> createState() =>
      _TripListStatisticsWidgetState();
}

class _TripListStatisticsWidgetState extends State<TripListStatisticsWidget> {
  @override
  Widget build(BuildContext context) {
    final TripStatistic _trip = widget.tripStatistic;
    return Material(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 90,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              TripStatisticsCard(
                title: 'total',
                value: _trip.total.toString(),
                boxColor: AppColors.total,
                statistic: _trip,
                isSelected: (widget.selectedCard == null ||
                    widget.selectedCard == 'total'),
              ),
              TripStatisticsCard(
                title: 'draft',
                value: _trip.draft.toString(),
                statistic: _trip,
                boxColor: AppColors.draft,
                isSelected: widget.selectedCard == 'draft',
              ),
              TripStatisticsCard(
                title: 'inProgress',
                value: _trip.inProgress.toString(),
                boxColor: AppColors.inProgress,
                statistic: _trip,
                isSelected: widget.selectedCard == 'inprogress',
              ),
              TripStatisticsCard(
                  title: 'completed',
                  value: _trip.completed.toString(),
                  boxColor: AppColors.completd,
                  statistic: _trip,
                  isSelected: widget.selectedCard == 'completed'),
              TripStatisticsCard(
                title: 'cancelled',
                value: _trip.cancelled.toString(),
                boxColor: AppColors.cancelled,
                statistic: _trip,
                isSelected: widget.selectedCard == 'cancelled',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TripStatisticsCard extends StatefulWidget {
  final String title;
  final String value;
  final Color? boxColor;
  final TripStatistic statistic;
  bool isSelected = false;
  TripStatisticsCard(
      {Key? key,
      required this.title,
      required this.value,
      this.boxColor,
      required this.isSelected,
      required this.statistic})
      : super(key: key);

  @override
  State<TripStatisticsCard> createState() => _TripStatisticsCardState();
}

class _TripStatisticsCardState extends State<TripStatisticsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        TripManagerFilter filter = TripManagerFilter();
        if (widget.title != 'total') {
          filter.setStatus(widget.title);
        }
        context.read<HomeBloc>().add(
            FilterAdavnceEvent(filter, false, widget.title, widget.statistic));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: widget.isSelected
                  ? colorFromTripStatus(widget.title).withAlpha(100)
                  : AppColors.whiteColor,
              border:
                  Border.all(color: widget.boxColor ?? Colors.black, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: widget.boxColor ?? AppColors.defaultColor),
                alignment: Alignment.center,
                child: text(widget.title,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.bold)),
                width: 80,
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.value,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold, overflow: TextOverflow.clip),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
