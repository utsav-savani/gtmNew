class TripServiceSchedulePayload {
  int? tripScheduleId;
  //MARK:- For the below List of Map use the classes TripServiceLocationPayload.toJson for schedule payload & TripServiceOverflyPayload.toJson for overfly section
  List<Map<String, dynamic>>? tripServices;

  TripServiceSchedulePayload({
    required this.tripScheduleId,
    required this.tripServices,
  });

  Map<String, dynamic> toJson() => {
        "tripScheduleId": tripScheduleId,
        "tripServices": tripServices,
      };
}
