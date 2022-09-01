part of 'country_cubit_cubit.dart';

enum FetchCountryStatus { initial, loading, success, failure }

class CountryCubitState extends Equatable {
  final FetchCountryStatus status;
  final List<Country>? countries;

  const CountryCubitState({
    this.status = FetchCountryStatus.initial,
    this.countries,
  });

  CountryCubitState copyWith({
    FetchCountryStatus? status,
    required List<Country> countries,
  }) {
    return CountryCubitState(
      status: status ?? this.status,
      countries: countries,
    );
  }

  @override
  List<Object?> get props => [status, countries];
}
