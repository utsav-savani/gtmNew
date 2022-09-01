import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:company_profile_repository/src/constants/company_urls.dart';
import 'package:company_profile_repository/src/filters/company_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CompanyProfileRepository {
  CompanyProfileRepository();

  CompanyFilter _filter = CompanyFilter();

  void setCustomerId(String id) => _filter.setCustomerId(id);
  void setLimit(String limit) => _filter.setLimit(limit);
  void setPage(String page) => _filter.setPage(page);
  void setSearch(String search) => _filter.setSearch(search);

  //MARK:- This is to return the company list
  Future<List<CompanyProfile>> getCompanyProfileList() async {
    final url = Uri.parse(CompanyUrls().getCustomerUrl(_filter));

    final headers = await UserRepository().getHeaders();
    final customers = await UserRepository().getCustomers();
    //print("URL: $url \n Token: ${json.encode(headers)}");
    var _payload = {};
    if (customers.isNotEmpty)
      _payload = {
        'customers': customers.map((e) => e.customerId).toList(),
      };
    List<CompanyProfile> _response = [];
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(_payload))
          .then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(CompanyProfile.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<void> udpateCompanyProfile(
    CompanyProfile companyProfile,
  ) async {
    final url =
        Uri.parse(CompanyUrls().updateCustomerUrl(companyProfile.customerId));

    final headers = await UserRepository().getHeaders();
    //print("URL: $url \n Token: ${json.encode(headers)}");

    try {
      await http
          .post(url, headers: headers, body: jsonEncode(companyProfile))
          .then((response) async {
        if (response.statusCode == 200) {
          debugPrint(response.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<FlightCategory>> getAllFlightCategories() async {
    final url = Uri.parse(CompanyUrls().getAllFlightCategoriesUrl());

    List<FlightCategory> _response = [];
    final headers = await UserRepository().getHeaders();
    //print("URL: $url \n Token: ${json.encode(headers)}");

    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(FlightCategory.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<CompanyProfileFlightCategory>> getCompanyProfileFlightCategory(
      int customerId) async {
    final url =
        Uri.parse(CompanyUrls().getCustomerFlightCategoryUrl(customerId));

    List<CompanyProfileFlightCategory> _response = [];
    final headers = await UserRepository().getHeaders();
    //print("URL: $url \n Token: ${json.encode(headers)}");

    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(CompanyProfileFlightCategory.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<bool> udpateCompanyProfileFlightCategory(
      int customerId, List<int> categoryIds) async {
    final url = Uri.parse(CompanyUrls().updateCustomerFlightcategoryUrl());

    final headers = await UserRepository().getHeaders();
    bool _res = false;
    Map<String, dynamic> body = {};
    body.putIfAbsent('customerId', () => customerId);
    body.putIfAbsent('FlightCategories', () => categoryIds);

    try {
      await http
          .post(url, headers: headers, body: jsonEncode(body))
          .then((response) async {
        if (response.statusCode == 200) {
          _res = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _res;
  }

  Future<List<CustomerContact>> getCustomerContacts(int customerId) async {
    final url = Uri.parse(CompanyUrls().getCustomerContactsUrl(customerId));

    List<CustomerContact> _response = [];
    final headers = await UserRepository().getHeaders();
    //print("URL: $url \n Token: ${json.encode(headers)}");

    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(CustomerContact.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  // pass the customerId in object, it cannot be null here
  Future<CustomerContact?> createCustomerContact(
      CreateCustomerContact customerContact) async {
    CustomerContact? res;
    final url = Uri.parse(
        CompanyUrls().createCustomerContactUrl(customerContact.customerId!));
    final headers = await UserRepository().getHeaders();
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(customerContact))
          .then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          res = CustomerContact.fromJson(jsonResponse['data']);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<CustomerContact?> getCustomerContact(int customerContactId) async {
    final url =
        Uri.parse(CompanyUrls().getCustomerContactUrl(customerContactId));
    CustomerContact? _response = null;
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          _response = (CustomerContact.fromJson(jsonResponse));
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<bool> addcustomerdetailsvalidate(
      {required int contactcategoryType, required String content}) async {
    bool res = false;
    final url = Uri.parse(CompanyUrls().addcustomerdetailsvalidateUrl());
    final headers = await UserRepository().getHeaders();
    Map<String, Object> body = {
      "contactcategoryType": contactcategoryType,
      "content": content
    };
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(body))
          .then((response) {
        if (response.statusCode == 200) res = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<List<Customer>> getCustomerList(
      {required int page, int limit = 10}) async {
    final url = Uri.parse(CompanyUrls().getCustomerListUrl(page, limit));
    List<Customer> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(Customer.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<Vendor>> getVendorList(
      {required int page, int limit = 10}) async {
    final url = Uri.parse(CompanyUrls().getVendorListUrl(page, limit));
    List<Vendor> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(Vendor.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

// pass the customerContactId in object, it cannot be null here
  Future<CustomerContact?> updateCustomerContact(
      CreateCustomerContact customerContact) async {
    CustomerContact? res;
    final url = Uri.parse(CompanyUrls()
        .updateCustomerContactUrl(customerContact.customercontactId!));
    final headers = await UserRepository().getHeaders();
    try {
      await http
          .put(url, headers: headers, body: jsonEncode(customerContact))
          .then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          res = CustomerContact.fromJson(jsonResponse['data']);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<List<Notes>> getCustomerNotes(int customerId) async {
    final url = Uri.parse(CompanyUrls().getCustomerNotesUrl(customerId));
    List<Notes> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(Notes.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<bool> addNotesToServices(CreateNote note) async {
    bool res = false;
    final url = Uri.parse(CompanyUrls().addCustomerNoteUrl());
    final headers = await UserRepository().getHeaders();
    try {
      await http
          .post(url, headers: headers, body: jsonEncode(note))
          .then((response) {
        if (response.statusCode == 200) {
          res = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<bool> updateNoteToService(
      int customerOperationalNoteId, int customerId, String note) async {
    bool res = false;
    final url = Uri.parse(
        CompanyUrls().updateCustomerNoteUrl(customerOperationalNoteId));
    final headers = await UserRepository().getHeaders();
    Map<String, dynamic> request = {"customerId": customerId, "note": note};
    try {
      await http
          .put(url, headers: headers, body: jsonEncode(request))
          .then((response) {
        if (response.statusCode == 200) {
          res = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<bool> deleteNoteToService(int customerOperationalNoteId) async {
    bool res = false;
    final url = Uri.parse(
        CompanyUrls().deleteCustomerNoteUrl(customerOperationalNoteId));
    final headers = await UserRepository().getHeaders();
    try {
      await http.delete(url, headers: headers).then((response) {
        if (response.statusCode == 200) {
          res = true;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<List<ServiceList>> getServiceList() async {
    List<ServiceList> res = [];
    final url = Uri.parse(CompanyUrls().getServiceListUrl());
    final headers = await UserRepository().getHeaders();

    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            res.add(ServiceList.fromJson(item));
          }
          return res;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<bool> uplodaCustomerDocuments(UploadDocument document) async {
    bool res = false;
    final url = Uri.parse(CompanyUrls().uploadDocumentUrl());
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

  Future<bool> updateCustomerDocument(
      Object fileToUpload, int customerId, int documentId) async {
    bool res = false;
    final url = Uri.parse(CompanyUrls().updateDocumentUrl(documentId));
    final headers = await UserRepository().getHeaders();
    Map<String, dynamic> request = {
      "fileToUpload": fileToUpload,
      "id": customerId
    };
    try {
      await http
          .put(url, headers: headers, body: request)
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

  Future<List<Documents>> getCustomerDocuments(int customerId) async {
    final url = Uri.parse(CompanyUrls().getAllDocumentsUrl(customerId));
    List<Documents> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _response.add(Documents.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }

  Future<List<DocumentType>> getCustomerDocumentType() async {
    final url = Uri.parse(CompanyUrls().getDocTypesUrl());
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

  Future<List<Prefrence>> getCustomerPrefrence(int customerId, int page) async {
    final url =
        Uri.parse(CompanyUrls().getCustomerPrefrenceUrl(customerId, page));
    List<Prefrence> _response = [];
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _response.add(Prefrence.fromJson(item));
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
    final url = Uri.parse(CompanyUrls().getDownloadDocumentUrl(docId));
    String? res;
    final headers = await UserRepository().getHeaders();
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          res = jsonResponse['url'];
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }
}
