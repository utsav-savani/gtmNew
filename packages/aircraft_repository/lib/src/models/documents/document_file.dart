import 'package:aircraft_repository/config/typedef_json.dart';

import 'package:json_annotation/json_annotation.dart';

part 'document_file.g.dart';

@JsonSerializable(explicitToJson: true)
class DocumentFile {
  final int documentFilesId;
  final String storedName;
  final String name;

  DocumentFile(
      {required this.documentFilesId,
      required this.storedName,
      required this.name});

  static DocumentFile fromJson(JsonMap json) => _$DocumentFileFromJson(json);

  JsonMap toJson() => _$DocumentFileToJson(this);
}
