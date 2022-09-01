import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_file.g.dart';

@JsonSerializable(explicitToJson: true)
class DocumentFiles {
  final int documentFilesId;
  final String storedName;
  final String name;

  DocumentFiles(
      {required this.documentFilesId,
      required this.storedName,
      required this.name});

  static DocumentFiles fromJson(JsonMap json) => _$DocumentFilesFromJson(json);

  JsonMap toJson() => _$DocumentFilesToJson(this);
}
