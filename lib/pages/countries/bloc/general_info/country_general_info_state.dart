part of 'country_general_info_bloc.dart';

enum FetchGeneralInfoStatus { initial, loading, success, failure }

class CountryGeneralInfoState extends Equatable {
  final FetchGeneralInfoStatus status;
  final Country? country;

  const CountryGeneralInfoState({
    this.status = FetchGeneralInfoStatus.initial,
    this.country,
  });

  CountryGeneralInfoState copyWith({
    FetchGeneralInfoStatus? status,
    required Country? country,
  }) {
    return CountryGeneralInfoState(
      status: status ?? this.status,
      country: country,
    );
  }

  @override
  List<Object?> get props => [status, country];
}