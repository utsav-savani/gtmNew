part of 'country_bloc.dart';

enum FetchCountryStatus { initial, loading, success, failure }

class CountryListState extends Equatable {
  final FetchCountryStatus status;
  final List<Country>? countries;

  const CountryListState({
    this.status = FetchCountryStatus.initial,
    this.countries,
  });

  CountryListState copyWith({
    FetchCountryStatus? status,
    required List<Country> countries,
  }) {
    return CountryListState(
      status: status ?? this.status,
      countries: countries,
    );
  }

  @override
  List<Object?> get props => [status, countries];
}
