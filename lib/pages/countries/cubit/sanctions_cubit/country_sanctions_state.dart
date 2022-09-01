part of 'country_sanctions_cubit.dart';

enum FetchSanctionStatus {
  initial,
  loading,
  success,
  failure,
  searchSuccess,
  searchFailed,
}

class CountrySanctionsState extends Equatable {
  final FetchSanctionStatus status;
  final List<Sanction>? sanctions;

  const CountrySanctionsState({
    this.status = FetchSanctionStatus.initial,
    this.sanctions,
  });

  CountrySanctionsState copyWith({
    FetchSanctionStatus? status,
    required List<Sanction> sanctions,
  }) {
    return CountrySanctionsState(
      status: status ?? this.status,
      sanctions: sanctions,
    );
  }

  @override
  List<Object?> get props => [status, sanctions];
}
