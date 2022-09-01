import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_event.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class DocumentFilterBloc extends Bloc<DocumentsEvent, DocumentFilterState> {
  final TripManagerDocumentsRepository _tripManagerDocumentRepository;

  DocumentFilterBloc(
      {required TripManagerDocumentsRepository tripManagerDocumentsRepository})
      : _tripManagerDocumentRepository = tripManagerDocumentsRepository,
        super(const DocumentFilterState()) {
    on<FetchDocumentFilter>(_getDocumentFilter);
  }

  Future<void> _getDocumentFilter(
    DocumentsEvent event,
    Emitter<DocumentFilterState> emit,
  ) async {
    FetchDocumentFilter fetchDocumentFilter = event as FetchDocumentFilter;
    if (fetchDocumentFilter.guid.isEmpty) {
      return;
    }

    emit(state.copyWith(
        status: FetchDocumentsFilter.loading,
        tripDocumentFilter: const TripDocumentFilterModel(
            tripId: 0, tripScedule: [], services: [])));
    try {
      final documentFilter = await _tripManagerDocumentRepository
          .getTripDocumentFilter(guid: fetchDocumentFilter.guid);
      emit(state.copyWith(
        status: FetchDocumentsFilter.success,
        tripDocumentFilter: documentFilter ??
            const TripDocumentFilterModel(
                tripId: 0, tripScedule: [], services: []),
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchDocumentsFilter.failure,
          tripDocumentFilter: const TripDocumentFilterModel(
              tripId: 0, tripScedule: [], services: [])));
    }
  }
}
