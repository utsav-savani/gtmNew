import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';
part 'note_service.g.dart';

@JsonSerializable(explicitToJson: true)
class NoteService {
  final String service;
  NoteService(this.service);
  static NoteService fromJson(JsonMap json) => _$NoteServiceFromJson(json);
  JsonMap toJson() => _$NoteServiceToJson(this);
}
