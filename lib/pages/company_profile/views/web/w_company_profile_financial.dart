import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';

class WCompanyProfileFinancial extends StatefulWidget {
  const WCompanyProfileFinancial({Key? key, required this.companyProfile})
      : super(key: key);
  final CompanyProfile companyProfile;

  @override
  State<WCompanyProfileFinancial> createState() =>
      _WCompanyProfileFinancialState();
}

class _WCompanyProfileFinancialState extends State<WCompanyProfileFinancial> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Coming Soon'),
    );
  }
}
