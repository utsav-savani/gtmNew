import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_document.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadDocument {
  final List<Object> fileToUpload;
  final int customerId;
  final String name;
  final String note;
  final String issueDate; // yyyy-mm-dd
  final String expireDate; // yyyy-mm-dd
  final int docTypeId;
  final bool overwrite;
  final bool ufn;

  UploadDocument(
      {required this.fileToUpload,
      required this.customerId,
      required this.name,
      required this.note,
      required this.expireDate,
      required this.issueDate,
      required this.docTypeId,
      this.overwrite = false,
      required this.ufn});

  static UploadDocument fromJson(JsonMap json) =>
      _$UploadDocumentFromJson(json);

  JsonMap toJson() {
    Map<String, dynamic> requestBody = {};
    for (int i = 0; i < this.fileToUpload.length; i++) {
      requestBody.putIfAbsent("fileToUpload$i", () => this.fileToUpload[i]);
    }
    requestBody.putIfAbsent('total', () => this.fileToUpload.length);
    requestBody.putIfAbsent('id', () => this.customerId);
    requestBody.putIfAbsent('name', () => this.name);
    requestBody.putIfAbsent('issueDate', () => this.issueDate);
    requestBody.putIfAbsent('expireDate', () => this.expireDate);
    requestBody.putIfAbsent('note', () => this.note);
    requestBody.putIfAbsent('docTypeId', () => this.docTypeId);
    requestBody.putIfAbsent('overwriteoptional', () => this.overwrite);
    requestBody.putIfAbsent('ufn', () => this.ufn);
    return requestBody;
  }
}
