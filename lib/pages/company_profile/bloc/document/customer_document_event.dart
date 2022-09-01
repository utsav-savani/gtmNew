part of 'customer_document_bloc.dart';

abstract class CustomerDocumentEvent extends Equatable {
  const CustomerDocumentEvent();

  @override
  List<Object> get props => [];
}

class UploadDocumentEvent extends CustomerDocumentEvent {
  final UploadDocument documentData;
  const UploadDocumentEvent(this.documentData);

  @override
  List<Object> get props => [documentData];
}

class GetDocumentsEvent extends CustomerDocumentEvent {
  final int customerId;
  const GetDocumentsEvent(this.customerId);

  @override
  List<Object> get props => [customerId];
}

class UpdateDocumentEvent extends CustomerDocumentEvent {
  final int customerId;
  final int documentId;
  final Object fileToUpload;

  const UpdateDocumentEvent(
      {required this.customerId,
      required this.documentId,
      required this.fileToUpload});

  @override
  List<Object> get props => [customerId, documentId, fileToUpload];
}

class DownloadDocumentEvent extends CustomerDocumentEvent {
  final int docId;

  const DownloadDocumentEvent(this.docId);
}
