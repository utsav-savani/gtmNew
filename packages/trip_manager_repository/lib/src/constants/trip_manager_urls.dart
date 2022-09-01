import 'package:flutter_dotenv/flutter_dotenv.dart';

class TripManagerUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  getTripManagerUrl() => "$_baseURL/trip/trip/getTripsBasedOnTeam";

  //MARK:- This is to get the trip statistics details
  getTripManagerStatisticsUrl() => "$_baseURL/trip/trip/tripManagerAnalytics";

  //MARK:- This is to get the trip details
  getTripManagerDetailUrl() => "$_baseURL/trip/gtm/getTripOverviewDetails";

  //MARK:- This is to create the Trip
  createTripManagerUrl() => "$_baseURL/trip/trip";

  //MARK:- This is to update the Trip
  updateTripManagerUrl() => "$_baseURL/trip/trip/update";

  //MARK:- This is to save the Operational Notes
  saveTripOperationNotes() =>
      "$_baseURL/trip/tripOverview/updateOperationalNotesForTrip";

  //MARK:- This is to get the Look up list
  getTripLookUpData(int id) =>
      "$_baseURL/customer/contact/getcustomercontacts/$id";

  //MARK:- This is to get the save Look up data
  saveTripLookUpData() => "$_baseURL/trip/tripOverview/updatePOCContact";

  //MARK:- This is to get trip schedule data
  getTripScheduleData({required String guid}) {
    return "$_baseURL/trip/tripSchedule/getTripSchedule/$guid";
  }

  //MARK:- This is to get trip cancelled schedule data
  getTripCancelScheduleData({required int tripId}) {
    return "$_baseURL/trip/tripSchedule/getRemovedSchedule/$tripId";
  }

  //MARK:- This is to get save trip scheduled data
  // saveTripSchedule({required String guid}) =>
  //     "$_baseURL/trip/tripSchedule/getTripSchedule/$guid";
  saveTripSchedule() => "$_baseURL/trip/tripSchedule/addTripSchedule";

  //MARK:- This is to get get trip service detials
  getTripServicesURL() => "$_baseURL/trip/gtm/services";

  //MARK:- This is to get trip detailed modal popup
  getTripServiceModalPopupDetailsURL(String type, int id) =>
      "$_baseURL/trip/gtm/service/$type/$id";

  //MARK:- This is to get trip POB List data
  getTripPOBList() => "$_baseURL/trip/gtm/tripPersons";

  //MARK:- This is to get trip POB List data
  getTripPOBDetails(int personId) => "$_baseURL/trip/tripPob/$personId";

  //MARK:- This is to get trip POB List data
  getTripAllPersons() => "$_baseURL/trip/tripPob";

  //MARK:- This is to get trip POB Download Report(canpass...)
  getPOBDownloadReport() => "$_baseURL/tripDocument/getPOBPCanPassDFData";

  //MARK:- This is to update trip person passport sequence
  editPersonPassportSequenceUrl() => "$_baseURL/trip/tripPob/updatePassport";

  //MARK:- This is to save pob schedule details
  savePOBScheduleDetails() => "$_baseURL/trip/tripPob/savePOBScheduleDetails";

  //MARK:- This is to save pob details
  savePOBDetails() => "$_baseURL/trip/tripPob/savepob";

  //MARK:- This is to delete trip person passport sequence
  deletePersonPassportSequenceUrl({required int tripPobId}) =>
      "$_baseURL/trip/tripPob/$tripPobId";

  //MARK:- This is to get trip scheduled Filter Data
  getTripDocumentFilterData() => "$_baseURL/tripDocument/brief/getbriefsearch";

  //MARK:- This is to get trip scheduled data
  getTripBriedDataPDFUrl() => "$_baseURL/tripDocument/brief/getgtmbriefdata";

  //MARK:- This is to get  trip review details
  getTripManagerReviewDetails(String guid) => "$_baseURL/trip/gtm/$guid";

  //MARK:- This is to get  trip review and save final payload
  saveTripReviewUrl() => "$_baseURL/tripDocument/submitChanges";

  //MARK:- This is to get the flight requirements
  getCountryFightRequirementUrl({required int countryId}) =>
      "$_baseURL/country/gtm/requirements/$countryId";

  //MARK:- This is to get the Airport flight requirements
  getAirportFightRequirementUrl({required int airportId}) =>
      "$_baseURL/country/gtm/airportRequirements/$airportId";

  //MARK:- This is to get the Airport Detail requirements
  getAirportDetailRequirementUrl({required int airportId}) =>
      "$_baseURL/airport/gtm/$airportId";

  //MARK:- This is to save service modal popup details
  getServiceModalPopupSaveDetailsAPIUrl(
          {required String type, required int serviceId}) =>
      "$_baseURL/trip/gtm/service/$type/$serviceId";

  //MARK:- This is to save service details
  getServiceSaveDetailsAPIUrl() => "$_baseURL/trip/tripServices";
}
