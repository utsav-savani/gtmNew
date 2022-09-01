part of 'customer_notes_bloc.dart';

enum NoteStatus { initial, loading, success, failure }

class CustomerNotesState extends Equatable {
  final NoteStatus status;
  final List<Notes>? notes;
  final List<ServiceList> serviceList;
  const CustomerNotesState(
      {required this.status, this.notes, required this.serviceList});

  CustomerNotesState copyWith(
      {required NoteStatus status,
      List<Notes>? notes,
      required List<ServiceList> serviceList}) {
    return CustomerNotesState(
        status: status, notes: notes, serviceList: serviceList);
  }

  @override
  List<Object?> get props => [status, notes, serviceList];
}

class CustomerNotesInitial extends CustomerNotesState {
  CustomerNotesInitial({required NoteStatus status})
      : super(status: status, serviceList: []);
}
