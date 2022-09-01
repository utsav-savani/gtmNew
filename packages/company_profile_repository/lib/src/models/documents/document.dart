import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/documents/document_file.dart';
import 'package:company_profile_repository/src/models/documents/document_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable(explicitToJson: true)
class Documents {
  final int documentId;
  final int? countryId;
  final String name;
  final String? expireDate;
  final bool? ufn;
  final String? issueDate;
  final String? note;
  @JsonKey(name: 'DocumentType')
  final DocumentType documentType;
  @JsonKey(name: 'DocumentFiles')
  final List<DocumentFiles> documentFiles;
  final String? newExpireDate;
  final String? newIssueDate;

  Documents(
      {required this.documentId,
      this.countryId,
      required this.name,
      this.expireDate,
      this.ufn,
      this.issueDate,
      this.note,
      required this.documentType,
      required this.documentFiles,
      this.newExpireDate,
      this.newIssueDate});

  static Documents fromJson(JsonMap json) => _$DocumentsFromJson(json);

  JsonMap toJson() => _$DocumentsToJson(this);
}
