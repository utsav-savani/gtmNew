import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'customer_notes_event.dart';
part 'customer_notes_state.dart';

class CustomerNotesBloc extends Bloc<CustomerNotesEvent, CustomerNotesState> {
  final CompanyProfileRepository _companyProfileRepository;
  CustomerNotesBloc(
      {required CompanyProfileRepository companyProfileRepository})
      : _companyProfileRepository = companyProfileRepository,
        super(CustomerNotesInitial(status: NoteStatus.initial)) {
    on<FetchNotesEvent>(_getCustomerNotes);
    on<CreateNoteEvent>(_createNewNote);
    on<UpdateNoteEvent>(_updateNote);
    on<DeleteNoteEvent>(_deleteNote);
  }

  FutureOr<void> _getCustomerNotes(
      FetchNotesEvent event, Emitter<CustomerNotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.initial, serviceList: state.serviceList));
    try {
      emit(state.copyWith(
          status: NoteStatus.loading, serviceList: state.serviceList));
      List<Notes> _notes =
          await _companyProfileRepository.getCustomerNotes(event.customerId);
      List<ServiceList> serviceList =
          await _companyProfileRepository.getServiceList();
      emit(state.copyWith(
          status: NoteStatus.success, notes: _notes, serviceList: serviceList));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.initial, serviceList: state.serviceList));
    }
  }

  FutureOr<void> _createNewNote(
      CreateNoteEvent event, Emitter<CustomerNotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.initial, serviceList: state.serviceList));
    try {
      emit(state.copyWith(
          status: NoteStatus.loading, serviceList: state.serviceList));

      await _companyProfileRepository.addNotesToServices(event.createNote);
      List<Notes> _notes = await _companyProfileRepository
          .getCustomerNotes(event.createNote.customerId);

      emit(state.copyWith(
          status: NoteStatus.success,
          notes: _notes,
          serviceList: state.serviceList));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.initial, serviceList: state.serviceList));
    }
  }

  FutureOr<void> _updateNote(
      UpdateNoteEvent event, Emitter<CustomerNotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.initial, serviceList: state.serviceList));
    try {
      emit(state.copyWith(
          status: NoteStatus.loading, serviceList: state.serviceList));
      await _companyProfileRepository.updateNoteToService(
          event.customerOperationalNoteId, event.customerId, event.note);
      List<Notes> _notes =
          await _companyProfileRepository.getCustomerNotes(event.customerId);
      emit(state.copyWith(
          status: NoteStatus.success,
          notes: _notes,
          serviceList: state.serviceList));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.initial, serviceList: state.serviceList));
    }
  }

  FutureOr<void> _deleteNote(
      DeleteNoteEvent event, Emitter<CustomerNotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.initial, serviceList: state.serviceList));
    try {
      emit(state.copyWith(
          status: NoteStatus.loading, serviceList: state.serviceList));
      await _companyProfileRepository
          .deleteNoteToService(event.customerOperationalNoteId);
      List<Notes> _notes =
          await _companyProfileRepository.getCustomerNotes(event.customerId);
      emit(state.copyWith(
          status: NoteStatus.success,
          notes: _notes,
          serviceList: state.serviceList));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.initial, serviceList: state.serviceList));
    }
  }
}
