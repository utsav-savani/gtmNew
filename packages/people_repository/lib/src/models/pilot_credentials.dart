import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';

part 'pilot_credentials.g.dart';

@JsonSerializable(explicitToJson: true)
class PilotCredentials {
  @JsonKey(name: 'LicenseIssuedCountryId')
  final int licenseIssuedCountryId;
  final String? expirationDate;
  final int formId;
  final String? issueDate;
  final String licenseNumber;
  final bool ufn;

  PilotCredentials(
      {required this.licenseIssuedCountryId,
      this.expirationDate,
      required this.formId,
      this.issueDate,
      required this.licenseNumber,
      required this.ufn});

  static PilotCredentials fromJson(JsonMap json) =>
      _$PilotCredentialsFromJson(json);
  JsonMap toJson() => _$PilotCredentialsToJson(this);
}
