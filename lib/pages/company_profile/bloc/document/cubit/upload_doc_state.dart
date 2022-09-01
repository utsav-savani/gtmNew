part of 'upload_doc_cubit.dart';

enum UploadDocumentStatus { initial, loading, success, failure }

class UploadDocState extends Equatable {
  final UploadDocumentStatus status;
  final List<DocumentType> documentTypes;
  const UploadDocState({required this.status, required this.documentTypes});

  UploadDocState copyWith(
      {required UploadDocumentStatus status,
      required List<DocumentType> documentTypes}) {
    return UploadDocState(status: status, documentTypes: documentTypes);
  }

  @override
  List<Object> get props => [status, documentTypes];
}

class UploadDocInitial extends UploadDocState {
  UploadDocInitial({required UploadDocumentStatus status})
      : super(status: status, documentTypes: []);
}
