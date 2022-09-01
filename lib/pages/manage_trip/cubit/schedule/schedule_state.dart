part of 'schedule_cubit.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleAddSequence extends ScheduleState {}

class ScheduleAddSequenceLoading extends ScheduleState {}

class ScheduleAddSequenceSuccess extends ScheduleState {
  const ScheduleAddSequenceSuccess(this.schedules);
  final List<TripSchedulePrePayload> schedules;

  @override
  List<Object> get props => [schedules];
}

class ScheduleAddSequenceFailure extends ScheduleState {
  const ScheduleAddSequenceFailure(this.failureMessage);

  final String failureMessage;

  @override
  List<Object> get props => [failureMessage];
}
