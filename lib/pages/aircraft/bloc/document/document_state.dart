part of 'document_bloc.dart';

enum DocummentListState { inital, loading, success, failure }

class DocumentState extends Equatable {
  final DocummentListState status;
  final List<Document> documents;
  const DocumentState({required this.status, required this.documents});

  @override
  List<Object> get props => [status, documents];
}

class DocumentInitial extends DocumentState {
  DocumentInitial({required DocummentListState status})
      : super(status: status, documents: []);
}
