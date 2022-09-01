import 'package:url_launcher/url_launcher.dart';

void timaticLaunchUrl() async {
  final Uri _url = Uri.parse(
      'https://www.timaticweb2.com/integration/external?ref=7cd87e9e963b797cdd8c441f975bc24a&clear=true');
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}
