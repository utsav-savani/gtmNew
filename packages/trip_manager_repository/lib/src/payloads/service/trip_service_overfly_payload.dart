class TripServiceOverflyPayload {
  String action;
  int tripOverflyId;
  int serviceId;
  String through;
  int tripScheduleId;
  String name;

  TripServiceOverflyPayload({
    required this.action,
    required this.tripOverflyId,
    required this.serviceId,
    required this.through,
    required this.tripScheduleId,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "action": action,
        "name": name,
        "serviceId": serviceId,
        "through": through,
        "tripOverflyId": tripOverflyId,
        "tripScheduleId": tripScheduleId,
      };
}
