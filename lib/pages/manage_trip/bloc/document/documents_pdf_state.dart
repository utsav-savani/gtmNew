import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchDocumentPDFURLState { initial, loading, success, failure }

class DocumentPDFURLState extends Equatable {
  final FetchDocumentPDFURLState status;
  final String? pdfURL;

  const DocumentPDFURLState({
    this.status = FetchDocumentPDFURLState.initial,
    this.pdfURL,
  });

  DocumentPDFURLState copyWith({
    FetchDocumentPDFURLState? status,
    required String pdfURL,
  }) {
    return DocumentPDFURLState(
      status: status ?? this.status,
      pdfURL: pdfURL,
    );
  }

  @override
  List<Object?> get props => [status, pdfURL];
}
