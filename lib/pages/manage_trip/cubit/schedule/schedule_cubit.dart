import 'package:bloc/bloc.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit({required this.tripManagerScheduleRepository}) : super(ScheduleInitial());
  final TripManagerScheduleRepository tripManagerScheduleRepository;

  Future<void> addSequence(List<TripSchedule> schedules) async {
    emit(ScheduleAddSequenceLoading());
    try {
      final items = await tripManagerScheduleRepository.generateTripSchedulePayload(schedules: schedules);
      emit(ScheduleAddSequenceSuccess(items));
    } catch (e) {
      log(e.toString());
      emit(ScheduleAddSequenceFailure(e.toString()));
    }
  }

  Future<void> removeSequence(int schedule) async {
    emit(ScheduleAddSequenceLoading());
    try {
      final items = await tripManagerScheduleRepository.removeSchedule(index: schedule);
      emit(ScheduleAddSequenceSuccess(items));
    } catch (e) {
      log(e.toString());
      emit(ScheduleAddSequenceFailure(e.toString()));
    }
  }

  Future<void> updatedSequence() async {
    emit(ScheduleAddSequenceLoading());
    try {
      final items = await tripManagerScheduleRepository.getUpdatedPayload();
      emit(ScheduleAddSequenceSuccess(items));
    } catch (e) {
      log(e.toString());
      emit(ScheduleAddSequenceFailure(e.toString()));
    }
  }
}
