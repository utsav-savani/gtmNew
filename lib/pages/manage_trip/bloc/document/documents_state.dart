import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchDocumentsFilter { initial, loading, success, failure }

class DocumentFilterState extends Equatable {
  final FetchDocumentsFilter status;
  final TripDocumentFilterModel? tripDocumentFilter;

  const DocumentFilterState({
    this.status = FetchDocumentsFilter.initial,
    this.tripDocumentFilter,
  });

  DocumentFilterState copyWith({
    FetchDocumentsFilter? status,
    required TripDocumentFilterModel tripDocumentFilter,
  }) {
    return DocumentFilterState(
      status: status ?? this.status,
      tripDocumentFilter: tripDocumentFilter,
    );
  }

  @override
  List<Object?> get props => [status, tripDocumentFilter];
}
