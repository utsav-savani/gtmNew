import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:aircraft_repository/src/models/documents/document_file.dart';
import 'package:aircraft_repository/src/models/documents/document_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable(explicitToJson: true)
class Document {
  final int documentId;
  final int? countryId;
  final String name;
  final String? expireDate;
  final bool? ufn;
  final String? issueDate;
  final String? note;
  @JsonKey(name: 'DocumentType')
  final DocumentType? documentType;
  @JsonKey(name: 'DocumentFiles')
  final List<DocumentFile> documentFiles;
  final String? newExpireDate;
  final String? newIssueDate;

  Document(
      {required this.documentId,
      this.countryId,
      required this.name,
      this.expireDate,
      this.ufn,
      this.issueDate,
      this.note,
      this.documentType,
      required this.documentFiles,
      this.newExpireDate,
      this.newIssueDate});

  static Document fromJson(JsonMap json) => _$DocumentFromJson(json);

  JsonMap toJson() => _$DocumentToJson(this);
}
