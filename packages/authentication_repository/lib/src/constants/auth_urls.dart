import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  //MARK:- This is to sign an account
  loginUrl() => "$_baseURL/auth/login";

  //MARK:- This is to create an account
  createAccount() => "$_baseURL/email/requestAccount?device=mobile";

  //MARK:- This is to get the send OTP
  sendOTPForResetPassword() => "$_baseURL/user/forgetPassword?device=mobile";

  //MARK:- This is to get the verify Reset password
  verifyOTPForResetPassword() =>
      "$_baseURL/user/tokenVerification?device=mobile";

  //MARK:- This is to get the reset password
  resetPassword() => "$_baseURL/user/resetPassword?device=mobile";
}
