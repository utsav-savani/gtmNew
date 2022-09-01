class TripReviewSubmitSubAircraft {
  String depApt;
  String arrApt;
  String callSign;
  String flightCategory;
  String purpose;
  String sectorSts;
  String etd;
  String eta;
  String etdFormat;

  TripReviewSubmitSubAircraft({
    required this.arrApt,
    required this.callSign,
    required this.depApt,
    required this.eta,
    required this.etd,
    required this.etdFormat,
    required this.flightCategory,
    required this.purpose,
    required this.sectorSts,
  });

  Map<String, dynamic> toJson() => {
        "depApt": depApt,
        "arrApt": arrApt,
        "callSign": callSign,
        "flightCategory": flightCategory,
        "purpose": purpose,
        "sectorSts": sectorSts,
        "etd": etd,
        "eta": eta,
        "etdFormat": etdFormat,
      };
}
