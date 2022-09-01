part of 'document_details_cubit.dart';

enum DocumentDetailsStatus { initial, loading, success, failure }

class DocumentDetailsState extends Equatable {
  final DocumentDetailsStatus status;
  final List<DocumentType> documentTypes;

  const DocumentDetailsState(
      {required this.status, required this.documentTypes});

  @override
  List<Object> get props => [status, documentTypes];
}

class DocumentDetailsInitial extends DocumentDetailsState {
  DocumentDetailsInitial({
    required DocumentDetailsStatus status,
  }) : super(status: status, documentTypes: []);
}
