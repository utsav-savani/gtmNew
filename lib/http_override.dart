import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  // OVERRIDING CERTIFICATE MANUALLY
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}