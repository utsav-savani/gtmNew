part of 'country_alerts_bloc.dart';

enum FetchCountryAlertStatus { initial, loading, success, failure }

class CountryAlertsState extends Equatable {
  final FetchCountryAlertStatus status;
  final List<Alert>? alerts;

  const CountryAlertsState({
    this.status = FetchCountryAlertStatus.initial,
    this.alerts,
  });

  CountryAlertsState copyWith({
    FetchCountryAlertStatus? status,
    required List<Alert> alerts,
  }) {
    return CountryAlertsState(
      status: status ?? this.status,
      alerts: alerts,
    );
  }

  @override
  List<Object?> get props => [status, alerts];
}