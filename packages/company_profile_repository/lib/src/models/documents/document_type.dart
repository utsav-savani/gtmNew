import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_type.g.dart';

@JsonSerializable(explicitToJson: true)
class DocumentType {
  final int docTypeId;
  final String name;
  final String? model;

  DocumentType({required this.docTypeId, required this.name, this.model});

  static DocumentType fromJson(JsonMap json) => _$DocumentTypeFromJson(json);

  JsonMap toJson() => _$DocumentTypeToJson(this);
}
