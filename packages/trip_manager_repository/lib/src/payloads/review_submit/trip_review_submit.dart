class TripReviewSubmit {
  final String guid;
  final Map<String, dynamic> summaryResponse;

  TripReviewSubmit({
    required this.guid,
    required this.summaryResponse,
  });

  Map<String, dynamic> toJson() => {
        "guid": guid,
        "summaryResponse": summaryResponse,
      };
}
