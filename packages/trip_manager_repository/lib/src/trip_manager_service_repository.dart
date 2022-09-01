import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum TripServiceModalType { LOCATION, OVERFLY }

class TripManagerServiceRepository {
  //MARK:- This is to return the trip manager service detail list
  Future<TripServiceMain?> getTripServiceDetails({required String guid}) async {
    TripServiceMain? tripServiceDetail;

    try {
      final url = Uri.parse(TripManagerUrls().getTripServicesURL());
      final headers = await UserRepository().getHeaders();
      final _payload = {"guid": guid};
      print("$url \n $headers");
      print(json.encode(_payload));
      await http
          .post(url, headers: headers, body: json.encode(_payload))
          .then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          tripServiceDetail = TripServiceMain.fromJson(response);
          print("==");
          return tripServiceDetail;
        } else {
          print(value.body);
        }
      });
      print("======");
    } catch (e) {
      print(e);
      debugPrint(e.toString());
    }

    return tripServiceDetail;
  }

  //MARK:- This is to return the trip manager modal popup detailed data
  Future<TripModalPopupDetail?> getTripServiceDetailedModalPopup(
      {required TripServiceModalType type, required int typeId}) async {
    TripModalPopupDetail? tripServiceDetail;

    try {
      final url = Uri.parse(TripManagerUrls()
          .getTripServiceModalPopupDetailsURL(type.name.toLowerCase(), typeId));
      final headers = await UserRepository().getHeaders();
      print("$url \n $headers");
      await http.get(url, headers: headers).then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          final responseData = response['data'];
          tripServiceDetail = TripModalPopupDetail.fromJson(responseData);
          print("Start: ==");
          print(tripServiceDetail);
          print("End: ==");
          return tripServiceDetail;
        } else {
          print(value.body);
        }
      });
      print("======");
    } catch (e) {
      print(e);
      debugPrint(e.toString());
    }

    return tripServiceDetail;
  }

  //MARK:- This is to return the trip manager service flight country requirement
  Future<List<CountryAirportRequirement>?> getFlightCountryRequirement(
      {required int countryId}) async {
    List<CountryAirportRequirement> countryAirportRequirements =
        <CountryAirportRequirement>[];
    try {
      final url = Uri.parse(TripManagerUrls()
          .getCountryFightRequirementUrl(countryId: countryId));
      final headers = await UserRepository().getHeaders();
      print("$url \n $headers");
      await http.get(url, headers: headers).then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          final responseData = response['data'] as List;
          for (var item in responseData) {
            countryAirportRequirements
                .add(CountryAirportRequirement.fromJson(item));
          }
          print("==");
          return countryAirportRequirements;
        } else {
          print(value.body);
        }
      });
      print("======");
    } catch (e) {
      print(e);
      debugPrint(e.toString());
    }

    return countryAirportRequirements;
  }

  //MARK:- This is to return the trip manager service flight country requirement
  Future<List<CountryAirportRequirement>?> getFlightAirportRequirement(
      {required int airportId}) async {
    List<CountryAirportRequirement> countryAirportRequirements =
        <CountryAirportRequirement>[];

    try {
      final url = Uri.parse(TripManagerUrls()
          .getAirportFightRequirementUrl(airportId: airportId));
      final headers = await UserRepository().getHeaders();
      print("$url \n $headers");
      await http.get(url, headers: headers).then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          final responseData = response['data'] as List;
          for (var item in responseData) {
            countryAirportRequirements
                .add(CountryAirportRequirement.fromJson(item));
          }
          print("==");
          return countryAirportRequirements;
        } else {
          print(value.body);
        }
      });
      print("======");
    } catch (e) {
      print(e);
      debugPrint(e.toString());
    }

    return countryAirportRequirements;
  }

  //MARK:- This is to return the trip manager service flight country requirement
  Future<AirportDetailRequirement?> getAirportRequirement(
      {required int airportId}) async {
    AirportDetailRequirement? airportDetailRequirement;

    try {
      final url = Uri.parse(TripManagerUrls()
          .getAirportDetailRequirementUrl(airportId: airportId));
      final headers = await UserRepository().getHeaders();
      print("$url \n $headers");
      await http.get(url, headers: headers).then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          airportDetailRequirement =
              AirportDetailRequirement.fromJson(response);
          print("==");
          return airportDetailRequirement;
        } else {
          print(value.body);
        }
      });
      print("======");
    } catch (e) {
      print(e);
      debugPrint(e.toString());
    }

    return airportDetailRequirement;
  }

  //MARK:- This is to return the trip manager service flight country requirement
  Future<bool?> saveServiceModalPopupDetail(
      {required TripServiceModalType type,
      required int serviceId,
      required TripServiceModalPopupPayload
          tripServiceModalPopupPayload}) async {
    var res;

    try {
      final url = Uri.parse(TripManagerUrls()
          .getServiceModalPopupSaveDetailsAPIUrl(
              serviceId: serviceId, type: type.name.toLowerCase()));
      final headers = await UserRepository().getHeaders();
      print("$url \n $headers");
      print("Payload: ${json.encode(tripServiceModalPopupPayload.toJson())}");
      await http
          .put(url,
              headers: headers,
              body: json.encode(tripServiceModalPopupPayload.toJson()))
          .then((value) async {
        print(value.body);
        res = value.statusCode == 200;
      });
      print("======");
    } catch (e) {
      debugPrint(e.toString());
    }

    return res;
  }

  //MARK:- This is to return the trip manager service flight country requirement
  Future<bool?> saveTripService({
    required String guid,
    required int flightCategoryId,
    required List<TripServiceSchedulePayload> tripServiceSchedulePayload,
  }) async {
    var res;

    try {
      final url = Uri.parse(TripManagerUrls().getServiceSaveDetailsAPIUrl());
      final headers = await UserRepository().getHeaders();
      print("$url \n $headers");
      var _tripSchedule = [];
      for (var item in tripServiceSchedulePayload) {
        _tripSchedule.add(item.toJson());
      }
      Map _payloadObj = {
        "services": {
          "guid": guid,
          "flightCategoryId": flightCategoryId,
          "tripSchedule": _tripSchedule,
        }
      };
      var _payload = json.encode(_payloadObj);
      print("Payload: $_payload");
      await http
          .post(url, headers: headers, body: _payload)
          .then((value) async {
        print(value.body);
        res = value.statusCode == 200;
      });
      return true;
      print("======");
    } catch (e) {
      print(e);
      debugPrint(e.toString());
    }
    return res;
  }
}
