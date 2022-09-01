import 'package:http/http.dart' as http;
import 'package:trip_manager_repository/src/models/_pob/trip_pob_schedule_main.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripManagerPOBRepository {
  //MARK:- This is to return the trip manager pob list
  Future<List<TripPobSchedule>> getTripPOBListsOld({
    required String guid,
  }) async {
    List<TripPobSchedule> _pobs = [];

    try {
      final url = Uri.parse(TripManagerUrls().getTripPOBList());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      final _payload = json.encode({"guid": guid});
      print("Payload: $_payload");
      print("=================================\n");
      await http
          .post(url, headers: headers, body: _payload)
          .then((response) async {
        print('===================START==================');
        print(response.body);
        print('===================END==================');
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse['data']['persons'] as List;
          for (var item in responseData) {
            _pobs.add(TripPobSchedule.fromJson(item));
          }
        } else {
          print(response.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _pobs;
  }

  //MARK:- This is to return the trip manager pob list
  Future<TripPobScheduleMain?> getTripPOBLists({
    required String guid,
  }) async {
    try {
      final url = Uri.parse(TripManagerUrls().getTripPOBList());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      final _payload = json.encode({"guid": guid});
      print("Payload: $_payload");
      print("=================================\n");
      return await http
          .post(url, headers: headers, body: _payload)
          .then((response) async {
        print('===================START==================');
        print(response.body);
        print('===================END==================');
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'];
          print(responseData);
          TripPobScheduleMain _pob = TripPobScheduleMain.fromJson(responseData);
          print(_pob);
          return _pob;
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return null;
  }

  //MARK:- This is to return the trip manager pob details
  Future<TripPobDetail?> getTripPOBDetails({
    required int personId,
  }) async {
    TripPobDetail? _pobDetail;

    try {
      final url = Uri.parse(TripManagerUrls().getTripPOBDetails(personId));

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      print("=================================\n");
      await http.get(url, headers: headers).then((response) async {
        print('===================START==================');
        print(response.body);
        print('===================END==================');
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse[0];
          _pobDetail = TripPobDetail.fromJson(responseData);
        } else {
          print(response.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _pobDetail;
  }

  //MARK:- This is to return the trip manager all persons
  Future<List<TripPerson>> getAllPersons({
    required String guid,
  }) async {
    List<TripPerson> _pobs = [];

    try {
      final url = Uri.parse(TripManagerUrls().getTripAllPersons());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      final _payload = json.encode({"guid": guid});
      print("=================================\n");
      await http
          .post(url, headers: headers, body: _payload)
          .then((response) async {
        print(response.body);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _pobs.add(TripPerson.fromJson(item));
          }
        } else {
          print(response.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _pobs;
  }

  Future<bool> savePOBScheduleDetails(
      {required List<SavePOBScheduleDetailsPayload> pobScheduleDetails}) async {
    var _res = false;

    Map<String, dynamic> payload = {
      'persons': pobScheduleDetails.map((e) {
        return {
          'personId': e.personID,
          'personPassportDocumentId': e.personPassportDocumentID,
          'Type': e.type,
          'selectedAirport':
              e.tripScheduleIds.map((id) => {'tripScheduleId': id}).toList()
        };
      }).toList(),
    };

    try {
      final url = Uri.parse(TripManagerUrls().savePOBScheduleDetails());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      final _payload = json.encode(payload);
      print("Payload: $_payload");
      print("=================================\n");
      await http
          .post(url, headers: headers, body: _payload)
          .then((response) async {
        print(response.body);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          _res = true;
        } else {
          print(response.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _res;
  }

  //MARK:- This is to return the trip manager all persons
  Future<bool> editPersonPassportSequence({
    required int personId,
    required int personPassportDocumentId,
    required List<Map<String, dynamic>> selectedAirport,
  }) async {
    var _res = false;

    int? passportDocumentID =
        personPassportDocumentId == 0 ? null : personPassportDocumentId;

    var payload = TripReviewPersonEditSequence(
      personId: personId,
      personPassportDocumentId: passportDocumentID,
      selectedAirport: selectedAirport,
    );

    try {
      final url = Uri.parse(TripManagerUrls().editPersonPassportSequenceUrl());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      final _payload = json.encode(payload.toJson());
      print("Payload: $_payload");
      print("=================================\n");
      await http
          .post(url, headers: headers, body: _payload)
          .then((response) async {
        print(response.body);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          _res = true;
        } else {
          print(response.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _res;
  }

  //MARK:- This is to return the trip manager all persons
  Future<bool> savePOBDetails({
    required List<UnknownPersons> unknownPersons,
  }) async {
    var _res = false;

    if (unknownPersons.isEmpty) {
      return false;
    }

    Map<String, dynamic> payload = {};
    payload['schedule'] = unknownPersons.map((e) {
      return {
        'tripScheduleId': e.tripScheduleID,
        'Unknown': {
          'crewNumber': e.crewCount,
          'PassangerNumber': e.passengerCount
        }
      };
    }).toList();

    try {
      final url = Uri.parse(TripManagerUrls().savePOBDetails());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      final _payload = json.encode(payload);
      print("Payload: $_payload");
      print("=================================\n");
      await http
          .post(url, headers: headers, body: _payload)
          .then((response) async {
        print(response.body);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          _res = true;
        } else {
          print(response.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _res;
  }

  //MARK:- This is to return the trip manager all persons
  Future<bool> deletePersonPassportSequence({
    required int tripPobId,
  }) async {
    var _res = false;

    try {
      final url = Uri.parse(TripManagerUrls()
          .deletePersonPassportSequenceUrl(tripPobId: tripPobId));

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      print("=================================\n");
      await http.delete(url, headers: headers).then((response) async {
        print(response.body);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          _res = true;
        } else {
          print(response.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _res;
  }

  //MARK:- This is to return the trip POB Canpass
  Future<String?> getPOBCanpassDownload({
    required String guid,
    required TripPobSchedule pob,
    required TripPobOffice office,
  }) async {
    try {
      final url = Uri.parse(TripManagerUrls().getPOBDownloadReport());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");
      print("=================================\n");
      print(pob);
      List<TripPOBReportPeoplePayload> _captains =
          <TripPOBReportPeoplePayload>[];
      List<TripPOBReportPeoplePayload> _crews = <TripPOBReportPeoplePayload>[];
      List<TripPOBReportPeoplePayload> _passengers =
          <TripPOBReportPeoplePayload>[];

      for (var item in pob.pobLists!) {
        var people = TripPOBReportPeoplePayload(
          country: item.countryofresidence,
          declarations: '',
          dob: item.dob,
          firstName: item.firstName,
          int: '',
          nationility: item.nationality,
          passport: item.passportNumber,
          passportExpire: item.passportExpireDate,
          sex: item.gender,
          stay: item.stayVal,
          surName: '',
          tripReason: '',
        );
        if (item.type?.toUpperCase() == CAPTAIN) {
          _captains.add(people);
        } else if (item.type?.toUpperCase() == PASSENGER) {
          _passengers.add(people);
        } else if (item.type?.toUpperCase() == CREW) {
          _crews.add(people);
        }
      }

      final TripPOBReportPayload _payload = TripPOBReportPayload(
        eTA: pob.eTa,
        aircraftType: pob.eTD,
        arrival: pob.nextarrivalLocal,
        color: '',
        departure: '',
        departureGen: pob.sourcepointwithicaoiata,
        destination: '',
        destinationGen: pob.destinationpointwithicaoiata,
        fbo: pob.fBOFName,
        flightDate: pob.eTD,
        flightNumber: pob.callSign,
        operator: pob.operatorname,
        serial: '',
        regNo: pob.registrationNumber,
        tripNumber: pob.tripNumber,
        type: 'gendec',
        via: '',
        captains: _captains,
        crew: _crews,
        passenger: _passengers,
        office: office,
      );
      print("=========Payload ends========================\n");
      return await http
          .post(url, headers: headers, body: json.encode(_payload))
          .then((response) async {
        print(response.body);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse['data'] as String;
          return responseData;
        } else {
          print(response.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return null;
  }
}
