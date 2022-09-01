import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRepoUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  //MARK:- This is to get the logged in user details
  userDetails() => "$_baseURL/auth/user";
}
