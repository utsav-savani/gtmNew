part of 'trip_overview_details_cubit.dart';

abstract class TripOverviewDetailsState extends Equatable {
  const TripOverviewDetailsState();

  @override
  List<Object> get props => [];
}

class TripOverviewDetailsInitial extends TripOverviewDetailsState {}

class TripOverviewDetailsLoading extends TripOverviewDetailsState {}

class TripOverviewDetailsFailure extends TripOverviewDetailsState {
  final String failedMessage;

  const TripOverviewDetailsFailure(this.failedMessage);
  @override
  List<Object> get props => [failedMessage];
}

class TripOverviewDetailsSuccess extends TripOverviewDetailsState {
  final TripDetail tripDetail;

  const TripOverviewDetailsSuccess(this.tripDetail);

  @override
  List<Object> get props => [tripDetail];
}

class TripTabChangeInitial extends TripOverviewDetailsState {}

class TripTabChanged extends TripOverviewDetailsState {
  final TabType tabType;
  const TripTabChanged(this.tabType);

  @override
  List<Object> get props => [tabType];
}
