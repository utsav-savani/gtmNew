class TripPOBReportPeoplePayload {
  String? surName;
  String? firstName;
  String? int;
  String? dob;
  String? sex;
  String? stay;
  String? tripReason;
  String? declarations;
  String? country;
  String? passport;
  String? nationility;
  String? passportExpire;

  TripPOBReportPeoplePayload({
    this.surName,
    this.firstName,
    this.int,
    this.dob,
    this.sex,
    this.stay,
    this.tripReason,
    this.declarations,
    this.country,
    this.passport,
    this.nationility,
    this.passportExpire,
  });

  Map<String, dynamic> toJson() => {
        "surName": surName,
        "firstName": firstName,
        "int": int,
        "dob": dob,
        "sex": sex,
        "stay": stay,
        "tripReason": tripReason,
        "declarations": declarations,
        "country": country,
        "passport": passport,
        "nationility": nationility,
        "passportExpire": passportExpire,
      };
}
