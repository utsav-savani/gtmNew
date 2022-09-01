import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:user_repository/src/config/constants.dart';
import 'package:user_repository/src/constants/user_repo_urls.dart';
import 'package:user_repository/src/model/logged_user.dart';
import 'package:user_repository/user_repository.dart';

///
class UserRepositoryFailure implements Exception {
  /// {@macro saveUser details error}
  const UserRepositoryFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory UserRepositoryFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-user-details':
        return const UserRepositoryFailure(
          'Error while saving user details',
        );
      default:
        return const UserRepositoryFailure();
    }
  }

  final String message;
}

class UserRepository {
  UserRepository();

  LocalStorage localStorageUser = LocalStorage(localStorageKey);
  LocalStorage localStorageUserDataObject =
      LocalStorage(localUserDataObjectStorageKey);

  /// save the user to the local storage
  Future<LoggedUser> storeUserData(Map<String, dynamic> response) async {
    LoggedUser loginUser = LoggedUser.fromJson(response);
    await localStorageUser.setItem(userKey, loginUser.toJson());
    Map<String, dynamic> data = await localStorageUser.getItem(userKey);
    var userStored = LoggedUser.fromJson(data);
    debugPrint(userStored.toString());
    await storeUserDetails();
    return userStored;
  }

  ///store user details

  Future<void> storeUserDetails() async {
    try {
      final url = Uri.parse(UserRepoUrls().userDetails());

      final headers = await UserRepository().getHeaders();

      await http.get(url, headers: headers).then((value) async {
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          final userDetails = UserDataObject.fromJson(response["data"]);

          /// store the user object data for later use
          await localStorageUserDataObject.setItem(
              userDataObjectKey, userDetails.toJson());
          // debugPrint(dataObject);
          UserDataObject userDataObject = await readUserObjectData();
          debugPrint(userDataObject.offices[3].officeId.toString());

          debugPrint(userDataObject.customers[1].organizationId.toString());
        } else {
          throw const UserRepositoryFailure();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  /// read the user to the local storage
  Future<LoggedUser> readUser() async {
    var storedUser = await localStorageUser.getItem(userKey);
    var user = LoggedUser.fromJson(storedUser);
    //debugPrint(storedUser.toString());
    return user;
  }

  Future<String> getToken() async {
    var storedUser = await localStorageUser.getItem(userKey);
    //debugPrint(storedUser.toString());
    var user = LoggedUser.fromJson(storedUser);
    return user.data.token;
  }

  Future<List<Office>> getOffices() async {
    UserDataObject storedObject = await readUserObjectData();
    return storedObject.offices;
  }

  Future<List<Customer>> getCustomers() async {
    UserDataObject storedObject = await readUserObjectData();
    return storedObject.customers;
  }

  Future<Customer> getCustomer() async {
    UserDataObject storedObject = await readUserObjectData();
    return storedObject.customers[0];
  }

  Future<UserDataObject> readUserObjectData() async {
    await Future.delayed(Duration(seconds: 1));
    var storedObject =
        await localStorageUserDataObject.getItem(userDataObjectKey);
    // debugPrint(storedObject.toString());
    return UserDataObject.fromJson(storedObject);
  }

  Future<Map<String, String>> getHeaders() async {
    await Future.delayed(Duration(seconds: 1));
    var storedUser = await localStorageUser.getItem(userKey);
    var user = LoggedUser.fromJson(storedUser);
    final Map<String, String> _res = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${user.data.token}"
    };
    return _res;
  }

  Future<Map<String, String>> getHeadersUnAuth() async {
    await Future.delayed(Duration(seconds: 1));
    final Map<String, String> _res = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    return _res;
  }
}
