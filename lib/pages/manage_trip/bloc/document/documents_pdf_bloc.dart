import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_event.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_pdf_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class DocumentsPDFBloc extends Bloc<DocumentsEvent, DocumentPDFURLState> {
  final TripManagerDocumentsRepository _tripManagerDocumentRepository;

  DocumentsPDFBloc(
      {required TripManagerDocumentsRepository tripManagerDocumentsRepository})
      : _tripManagerDocumentRepository = tripManagerDocumentsRepository,
        super(DocumentPDFURLState()) {
    on<FetchDocumentURL>(_getDocumentURL);
  }

  Future<void> _getDocumentURL(
    DocumentsEvent event,
    Emitter<DocumentPDFURLState> emit,
  ) async {
    emit(state.copyWith(status: FetchDocumentPDFURLState.loading, pdfURL: ''));

    try {
      FetchDocumentURL fetchDocumentURL = event as FetchDocumentURL;
      final pdfURL = await _tripManagerDocumentRepository.getTripDocumentPDFURL(
          payload: fetchDocumentURL.payload);
      emit(state.copyWith(
        status: FetchDocumentPDFURLState.success,
        pdfURL: pdfURL ?? '',
      ));
    } catch (e) {
      log(e.toString());
      emit(
          state.copyWith(status: FetchDocumentPDFURLState.failure, pdfURL: ''));
    }
  }
}
