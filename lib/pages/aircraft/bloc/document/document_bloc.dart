import 'dart:async';

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'document_event.dart';
part 'document_state.dart';

class AircraftDocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final AircraftRepository _aircraftRepository;
  AircraftDocumentBloc({required AircraftRepository aircraftRepository})
      : _aircraftRepository = aircraftRepository,
        super(DocumentInitial(status: DocummentListState.inital)) {
    on<FetchDocumentListEvent>(_fetchDocumentList);
  }

  FutureOr<void> _fetchDocumentList(
      FetchDocumentListEvent event, Emitter<DocumentState> emit) async {
    try {
      emit(DocumentState(
          status: DocummentListState.loading, documents: state.documents));
      final res =
          await _aircraftRepository.getAircraftDocuments(event.aircraftId);
      emit(DocumentState(status: DocummentListState.success, documents: res));
    } catch (e) {
      emit(DocumentState(
          status: DocummentListState.failure, documents: state.documents));
    }
  }
}
