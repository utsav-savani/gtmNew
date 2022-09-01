part of 'country_sanctions_bloc.dart';

enum FetchSanctionStatus { initial, loading, success, failure }

class CountrySanctionState extends Equatable {
  final FetchSanctionStatus status;
  final List<Sanction>? sanctions;

  const CountrySanctionState({
    this.status = FetchSanctionStatus.initial,
    this.sanctions,
  });

  CountrySanctionState copyWith({
    FetchSanctionStatus? status,
    required List<Sanction> sanctions,
  }) {
    return CountrySanctionState(
      status: status ?? this.status,
      sanctions: sanctions,
    );
  }

  @override
  List<Object?> get props => [status, sanctions];
}