class TripReviewPersonEditSequence {
  int personId;
  int? personPassportDocumentId;
  List<Map<String, dynamic>> selectedAirport;

  TripReviewPersonEditSequence({
    required this.personId,
    required this.personPassportDocumentId,
    required this.selectedAirport,
  });

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "personPassportDocumentId": personPassportDocumentId,
        "selectedAirport": selectedAirport,
      };
}
