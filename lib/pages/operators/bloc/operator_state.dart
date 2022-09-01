part of 'operator_bloc.dart';

enum FetchOperatorsStatus { initial, loading, success, failure }

class OperatorState extends Equatable {
  final FetchOperatorsStatus status;
  final List<Operator>? operators;

  const OperatorState({
    this.status = FetchOperatorsStatus.initial,
    this.operators,
  });

  OperatorState copyWith({
    FetchOperatorsStatus? status,
    required List<Operator> operators,
  }) {
    return OperatorState(
      status: status ?? this.status,
      operators: operators,
    );
  }

  @override
  List<Object?> get props => [status, operators];
}
