// ignore_for_file: prefer_const_constructors

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'document_details_state.dart';

class DocumentDetailsCubit extends Cubit<DocumentDetailsState> {
  final AircraftRepository _aircraftRepository;
  DocumentDetailsCubit({required AircraftRepository aircraftRepository})
      : _aircraftRepository = aircraftRepository,
        super(DocumentDetailsInitial(status: DocumentDetailsStatus.initial));

  loadDocumentTypes() async {
    try {
      emit(DocumentDetailsState(
          status: DocumentDetailsStatus.loading,
          documentTypes: state.documentTypes));
      final res = await _aircraftRepository.getAircraftDocumentType();
      emit(DocumentDetailsState(
          status: DocumentDetailsStatus.success, documentTypes: res));
    } catch (e) {
      emit(DocumentDetailsState(
          status: DocumentDetailsStatus.failure,
          documentTypes: state.documentTypes));
    }
  }

  createAircraftDocument(CreateAircraft aircraft) async {
    try {
      emit(DocumentDetailsState(
          status: DocumentDetailsStatus.loading,
          documentTypes: state.documentTypes));
      final res = await _aircraftRepository.createAircraft(aircraft);
      if (res) {
        emit(DocumentDetailsState(
            status: DocumentDetailsStatus.success,
            documentTypes: state.documentTypes));
      } else {
        emit(DocumentDetailsState(
            status: DocumentDetailsStatus.failure,
            documentTypes: state.documentTypes));
      }
    } catch (e) {
      emit(DocumentDetailsState(
          status: DocumentDetailsStatus.failure,
          documentTypes: state.documentTypes));
    }
  }

  updateAircraftDocument(CreateAircraft aircraft) async {
    try {
      emit(DocumentDetailsState(
          status: DocumentDetailsStatus.loading,
          documentTypes: state.documentTypes));
      final res = await _aircraftRepository.updateAircraft(aircraft);
      if (res) {
        emit(DocumentDetailsState(
            status: DocumentDetailsStatus.success,
            documentTypes: state.documentTypes));
      } else {
        emit(DocumentDetailsState(
            status: DocumentDetailsStatus.failure,
            documentTypes: state.documentTypes));
      }
    } catch (e) {
      emit(DocumentDetailsState(
          status: DocumentDetailsStatus.failure,
          documentTypes: state.documentTypes));
    }
  }
}
