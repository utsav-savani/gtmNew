part of 'customer_notes_bloc.dart';

abstract class CustomerNotesEvent extends Equatable {
  const CustomerNotesEvent();

  @override
  List<Object> get props => [];
}

class FetchNotesEvent extends CustomerNotesEvent {
  final int customerId;
  const FetchNotesEvent(this.customerId);
  @override
  List<Object> get props => [customerId];
}

class CreateNoteEvent extends CustomerNotesEvent {
  final CreateNote createNote;
  const CreateNoteEvent(this.createNote);
  @override
  List<Object> get props => [createNote];
}

class UpdateNoteEvent extends CustomerNotesEvent {
  final int customerId;
  final int customerOperationalNoteId;
  final String note;

  const UpdateNoteEvent(
      {required this.customerId,
      required this.customerOperationalNoteId,
      required this.note});
  @override
  List<Object> get props => [customerId, customerOperationalNoteId, note];
}

class DeleteNoteEvent extends CustomerNotesEvent {
  final int customerOperationalNoteId;
  final int customerId;
  const DeleteNoteEvent(
      {required this.customerOperationalNoteId, required this.customerId});
  @override
  List<Object> get props => [customerOperationalNoteId, customerId];
}
