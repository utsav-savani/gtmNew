import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';

part 'crew_visa_document_files.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CrewVisaDocumentFiles extends Equatable {
  final int? visaDocumentFilesId;
  final String? storedName;
  final String? name;
  final int? personVisaDocumentId;

  CrewVisaDocumentFiles({this.visaDocumentFilesId, this.storedName, this.name, this.personVisaDocumentId});

  CrewVisaDocumentFiles copyWith({
    int? visaDocumentFilesId,
    String? storedName,
    String? name,
    int? personVisaDocumentId,
  }) =>
      CrewVisaDocumentFiles(
          visaDocumentFilesId: visaDocumentFilesId ?? this.visaDocumentFilesId,
          storedName: storedName ?? this.storedName,
          name: name ?? this.name,
          personVisaDocumentId: personVisaDocumentId ?? this.personVisaDocumentId);

  /// Deserializes the given [JsonMap] into a [CrewVisaDocumentFiles].
  static CrewVisaDocumentFiles fromJson(JsonMap json) => _$CrewVisaDocumentFilesFromJson(json);

  /// Converts this [CrewVisaDocumentFiles] into a [JsonMap].
  JsonMap toJson() => _$CrewVisaDocumentFilesToJson(this);

  @override
  List<Object?> get props => [visaDocumentFilesId, storedName, name, personVisaDocumentId];
}
