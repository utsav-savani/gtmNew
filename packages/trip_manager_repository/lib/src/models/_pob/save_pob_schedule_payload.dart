class SavePOBScheduleDetailsPayload {
  int personID;
  int? personPassportDocumentID;
  String type;
  List<int> tripScheduleIds;

  SavePOBScheduleDetailsPayload(
      this.personID, this.personPassportDocumentID, this.type, this.tripScheduleIds);
}
