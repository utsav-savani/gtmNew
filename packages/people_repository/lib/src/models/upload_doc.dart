import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';

part 'upload_doc.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadDoc {
  final String guid;
  final int id;
  final int? personPassportDocumentId;
  final int? visaId;
  final String name;
  final int docTypeId;
  final int? prefrence;
  final int? customerId;
  final String number;
  final String issueDate;
  final String expiryDate;
  final String? type;
  final bool isActive;
  final int total;
  final bool overwriteoptional;
  final int countryId;
  final String? nationality;
  final String documentType;

  UploadDoc(
      {required this.guid,
      required this.id,
      this.personPassportDocumentId,
      this.visaId,
      required this.name,
      required this.docTypeId,
      this.prefrence,
      this.customerId,
      required this.number,
      required this.issueDate,
      required this.expiryDate,
      this.type,
      required this.isActive,
      required this.total,
      required this.overwriteoptional,
      required this.countryId,
      this.nationality,
      required this.documentType});
  static UploadDoc fromJson(JsonMap json) => _$UploadDocFromJson(json);
  JsonMap toJson() => _$UploadDocToJson(this);
}
