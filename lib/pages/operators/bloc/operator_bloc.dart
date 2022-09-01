import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:operator_repository/operator_repository.dart';

part 'operator_event.dart';
part 'operator_state.dart';

class OperatorBloc extends Bloc<OperatorEvent, OperatorState> {
  final OperatorRepository _operatorRepository;

  OperatorBloc({required OperatorRepository operatorRepository})
      : _operatorRepository = operatorRepository,
        super(const OperatorState()) {
    on<FetchOperatorData>(_getOperatorsData);
  }

  Future<void> _getOperatorsData(
    OperatorEvent event,
    Emitter<OperatorState> emit,
  ) async {
    FetchOperatorData fetchOperatorData = event as FetchOperatorData;
    if(fetchOperatorData.aircraftID.isEmpty){
      return;
    }
    emit(state.copyWith(status: FetchOperatorsStatus.loading, operators: []));
    try {
      final operators = await _operatorRepository.getOperators(aircraftId: fetchOperatorData.aircraftID);
      emit(state.copyWith(
        status: FetchOperatorsStatus.success,
        operators: operators,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchOperatorsStatus.failure, operators: []));
    }
  }
}
