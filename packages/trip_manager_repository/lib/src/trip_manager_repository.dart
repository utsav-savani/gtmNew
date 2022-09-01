import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trip_manager_repository/trip_manager_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripManagerRepository {
  late List<Trip> tripList;
  TripDataTable? dataTableSource;
  TripManagerFilter _filter = TripManagerFilter();

  TripManagerPayload _payload = TripManagerPayload();
  TripOperationalNotePayload _operationPayload = TripOperationalNotePayload();
  TripLookUpPayload _tripLookupPayload = TripLookUpPayload();

  void setPage(int? page) => _filter.setPage(page);
  void setLimit(int? limit) => _filter.setLimit(limit);
  void setFromDate(String fromDate) => _filter.setFromDate(fromDate);
  void setToDate(String toDate) => _filter.setToDate(toDate);
  void setSearch(String searchText) => _filter.setSearch(searchText);
  void setSearchBy(String searchBy) => _filter.setSearchBy(searchBy);
  void setStatus(String status) => _filter.setStatus(status);

  Future<TripDataTable> populateDataTableTrip(List<Trip> tripList) async {
    dataTableSource = TripDataTable(tripList);
    return dataTableSource!;
  }

  //MARK:- This function can be used when we initiate the offline feature
  //MARK: This function is used to save the trip number to draft
  Future<bool> saveTripDataSharedPref({required TripDetail tripDetail}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? tripNumber = tripDetail.tripNumber;
    if (tripNumber != null) {
      List<String>? tripDrafts = pref.getStringList('trip_drafts');
      if (tripDrafts != null && !tripDrafts.contains(tripNumber)) {
        tripDrafts.add(tripNumber);
        pref.setStringList('trip_drafts', tripDrafts);
      }
    }
    return true;
  }

  //MARK: This function is used to save the trip number to draft
  Future<bool> removeTripDataSharedPref({
    required TripDetail tripDetail,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? tripNumber = tripDetail.tripNumber;
    bool _isTripDraft = await isTripDraft(tripDetail: tripDetail);

    if (_isTripDraft) {
      List<String>? tripDrafts = await pref.getStringList('trip_drafts');
      if (tripDrafts != null) {
        tripDrafts.remove(tripNumber);
      }
    }
    return true;
  }

  //MARK: This function is used to check the trip number is draft or not
  Future<bool> isTripDraft({required TripDetail tripDetail}) async {
    String? tripNumber = tripDetail.tripNumber;
    if (tripNumber != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? tripDrafts = pref.getStringList('trip_drafts');
      if (tripDrafts != null && tripDrafts.contains(tripNumber)) {
        return true;
      }
    }
    return false;
  }

  //MARK: This function is used to return you with the prefix if the trip is draft
  Future<String> getTripNumberFromSharedPref({
    required TripDetail tripDetail,
  }) async {
    String? tripNumber = tripDetail.tripNumber;
    bool _isTripDraft = await isTripDraft(tripDetail: tripDetail);
    if (_isTripDraft) {
      return "D$tripNumber";
    }
    return tripNumber ?? '-';
  }

  //MARK:- This is to return the trip manager dashboard list
  Future<List<Trip>> getTrips() async {
    List<Trip> _trips = List.empty(growable: true);
    final url = Uri.parse(TripManagerUrls().getTripManagerUrl());
    final headers = await UserRepository().getHeaders();
    print("URL: $url \n Token: ${json.encode(headers)}");
    try {
      await _updateOfficeAndCustomerIds();
      final _payload = json.encode(_filter.paramsPayload(_filter));
      print(_payload);
      await http
          .post(url, headers: headers, body: _payload)
          .then((value) async {
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          final responseData = response['data'] as List;
          for (var item in responseData) {
            _trips.add(Trip.fromJson(item));
          }
        } else {
          ///print(value.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _trips;
  }

  // Future<PagedTripData> getTripsWithTotalCount() async {
  //   List<Trip> _trips = List.empty(growable: true);
  //   int totalCount = 0;
  //   final url = Uri.parse(TripManagerUrls().getTripManagerUrl());
  //   final headers = await UserRepository().getHeaders();
  //   print("URL: $url \n Token: ${json.encode(headers)}");
  //   try {
  //     await _updateOfficeAndCustomerIds();
  //     final _payload = json.encode(_filter.paramsPayload(_filter));
  //     print(_payload);
  //     await http
  //         .post(url, headers: headers, body: _payload)
  //         .then((value) async {
  //       if (value.statusCode == 200) {
  //         final Map<String, dynamic> response = jsonDecode(value.body);
  //         final responseData = response['data'] as List;
  //         totalCount = response['total'];
  //         for (var item in responseData) {
  //           _trips.add(Trip.fromJson(item));
  //         }
  //       } else {
  //         ///print(value.body);
  //       }
  //     });
  //   } catch (e) {
  //     ///debugPrint(e.toString());
  //   }
  //   return PagedTripData(totalCount, _trips);
  // }

  //MARK:- This is to return the trip manager dashboard statistics
  Future<TripStatistic> getTripStats() async {
    var tripAnalyticsData = const TripStatistic(
      cancelled: 0,
      completed: 0,
      inProgress: 0,
      draft: 0,
      total: 0,
    );
    try {
      final url = Uri.parse(TripManagerUrls().getTripManagerStatisticsUrl());

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");
      await _updateOfficeAndCustomerIds();
      final _payload = json.encode(_filter.paramsPayload(_filter));
      print(_payload);

      ///print("$url \n $userToken \n $_payload");
      await http
          .post(url, headers: headers, body: _payload)
          .then((value) async {
        ///print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          tripAnalyticsData = TripStatistic.fromJson(response);
        } else {
          ///print(value.body);
        }
      });
    } catch (e) {
      print(e);
    }

    return tripAnalyticsData;
  }

  //MARK:- This is to return the trip manager overview detail trip data
  Future<TripDetail> getTripManagerDetails({required String guid}) async {
    final url = Uri.parse(TripManagerUrls().getTripManagerDetailUrl());
    final _payload = json.encode({"guid": guid});

    var tripDetailResponse;
    try {
      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");
      await http
          .post(url, headers: headers, body: _payload)
          .then((value) async {
        debugPrint(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          tripDetailResponse = TripDetail.fromJson(response);
        } else {
          debugPrint(value.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return tripDetailResponse;
  }

  Future<TripManagerFilter> _updateOfficeAndCustomerIds() async {
    var _userOffices = await UserRepository().getOffices();
    List<int> _offices = <int>[];
    for (var office in _userOffices) {
      _offices.add(office.officeId);
    }
    _filter.setOfficeIds(_offices);

    var _userCustomers = await UserRepository().getCustomers();
    List<int> _customerIds = <int>[];
    for (var customer in _userCustomers) {
      _customerIds.add(customer.customerId);
    }
    _filter.setCustomerIds(_customerIds);

    return _filter;
  }

  TripManagerPayload generateTripPayload({
    required List<int> subAircrafts,
    required int officeId,
    required int customerId,
    required int flightCategoryId,
    required int aircraftId,
    required int operatorId,
    required String customerReference,
    String? linemode,
    required String tripStatus,
    required String creatorId,
    required bool tripCostEstimate,
    String? guid,
  }) {
    _payload = TripManagerPayload(
      aircraftId: aircraftId,
      creatorId: creatorId,
      customerId: customerId,
      customerReference: customerReference,
      flightCategoryId: flightCategoryId,
      linemode: linemode,
      officeId: officeId,
      operatorId: operatorId,
      subAircrafts: subAircrafts,
      tripCostEstimate: tripCostEstimate,
      guid: guid,
    );
    return _payload;
  }

//MARK:- This is to create trip
  Future<TripDataResponse> createTrip(TripManagerPayload payload) async {
    final url = Uri.parse(TripManagerUrls().createTripManagerUrl());
    var _response;
    try {
      final headers = await UserRepository().getHeaders();
      final _payload = json.encode(payload.toJson());
      print("$url \n $headers");
      print("$_payload \n \n");
      await http
          .post(url, headers: headers, body: _payload)
          .then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          Map<String, dynamic> _json = response['data'] as Map<String, dynamic>;
          _json['message'] = response['message'];
          _response = TripDataResponse.fromJson(_json);
        } else {
          print(value.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<TripDataResponse> updateTrip(TripManagerPayload payload) async {
    var _res;
    try {
      final url = TripManagerUrls().updateTripManagerUrl();
      final _payload = json.encode(payload.toJson());

      final headers = await UserRepository().getHeaders();
      print(url);
      print(headers);
      print(_payload);
      await http
          .post(Uri.parse(url), headers: headers, body: _payload)
          .then((value) async {
        ///print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          Map<String, dynamic> _json = response['data'] as Map<String, dynamic>;
          _json['message'] = response['message'];
          _res = TripDataResponse.fromJson(_json);
        } else {
          print(value.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _res;
  }

  TripOperationalNotePayload generatTripOperationalNotePayload({
    required String guid,
    required String category,
    required int? tripCustomerOperationalNoteId,
    required int? customerOperationalNoteId,
    required String note,
    required String creatorId,
    required String createdAt,
  }) {
    _operationPayload = TripOperationalNotePayload(
      category: category,
      createdAt: createdAt,
      creatorId: creatorId,
      customerOperationalNoteId: customerOperationalNoteId,
      guid: guid,
      note: note,
      tripCustomerOperationalNoteId: tripCustomerOperationalNoteId,
    );
    return _operationPayload;
  }

//MARK:- This is to return the trip manager detail trip data
  Future<bool> saveTripOperationNotes(
      TripOperationalNotePayload _operationPayload) async {
    final url = Uri.parse(TripManagerUrls().saveTripOperationNotes());
    var response = false;
    try {
      final userToken = await UserRepository().getToken();
      final _payload = json.encode(_operationPayload.toJson());

      ///print("$url \n $userToken \n $_payload");
      await http
          .post(url,
              headers: {
                'Content-type': 'application/json',
                'Authorization': "Bearer ${userToken}",
              },
              body: _payload)
          .then((value) async {
        ///print(value.body);
        if (value.statusCode == 200) {
          return true;
        } else {
          return false;

          ///print(value.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }

  TripLookUpPayload generatTripLookUpPayload({
    required String guid,
    required String customercontactId,
  }) {
    _tripLookupPayload = TripLookUpPayload(
      guid: guid,
      customercontactId: customercontactId,
    );
    return _tripLookupPayload;
  }

  //MARK:- This is to save trip look up data
  Future<bool> saveLookUpData(TripLookUpPayload _tripLookupPayload) async {
    var response = false;
    try {
      final _payload = json.encode(_tripLookupPayload.toJson());

      final url = Uri.parse(TripManagerUrls().saveTripLookUpData());

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");
      print("Payload: $_payload");
      await http
          .post(url, headers: headers, body: _payload)
          .then((value) async {
        response = value.statusCode == 200;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }

  //MARK:- This is to return the trip manager dashboard statistics
  Future<List<TripPOCContact>> getTripLookUpData(
      {required int customerId}) async {
    List<TripPOCContact> _lookupData = [];
    try {
      final userToken = await UserRepository().getToken();
      await _updateOfficeAndCustomerIds();

      final url = Uri.parse(TripManagerUrls().getTripLookUpData(customerId));
      print("$url \n $userToken \n $_payload");
      await http.get(url, headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${userToken}",
      }).then((response) async {
        ///print(response.body);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse as List<dynamic>;
          responseData.map((data) {
            _lookupData.add(TripPOCContact.fromJson(data));
          }).toList();

          ///print("==========");
          ///print(_lookupData);
          ///print("==========");
        } else {
          ///print(response.body);
        }
      });
    } catch (e) {
      print(e);
    }
    return _lookupData;
  }
}
