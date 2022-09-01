import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';

part 'crew_passport_document_files.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CrewPassportDocumentFiles extends Equatable {
  final int? passportDocumentFilesId;
  final String? storedName;
  final String? name;
  final int? personPassportDocumentId;

  CrewPassportDocumentFiles({
    this.passportDocumentFilesId,
    this.storedName,
    this.name,
    this.personPassportDocumentId,
  });

  CrewPassportDocumentFiles copyWith({
    int? passportDocumentFilesId,
    String? storedName,
    String? name,
    int? personPassportDocumentId,
  }) =>
      CrewPassportDocumentFiles(
        name: name ?? this.name,
        passportDocumentFilesId: passportDocumentFilesId ?? this.passportDocumentFilesId,
        personPassportDocumentId: passportDocumentFilesId ?? this.personPassportDocumentId,
        storedName: storedName ?? this.storedName,
      );

  /// Deserializes the given [JsonMap] into a [CrewPassportDocumentFiles].
  static CrewPassportDocumentFiles fromJson(JsonMap json) => _$CrewPassportDocumentFilesFromJson(json);

  /// Converts this [CrewPassportDocumentFiles] into a [JsonMap].
  JsonMap toJson() => _$CrewPassportDocumentFilesToJson(this);

  @override
  List<Object?> get props => [
        passportDocumentFilesId,
        storedName,
        name,
        personPassportDocumentId,
      ];
}
