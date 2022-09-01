import 'package:flutter/foundation.dart';

class AuthInfo extends ChangeNotifier {
  var _token = '';
  String get token => _token;
  bool get loggedIn => _token.isNotEmpty;

  void login(String token) {
    _token = token;
    notifyListeners();
  }

  void logout() {
    _token = '';
    notifyListeners();
  }
}