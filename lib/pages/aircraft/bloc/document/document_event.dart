part of 'document_bloc.dart';

class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class FetchDocumentListEvent extends DocumentEvent {
  final int aircraftId;

  const FetchDocumentListEvent(this.aircraftId);

  @override
  List<Object> get props => [aircraftId];
}
