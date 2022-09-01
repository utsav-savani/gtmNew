import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum EditDeletePOBSequenceStatus { initial, loading, success, failure }

class EditDeletePOBSequenceBloc extends Bloc<POBEvent, EditDeletePOBSequenceStatus> {
  final TripManagerPOBRepository _tripManagerPOBRepository;

  EditDeletePOBSequenceBloc({required TripManagerPOBRepository tripManagerPOBRepository})
      : _tripManagerPOBRepository = tripManagerPOBRepository,
        super(EditDeletePOBSequenceStatus.initial) {
    on<DeletePOBSequence>(_deletePOBPerson);
    on<EditPersonPassportSequence>(_editPersonPassportSequence);
  }

  Future<void> _editPersonPassportSequence(
      POBEvent event,
      Emitter<EditDeletePOBSequenceStatus> emit,
      ) async {
    EditPersonPassportSequence editPOBSequence = event as EditPersonPassportSequence;
    if (editPOBSequence.personID == 0) {
      return;
    }
    emit(EditDeletePOBSequenceStatus.loading);
    try {
      final pobSequenceEdited = await _tripManagerPOBRepository
          .editPersonPassportSequence(personId: editPOBSequence.personID,personPassportDocumentId: editPOBSequence.personPassportDocumentID,selectedAirport: editPOBSequence.selectedAirports);
      emit(pobSequenceEdited
          ? EditDeletePOBSequenceStatus.success
          : EditDeletePOBSequenceStatus.failure);
    } catch (e) {
      log(e.toString());
      emit(EditDeletePOBSequenceStatus.failure);
    }
  }

  Future<void> _deletePOBPerson(
    POBEvent event,
    Emitter<EditDeletePOBSequenceStatus> emit,
  ) async {
    DeletePOBSequence deletePOBSequence = event as DeletePOBSequence;
    if (deletePOBSequence.tripPobId == 0) {
      return;
    }
    emit(EditDeletePOBSequenceStatus.loading);
    try {
      final pobSequenceDeleted = await _tripManagerPOBRepository
          .deletePersonPassportSequence(tripPobId: deletePOBSequence.tripPobId);
      emit(pobSequenceDeleted
          ? EditDeletePOBSequenceStatus.success
          : EditDeletePOBSequenceStatus.failure);
    } catch (e) {
      log(e.toString());
      emit(EditDeletePOBSequenceStatus.failure);
    }
  }
}
