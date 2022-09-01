class TripReviewSubmitPOBDetail {
  String surName;
  String givenName;
  String dob;
  String passport;
  String nationality;
  String type;

  TripReviewSubmitPOBDetail({
    required this.surName,
    required this.givenName,
    required this.dob,
    required this.passport,
    required this.nationality,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        "surName": surName,
        "givenName": givenName,
        "dob": dob,
        "passport": passport,
        "nationality": nationality,
        "type": type,
      };
}
