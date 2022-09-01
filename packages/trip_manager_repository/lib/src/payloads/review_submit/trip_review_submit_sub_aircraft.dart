class TripReviewSubmitSubAircraft {
  String name;

  TripReviewSubmitSubAircraft({
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
