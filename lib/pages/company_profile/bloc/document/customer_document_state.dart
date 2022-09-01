part of 'customer_document_bloc.dart';

enum DocumentStatus { initial, loading, success, failure }

class CustomerDocumentState extends Equatable {
  final DocumentStatus status;
  final List<Documents> documents;
  const CustomerDocumentState({required this.status, required this.documents});

  CustomerDocumentState copyWith(
      {required DocumentStatus status, required List<Documents> documents}) {
    return CustomerDocumentState(status: status, documents: documents);
  }

  @override
  List<Object> get props => [status];
}

class CustomerDocumentInitial extends CustomerDocumentState {
  CustomerDocumentInitial({required DocumentStatus status})
      : super(status: status, documents: []);
}
