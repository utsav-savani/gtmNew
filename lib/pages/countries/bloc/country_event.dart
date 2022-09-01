
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class FetchCountryList extends CountryEvent {
  final List<Country>? countries;

  const FetchCountryList({this.countries});

  @override
  List<Object> get props => [countries!];
}

class SearchCountries extends CountryEvent {
  String searchText;

  SearchCountries({this.searchText = ''});

  @override
  List<Object> get props => [searchText];
}

class FetchCountryGeneralInfo extends CountryEvent {
  int countryID;

  FetchCountryGeneralInfo(this.countryID);

  @override
  List<Object> get props => [countryID];
}

class FetchCountryHealthInfo extends CountryEvent {
  int countryID;

  FetchCountryHealthInfo(this.countryID);

  @override
  List<Object> get props => [countryID];
}


class FetchCountryPassportVisaInfo extends CountryEvent {
  int countryID;

  FetchCountryPassportVisaInfo(this.countryID);

  @override
  List<Object> get props => [countryID];
}

class FetchCountrySanctions extends CountryEvent {
  int countryID;

  FetchCountrySanctions(this.countryID);

  @override
  List<Object> get props => [countryID];
}

class SearchCountrySanctions extends CountryEvent {
  String searchText;

  SearchCountrySanctions({this.searchText = ''});

  @override
  List<Object> get props => [searchText];
}

class FetchFlightRequirements extends CountryEvent {
  int countryID;

  FetchFlightRequirements(this.countryID);

  @override
  List<Object> get props => [countryID];
}

class SearchFlightRequirements extends CountryEvent {
  String searchText;

  SearchFlightRequirements({this.searchText = ''});

  @override
  List<Object> get props => [searchText];
}

class FetchCountryAlerts extends CountryEvent {
  int countryID;

  FetchCountryAlerts(this.countryID);

  @override
  List<Object> get props => [countryID];
}

class SearchCountryAlerts extends CountryEvent {
  String searchText;

  SearchCountryAlerts({this.searchText = ''});

  @override
  List<Object> get props => [searchText];
}

