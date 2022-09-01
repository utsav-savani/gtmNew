import 'package:flutter/material.dart';
import 'package:gtm/_shared/constants/values_constants.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_list_page.dart';
import 'package:gtm/pages/operators/views/mobile/m_company_profile.dart';

class WCompanyProfilePage extends StatelessWidget {
  const WCompanyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > web) {
          return const WCompanyProfileListPage();
        } else {
          return const Center(
            child: MCompanyProfilePage(),
          );
        }
      },
    );
  }
}
