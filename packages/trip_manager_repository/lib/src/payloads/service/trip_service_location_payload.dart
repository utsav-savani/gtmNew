class TripServiceLocationPayload {
  String action;
  int airportId;
  int serviceId;
  String through;
  int tripScheduleId;
  String? eTA;
  String? eTD;

  TripServiceLocationPayload({
    required this.action,
    required this.airportId,
    required this.serviceId,
    required this.through,
    required this.tripScheduleId,
    this.eTA,
    this.eTD,
  });

  Map<String, dynamic> toJson() => {
        "ETA": eTA,
        "ETD": eTD,
        "action": action,
        "airportId": airportId,
        "serviceId": serviceId,
        "through": through,
        "tripScheduleId": tripScheduleId,
      };
}
