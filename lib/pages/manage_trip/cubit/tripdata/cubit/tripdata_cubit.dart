import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tripdata_state.dart';

class TripdataCubit extends Cubit<TripdataState> {
  TripdataCubit() : super(TripdataInitial());
}
