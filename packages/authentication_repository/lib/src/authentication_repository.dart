import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// ignore: always_use_package_imports
import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/constants/auth_urls.dart';
import 'package:cache/cache.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode, kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_io/jwt_io.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart' as UserRepo;

///import 'package:shared_preferences/shared_preferences.dart';

/// {@template sign_up_with_email_and_password_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
  }) : _cache = cache ?? CacheClient();

  final CacheClient _cache;
  final _controllerUserData = StreamController<UserRepo.User>();
  final StreamController<String?> loggedInUser = StreamController<String?>();
  final UserRepo.UserRepository userRepository = UserRepo.UserRepository();

  Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    loggedInUser.add(null);
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString(userCacheKey);
    if (token != null) {
      bool isExpired = JwtToken.isExpired(token);
      return !isExpired;
    }
    return false;
  }

  Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userCacheKey) ?? '';
  }

  Stream<String?> get loggedUser async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    yield pref.getString(userCacheKey);
  }

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  /* Stream<Data> get user async* {
    Data? data = _cache.read<Data>(key: userCacheKey);
    final user = data == null ? Data.empty : data;
    debugPrint(user.userId);
    yield user;
  }
 */
  void dispose() {
    _controllerUserData.close();
  }

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  /*  Stream<User> get user {
    return currentUser;

    /*  return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    }); */
  } */

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    /*  try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    } */
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    var envKey = dotenv.env['ENCRYPTIONSECRET_KEY'];
    var envIv = dotenv.env['ENCRYPTIONSECRET_IV'];

    //debugPrint(envKey.toString());
    //debugPrint(envIv.toString());

    final key = Key.fromUtf8(envKey.toString()); //32 chars
    final iv = IV.fromUtf8(envIv.toString()); //16 chars
    final encrypter = Encrypter(AES(key));
    final encryptedPassword = encrypter.encrypt(password, iv: iv);
    //debugPrint(encryptedPassword.base64 + '  encrypted password debug mode');

    try {
      final url = Uri.parse(AuthUrls().loginUrl());
      // print("======\n");
      // print("URL: $url");
      var _payload;
      //  final encryptedPassword = encrypter.encrypt(password, iv: iv);
      // debugPrint(encryptedPassword.base64 + '  encrypted password debug mode');
      if (kDebugMode) {
        var pas = 'lzjxryjl'; //'lzjxryjl';
        final encrypterDebugMode = Encrypter(AES(key));
        final debugPasswordEncrypted = encrypterDebugMode.encrypt(pas, iv: iv);
        _payload = {
          'email': 'nitheshsdevaraju@gmail.com', //'nitheshsdevaraju@gmail.com',
          'password': debugPasswordEncrypted.base64, //lzjxryjl
        };
      } else {
        _payload = {
          'email': email.toString().trim(),
          'password': encryptedPassword.base64,
        };
        //   debugPrint(encryptedPassword.base64 + '  encrypted password');
      }

      //print("Payload: ${json.encode(_payload)}");
      //print("\n======");
      final _headers = {'Content-Type': 'application/json'};

      await http
          .post(url, headers: _headers, body: json.encode(_payload))
          .then((value) async {
        //print("Payload: ${value.statusCode}");
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          await userRepository.storeUserData(response).then((value) async {
            //debugPrint(value.toString());
            SharedPreferences pref = await SharedPreferences.getInstance();
            if (await pref.setString(userCacheKey, value.data.token)) {
              _controllerUserData.add(value.data);
              loggedInUser.add(value.data.token);
              //print('save success');
            } else {
              //print('save failed');
            }
          });

          debugPrint(_cache.read(key: userCacheKey).toString() +
              ' sample key inside the cache ');
        } else {
          log(value.statusCode.toString());
          throw const LogInWithEmailAndPasswordFailure().message;
        }
      }).catchError((err) {
        //debugPrint(err);
        throw const LogInWithEmailAndPasswordFailure().message;
      });

      // debugPrint(response);

      // debugPrint('Response status: ${response.statusCode}');
      // debugPrint('Response body: ${response.body}');
    } catch (_) {
      log(_.toString());
      throw const LogInWithEmailAndPasswordFailure().message;
    }
    /* try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    } */
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  UserRepo.User get currentUser {
    return _cache.read<UserRepo.User>(key: userCacheKey) ?? UserRepo.User.empty;
  }

  //MARK: Generate Account Payload
  AccountPayload generateAccountPayload({
    required String firstName,
    required String companyName,
    required String emailAddress,
    required String location,
  }) {
    return AccountPayload(
      firstName: firstName,
      companyName: companyName,
      emailAddress: emailAddress,
      location: location,
    );
  }

  //MARK: Create Account
  Future<bool> createAccount(AccountPayload _payload) async {
    final url = Uri.parse(AuthUrls().createAccount());
    //print(url);
    //print(json.encode(_payload.toJson()));
    bool _res = false;
    try {
      await http
          .post(url,
              headers: {
                'Content-type': 'application/json',
              },
              body: json.encode(_payload.toJson()))
          .then((value) async {
        //print(value.body);
        if (value.statusCode == 200) {
          _res = true;
        } else {
          _res = true;
          //print(value.body);
        }
      });
    } catch (e) {
      _res = false;
      //debugPrint(e.toString());
    }

    return _res;
  }

  //MARK: Generate Send OTP Reset password Payload
  ResetPasswordOTPPayload generateSendOTPToResetPasswordPayload({
    required String email,
  }) {
    return ResetPasswordOTPPayload(email: email);
  }

  //MARK: Reset Password send OTP
  Future<Map<String, dynamic>> sendOTPToResetPassword(
      ResetPasswordOTPPayload _payload) async {
    final url = Uri.parse(AuthUrls().sendOTPForResetPassword());
    //print(url);
    //print(json.encode(_payload.toJson()));
    Map<String, dynamic> response = {
      'status': 'error',
      'message': 'Something went wrong, please try again'
    };
    //print(json.encode(_payload.toJson()));
    try {
      final headers = await UserRepo.UserRepository().getHeadersUnAuth();
      final body = json.encode(_payload.toJson());
      await http.post(url, headers: headers, body: body).then((value) {
        print(value.body);
        final responseData = json.decode(value.body);
        if (value.statusCode == 200) {
          response = {'status': 'success', 'message': responseData["message"]};
        } else {
          response = {'status': 'error', 'message': responseData["message"]};
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }

  //MARK: Generate Verify OTP Reset password Payload
  ResetPasswordVerifyOTPPayload generateVerifyOTPToResetPasswordPayload({
    required String email,
    required String otp,
  }) {
    return ResetPasswordVerifyOTPPayload(otp: otp, email: email);
  }

  //MARK: Reset Password Verify OTP
  Future<Map<String, dynamic>> verifyOTPToResetPassword(
      ResetPasswordVerifyOTPPayload _payload) async {
    final url = Uri.parse(AuthUrls().verifyOTPForResetPassword());
    //print(url);
    //print(json.encode(_payload.toJson()));
    Map<String, dynamic> response = {
      'status': 'error',
      'message': 'Something went wrong, please try again'
    };
    try {
      final headers = await UserRepo.UserRepository().getHeadersUnAuth();
      final body = json.encode(_payload.toJson());
      await http.post(url, headers: headers, body: body).then((value) async {
        //print(value.body);
        final responseData = json.decode(value.body);
        if (value.statusCode == 200) {
          response = {
            'status': 'success',
            'message': responseData["message"],
            'token': responseData["token"]
          };
        } else {
          response = {'status': 'error', 'message': responseData["message"]};
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }

  //MARK: Generate Reset password Payload
  ResetPasswordPayload generateResetPasswordPayload({
    required String password,
    required String confirm_password,
  }) {
    return ResetPasswordPayload(
      password: password,
      confirm_password: confirm_password,
    );
  }

  //MARK: Reset Password
  Future<bool> resetPassword(
      {required ResetPasswordPayload payload, required String token}) async {
    final url = Uri.parse(AuthUrls().resetPassword());
    //print(url);
    //print(json.encode(payload.toJson()));
    var response = false;
    //print(token);
    try {
      await http
          .post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(payload.toJson()),
      )
          .then((value) async {
        //print(value.body);
        if (value.statusCode == 200) {
          response = true;
        } else {
          //print(value.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }
}
