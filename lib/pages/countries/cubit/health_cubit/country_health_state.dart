part of 'country_health_cubit.dart';

abstract class CountryHealthState extends Equatable {
  const CountryHealthState();

  @override
  List<Object> get props => [];
}

class CountryHealthInitial extends CountryHealthState {}

class CountryHealthLoading extends CountryHealthState {}

class CountryHealthFailure extends CountryHealthState {
  final String failureMessage;

  const CountryHealthFailure(this.failureMessage);
  @override
  List<Object> get props => [failureMessage];
}

class CountryHealthSuccess extends CountryHealthState {
  final Health countryHealth;

  const CountryHealthSuccess(this.countryHealth);

  @override
  List<Object> get props => [countryHealth];
}
