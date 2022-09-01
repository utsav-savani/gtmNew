import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_category_repository/service_category_repository.dart';
import 'package:service_category_repository/src/constants/service_category_urls.dart';

class ServiceCategoryRepository {
  ServiceCategoryRepository();

  //MARK:- This is to return the service category, sub categories and services list
  Future<List<ServiceCategory>> getServiceCategories() async {
    final url = Uri.parse(ServiceCategoryUrls().getServiceCategoriesUrl());

    final headers = await UserRepository().getHeaders();
    print("URL: $url \n  Headers: $headers");
    List<ServiceCategory> _response = [];
    try {
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse as List;

          for (var item in responseData) {
            _response.add(ServiceCategory.fromJson(item));
          }
          return _response;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return _response;
  }
}
