import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:people_repository/constants/people_urls.dart';
import 'package:people_repository/people_repository.dart';

class PeopleRepository {
  PeopleRepository();

  //MARK:- This is to return the list of  Peoples
  Future<List<People>> getPeoples() async {
    List<People> _response = [];
    try {
      final url = Uri.parse(PeopleUrls().getPeopleUrl());

      final headers = await UserRepository().getHeaders();
      final customers = await UserRepository().getCustomers();
      List<int> customerIds = [];
      for (int i = 0; i < customers.length; i++) {
        customerIds.add(customers[i].customerId);
      }
      print("URL: $url \n Token: ${jsonEncode(headers)}");

      var _payload = {
        'customers': customerIds,
      };

      await http
          .post(url, headers: headers, body: jsonEncode(_payload))
          .then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse;
          print(responseData);
          responseData
              .map((data) => _response.add(People.fromJson(data)))
              .toList();
        }
      });
      return _response;
    } catch (e) {
      //print(e);
      return _response;
    }
  }

  Future<List<Customers>> getCustomers(int page, int limit) async {
    final res = await AircraftRepository().getCustomerList(page: page);
    return res;
  }

  Future<List<Country>> getCountryList() async {
    final res = await AircraftRepository().getCountryList();
    return res;
  }

  Future<Map<String, dynamic>> validatePerson(
      {required String dob,
      required String firstMiddleName,
      String? surname}) async {
    final url = Uri.parse(PeopleUrls().validatePersonUrl());
    final headers = await UserRepository().getHeaders();
    Map<String, dynamic> res = {};
    Map<String, dynamic> body = {
      'dob': dob,
      'firstMiddleName': firstMiddleName
    };
    if (surname != null) body.putIfAbsent('surname', () => surname);
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(body))
          .then((value) {
        final jsonRes = jsonDecode(value.body);
        res.putIfAbsent('statusCode', () => value.statusCode);
        res.putIfAbsent('message', () => jsonRes['message']);
      });
    } catch (e) {
      return res;
    }
    return res;
  }

  Future<List<City>> fetchCities(String country) async {
    List<City> res = [];
    final url = Uri.parse(PeopleUrls().fetchCityListUrl());
    final headers = await UserRepository().getHeaders();
    Map<String, String> body = {'country': country};
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(body))
          .then((value) {
        if (value.statusCode == 200) {
          final jsonResponse = jsonDecode(value.body);
          jsonResponse.map((data) => res.add(City.fromJson(data))).toList();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<Map<String, dynamic>> validateLicence(
      {required int personId, required String licenceNumber}) async {
    final url = Uri.parse(PeopleUrls().validateLicenceUrl());
    final headers = await UserRepository().getHeaders();
    Map<String, dynamic> res = {};
    Map<String, dynamic> body = {
      'personId': [personId],
      'number': licenceNumber
    };
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(body))
          .then((value) {
        final jsonRes = jsonDecode(value.body);
        res.putIfAbsent('statusCode', () => value.statusCode);
        res.putIfAbsent('message', () => jsonRes['message']);
      });
    } catch (e) {
      return res;
    }
    return res;
  }

  Future<Person?> fetchPersonDetails(String? guid) async {
    if (guid == null) {
      return null;
    }
    final url = Uri.parse(PeopleUrls().fetchPersonDetailsUrl(guid));
    final headers = await UserRepository().getHeaders();
    Person? res;
    try {
      await http.get(url, headers: headers).then((value) {
        if (value.statusCode == 200) {
          final json = jsonDecode(value.body);
          res = Person.fromJson(json);
          res!.guid = guid;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<bool> updatePersonData(
      Object formData, int customerId, String guid, bool isPassenger) async {
    final url = Uri.parse(PeopleUrls().updatePersonDetailsUrl(isPassenger));
    final headers = await UserRepository().getHeaders();
    Map<String, dynamic> body = {};
    body.putIfAbsent('customerId', () => customerId);
    body.putIfAbsent('guid', () => guid);
    body.putIfAbsent('forms', () => [formData]);
    bool res = false;
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(body))
          .then((value) {
        if (value.statusCode == 200) {
          res = true;
        }
      });
    } catch (e) {}
    return res;
  }

  Future<bool> uploadPassportData(
      {required List<Object> filesToUpload,
      required UploadDoc documentDetails}) async {
    try {
      final url = Uri.parse(PeopleUrls().uploadPassportUrl());
      final headers = await UserRepository().getHeaders();
      var formData = FormData.fromMap(documentDetails.toJson());
      var res = false;
      try {
        await Dio()
            .post(PeopleUrls().uploadPassportUrl(),
                data: formData, options: Options(headers: headers))
            .then((value) {
          if (value.statusCode == 200) {
            res = true;
          }
        });
      } catch (e) {}
      return res;
      // http.MultipartRequest request = http.MultipartRequest('POST', url);
      // request.headers.addAll(headers);

      // List<http.MultipartFile> files = [];
      // for (int i = 0; i < filesToUpload.length; i++) {
      //   PlatformFile file = filesToUpload[i] as PlatformFile;
      //   if (file.bytes != null) {
      //     files.add(http.MultipartFile.fromBytes(
      //         'fileToUpload' + (i).toString(), file.bytes!));
      //   }
      // }
      // request.files.addAll(files);
      // documentDetails.toJson().forEach((key, value) {
      //   request.fields[key.toString()] = value.toString();
      // });
      // request.fields.putIfAbsent('isGTM', () => true.toString());
      // http.StreamedResponse response = await request.send();
      // print(response.statusCode);
      // return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePassportData(
      {required List<Object> filesToUpload,
      required UploadDoc documentDetails}) async {
    try {
      final url = Uri.parse(PeopleUrls()
          .updatePassportUrl(documentDetails.personPassportDocumentId!));
      final headers = await UserRepository().getHeaders();
      var formData = FormData.fromMap(documentDetails.toJson());
      var res = false;
      try {
        await Dio()
            .put(
                PeopleUrls().updatePassportUrl(
                    documentDetails.personPassportDocumentId!),
                data: formData,
                options: Options(headers: headers))
            .then((value) {
          if (value.statusCode == 200) {
            res = true;
          }
        });
      } catch (e) {}
      return res;
    } catch (e) {
      return false;
    }
  }

  Future<bool> uploadVisaData(
      {required List<Object> filesToUpload,
      required UploadDoc documentDetails}) async {
    try {
      final headers = await UserRepository().getHeaders();
      var formData = FormData.fromMap(documentDetails.toJson());
      var res = false;
      try {
        await Dio()
            .post(PeopleUrls().uploadVisaUrl(),
                data: formData, options: Options(headers: headers))
            .then((value) {
          if (value.statusCode == 200) {
            res = true;
          }
        });
      } catch (e) {}
      return res;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateVisaData(
      {required List<Object> filesToUpload,
      required UploadDoc documentDetails}) async {
    try {
      final headers = await UserRepository().getHeaders();
      var formData = FormData.fromMap(documentDetails.toJson());
      var res = false;
      try {
        await Dio()
            .put(PeopleUrls().updateVisaUrl(documentDetails.visaId!),
                data: formData, options: Options(headers: headers))
            .then((value) {
          if (value.statusCode == 200) {
            res = true;
          }
        });
      } catch (e) {}
      return res;
    } catch (e) {
      return false;
    }
  }
}
