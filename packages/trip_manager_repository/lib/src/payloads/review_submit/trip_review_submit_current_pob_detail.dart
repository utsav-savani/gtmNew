class TripReviewSubmitCurrentPOBDetail {
  String depApt;
  String etd;
  int tripsequenceNumber;
  List<Map<String, dynamic>> pobDetails;

  TripReviewSubmitCurrentPOBDetail({
    required this.depApt,
    required this.etd,
    required this.tripsequenceNumber,
    required this.pobDetails,
  });

  Map<String, dynamic> toJson() => {
        "depApt": depApt,
        "etd": etd,
        "tripsequenceNumber": tripsequenceNumber,
        "pobDetails": pobDetails,
      };
}
