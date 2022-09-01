part of 'operator_bloc.dart';

abstract class OperatorEvent extends Equatable {
  const OperatorEvent();

  @override
  List<Object> get props => [];
}

class FetchOperatorData extends OperatorEvent {
  final String aircraftID;
  final List<Operator>? operators;

  const FetchOperatorData({this.aircraftID='',this.operators});

  @override
  List<Object> get props => [operators!];
}
