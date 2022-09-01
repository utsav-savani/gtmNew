class TripReviewSubmitServiceDetail {
  String serviceType;
  String location;
  String seq;
  String countryOrLoc;
  String on;
  String payment;
  String through;
  String billable;

  TripReviewSubmitServiceDetail({
    required this.serviceType,
    required this.location,
    required this.seq,
    required this.countryOrLoc,
    required this.on,
    required this.payment,
    required this.through,
    required this.billable,
  });

  Map<String, dynamic> toJson() => {
        "serviceType": serviceType,
        "location": location,
        "seq": seq,
        "countryOrLoc": countryOrLoc,
        "on": on,
        "payment": payment,
        "through": through,
        "billable": billable,
      };
}
