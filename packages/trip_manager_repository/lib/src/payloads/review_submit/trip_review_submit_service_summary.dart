class TripReviewSubmitServiceDetail {
  String departure;
  String arrival;
  int index;
  String total;
  List<Map<String, dynamic>> serviceDetails;

  TripReviewSubmitServiceDetail({
    required this.departure,
    required this.arrival,
    required this.index,
    required this.total,
    required this.serviceDetails,
  });

  Map<String, dynamic> toJson() => {
        "departure": departure,
        "arrival": arrival,
        "index": index,
        "total": total,
        "serviceDetails": serviceDetails,
      };
}
