import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class DocumentsEvent extends Equatable {
  const DocumentsEvent();

  @override
  List<Object> get props => [];
}

class FetchDocumentFilter extends DocumentsEvent {
  final String guid;

  const FetchDocumentFilter({required this.guid});

  @override
  List<Object> get props => [guid];
}

class FetchDocumentURL extends DocumentsEvent {
  final TripManagerDocumentPayload payload;

  const FetchDocumentURL({required this.payload});

  @override
  List<Object> get props => [payload];
}
