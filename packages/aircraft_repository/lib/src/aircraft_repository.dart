import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:js' as js;

class AircraftRepository {
  AircraftRepository();

  AircraftFilter _filter = AircraftFilter();

  void setCustomerId(String id) => _filter.setCustomerId(id);
  void setAircraftId(String id) => _filter.setAircraftId(id);
  void setLimit(String limit) => _filter.setLimit(limit);
  void setPage(String page) => _filter.setPage(page);
  void setSearch(String search) => _filter.setSearch(search);

  //MARK:- This is to return the aircraft list
  Future<List<Aircraft>> getAircrafts() async {
    final url = Uri.parse(AircraftUrls().getAircraftUrl(_filter));

    final headers = await UserRepository().getHeaders();

    List<Aircraft> _response = [];
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(Aircraft.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      print(e);
    }
    return _response;
  }

  //MARK:- This is to return the aircraft list
  Future<List<AircraftDetails>> getDetailedAircrafts() async {
    final url = Uri.parse(AircraftUrls().getDetailedAircraftUrl());

    final headers = await UserRepository().getHeaders();
    List<Customer> customers = await UserRepository().getCustomers();
    print("URL: $url \n Token: ${json.encode(headers)}");
    Map<String, dynamic> body = {};
    if (customers.isNotEmpty) {
      body.putIfAbsent(
          'customers', () => customers.map((e) => e.customerId).toList());
    }
    List<AircraftDetails> _response = [];
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(body))
          .then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;

          for (var item in responseData) {
            _response.add(AircraftDetails.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      print(e);
    }
    return _response;
  }

  Future<AircraftDetails?> getAirCraftDetails(int airCraftId) async {
    final url = Uri.parse(AircraftUrls().getAircraftDetailUrl(airCraftId));

    final headers = await UserRepository().getHeaders();
    print("URL: $url \n Token: ${json.encode(headers)}");

    AircraftDetails? _response;
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          _response = AircraftDetails.fromJson(jsonResponse);
        }
      });
    } catch (e) {
      print(e);
    }
    return _response;
  }

  //MARK:- This is to return the sub aircraft list
  Future<List<Aircraft>> getSubAircrafts(
      {required int aircraftId, required int customerId}) async {
    //TODO: Safi, we need to have both operator and aircraft id to get the subaircrafts
    final url = Uri.parse(
      AircraftUrls().getSubAircraftsUrl(
        _filter,
        aircraftId: aircraftId,
        customerId: customerId,
      ),
    );

    final headers = await UserRepository().getHeaders();
    print("URL: $url \n Token: ${json.encode(headers)}");

    List<Aircraft> _response = [];
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(Aircraft.fromJson(item));
          }
        }
      });
    } catch (e) {
      print(e);
    }
    return _response;
  }

  Future<bool> createAircraft(CreateAircraft aircraft) async {
    final url = Uri.parse(AircraftUrls().createAircraftUrl());
    final headers = await UserRepository().getHeaders();
    bool res = false;
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(aircraft))
          .then((response) async {
        if (response.statusCode == 200) {
          res = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<CreateAircraft?> getAircraftDetails(int aircraftId) async {
    final url = Uri.parse(AircraftUrls().getAircraftDetailUrl(aircraftId));
    CreateAircraft? _response;
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          _response = (CreateAircraft.fromJson(jsonResponse));
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<bool> updateAircraft(CreateAircraft aircraft) async {
    final url =
        Uri.parse(AircraftUrls().updateAircraftUrl(aircraft.aircraftId!));
    final headers = await UserRepository().getHeaders();
    bool res = false;
    try {
      await http
          .put(url, headers: headers, body: jsonEncode(aircraft))
          .then((response) async {
        if (response.statusCode == 200) {
          res = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<List<AircraftType>> getAircraftTypeList() async {
    final url = Uri.parse(AircraftUrls().getAircraftTypeListUrl());
    List<AircraftType> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(AircraftType.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<Customers>> getCustomerList(
      {required int page, int limit = 10}) async {
    final url = Uri.parse(AircraftUrls().getCustomerListUrl(page, limit));
    List<Customers> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(Customers.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<Customers>> getOperatorList(
      {required int page, int limit = 10}) async {
    final url = Uri.parse(AircraftUrls().getOperatorListUrl(page, limit));
    List<Customers> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(Customers.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<Country>> getCountryList() async {
    final url = Uri.parse(AircraftUrls().getCountryListUrl());
    List<Country> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(Country.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<CountryAirport>> getAirportsForCountry(
      int countryId, int page) async {
    final url =
        Uri.parse(AircraftUrls().getCountryAirportListUrl(countryId, page));
    List<CountryAirport> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(CountryAirport.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<bool> uploadAircraftDocuments(UploadDocument document) async {
    bool res = false;
    final url = Uri.parse(AircraftUrls().uploadDocumentUrl());
    final headers = await UserRepository().getHeaders();

    try {
      await http
          .post(url, headers: headers, body: document.toJson())
          .then((response) async {
        if (response.statusCode == 200) {
          res = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<bool> updateAircraftDocument(
      Object fileToUpload, int aircraftId, int documentId) async {
    bool res = false;
    final url = Uri.parse(AircraftUrls().updateDocumentUrl(documentId));
    final headers = await UserRepository().getHeaders();
    Map<String, dynamic> request = {
      "fileToUpload": fileToUpload,
      "id": aircraftId
    };
    try {
      await http
          .put(url, headers: headers, body: jsonEncode(request))
          .then((response) async {
        if (response.statusCode == 200) {
          res = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<List<Document>> getAircraftDocuments(int aircraftId) async {
    final url = Uri.parse(AircraftUrls().getAllDocumentsUrl(aircraftId));
    List<Document> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(Document.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<DocumentType>> getAircraftDocumentType() async {
    final url = Uri.parse(AircraftUrls().getDoctypeUrl());
    List<DocumentType> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(DocumentType.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<AircraftTrips>> getAircraftTrips(
      {required int aircraftId, int page = 0, String search = ''}) async {
    final url = Uri.parse(AircraftUrls().getAircraftTripsUrls());
    List<AircraftTrips> _response = [];
    final headers = await UserRepository().getHeaders();

    // TODO Fetch user officeIds from cache
    List<Office> offices = await UserRepository().getOffices();
    List<Map<String, int>> officeBody = [];
    for (int i = 0; i < offices.length; i++) {
      officeBody.add({"officeId": offices[i].officeId});
    }
    Map<String, dynamic> body = {
      "aircraftId": aircraftId,
      "limit": 100,
      "page": page,
      "search": search,
      "offices": officeBody,
    };

    try {
      await http
          .post(url, headers: headers, body: jsonEncode(body))
          .then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(AircraftTrips.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<String?> downloadDocuments(int docId) async {
    final url = Uri.parse(AircraftUrls().getDownloadDocumentUrl(docId));
    String? res;
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          res = jsonResponse['url'];
          if (res != null) {
            await js.context.callMethod('open', [res]);
          }
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }
}
