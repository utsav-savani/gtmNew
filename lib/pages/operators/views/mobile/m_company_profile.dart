import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_company_profile_page.dart';

class MCompanyProfilePage extends StatefulWidget {
  const MCompanyProfilePage({Key? key}) : super(key: key);

  @override
  State<MCompanyProfilePage> createState() => _MCompanyProfilePageState();
}

class _MCompanyProfilePageState extends State<MCompanyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Company Profile'.translate()),
      body: const WCompanyProfilePage(),
    );
  }
}
