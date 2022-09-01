import 'package:equatable/equatable.dart';

class CompanyProfileMock extends Equatable {
  String? companyName = '';
  String? region = '';
  String? country = '';
  String? bdm = '';
  String? cicCate = '';
  String? office = '';
  String? accountStatus = '';
  String? status = '';
  String? type = '';
  String? action = '';
  String? empty = '';
  CompanyProfileMock(
    this.accountStatus,
    this.action,
    this.companyName,
    this.region,
    this.country,
    this.bdm,
    this.cicCate,
    this.office,
    this.status,
    this.type,
    this.empty,
  );

  @override
  List<Object?> get props => [
        accountStatus,
        action,
        companyName,
        region,
        country,
        bdm,
        cicCate,
        office,
        status,
        type,
        empty,
      ];
}
