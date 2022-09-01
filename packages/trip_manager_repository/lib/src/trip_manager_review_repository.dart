import 'package:http/http.dart' as http;
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripManagerReviewRepository {
  //MARK:- This is to return the trip manager review details
  Future<TripManagerReview> getTripReviewDetails({
    required String guid,
  }) async {
    var _res;

    try {
      final url =
          Uri.parse(TripManagerUrls().getTripManagerReviewDetails(guid));

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      print("=================================\n");
      await http.get(url, headers: headers).then((value) async {
        //print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          _res = TripManagerReview.fromJson(response['data']);
          return _res;
        } else {
          print(value.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }
    return _res;
  }

  //MARK:- This is to return the trip manager review details
  Future<bool> saveTripDetails({
    required String guid,
  }) async {
    var _res = true;

    try {
      TripManagerReview readyToGeneratePayload =
          await getTripReviewDetails(guid: guid);

      final _payload = _generateFinalPayload(readyToGeneratePayload, guid);
      final url = Uri.parse(TripManagerUrls().saveTripReviewUrl());
      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      print("Payload: ${json.encode(_payload.toJson())}");
      print("=================================\n");
      await http
          .post(url, headers: headers, body: json.encode(_payload.toJson()))
          .then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final response = jsonDecode(value.body);
          print(response);
          return response;
          // _res ;
        } else {
          print(value.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _res;
  }

  TripReviewSubmit _generateFinalPayload(
      TripManagerReview tripManagerReview, guid) {
    List<Map<String, dynamic>> _subAircrafts = [];
    for (var subaircraft in tripManagerReview.subAircrafts) {
      _subAircrafts.add(subaircraft.toJson());
    }
    List<Map<String, dynamic>> _flightDetails = [];
    for (var flightDetail in tripManagerReview.flightDetails) {
      _flightDetails.add(flightDetail.toJson());
    }
    List<Map<String, dynamic>> _currentServiceSummary = [];
    for (var summary in tripManagerReview.currentServiceSummary) {
      _currentServiceSummary.add(summary.toJson());
    }
    List<Map<String, dynamic>> _currentPobDetails = [];
    for (var pob in tripManagerReview.currentPOBDetails) {
      _currentPobDetails.add(pob.toJson());
    }

    final TripReviewSubmitBasicDetail tripReviewSubmitBasicDetail =
        TripReviewSubmitBasicDetail(
      acReg: tripManagerReview.acReg,
      acType: tripManagerReview.acType,
      createdBy: tripManagerReview.createdBy,
      customer: tripManagerReview.customer,
      fileName: tripManagerReview.fileName,
      mtow: tripManagerReview.mtow,
      operator: tripManagerReview.operator,
      reference: tripManagerReview.reference,
      officeId: tripManagerReview.officeId,
      requested: tripManagerReview.requested,
      timeFormat: tripManagerReview.timeFormat,
      tripNumber: tripManagerReview.tripNumber!,
      subAircrafts: _subAircrafts,
      flightDetails: _flightDetails,
      currentServiceSummary: _currentServiceSummary,
      currentPobDetails: _currentPobDetails,
    );

    TripReviewSubmit _res = TripReviewSubmit(
      guid: guid,
      summaryResponse: tripReviewSubmitBasicDetail.toJson(),
    );
    return _res;
  }
}
