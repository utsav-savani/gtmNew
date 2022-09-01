class TripReviewSubmitBasicDetail {
  String tripNumber;
  int? officeId;
  String? customer;
  String? operator;
  String? createdBy;
  String? requested;
  String? reference;
  String? acReg;
  String? acType;
  String? mtow;
  String? timeFormat;
  String? fileName;
  List<Map<String, dynamic>> subAircrafts;
  List<Map<String, dynamic>> flightDetails;
  List<Map<String, dynamic>> currentServiceSummary;
  List<Map<String, dynamic>> currentPobDetails;

  TripReviewSubmitBasicDetail({
    required this.tripNumber,
    required this.officeId,
    required this.acReg,
    required this.acType,
    required this.createdBy,
    required this.customer,
    required this.operator,
    required this.mtow,
    required this.reference,
    required this.requested,
    required this.subAircrafts,
    required this.flightDetails,
    required this.currentServiceSummary,
    required this.currentPobDetails,
    this.fileName,
    this.timeFormat,
  });

  Map<String, dynamic> toJson() => {
        "tripNumber": tripNumber,
        "officeId": officeId,
        "customer": customer,
        "operator": operator,
        "createdBy": createdBy,
        "requested": requested,
        "reference": reference,
        "acReg": acReg,
        "acType": acType,
        "mtow": mtow,
        "timeFormat": timeFormat,
        "fileName": fileName,
        "subAircrafts": subAircrafts,
        "flightDetails": flightDetails,
        "currentServiceSummary": currentServiceSummary,
        "currentPOBDetails": currentPobDetails,
      };
}
