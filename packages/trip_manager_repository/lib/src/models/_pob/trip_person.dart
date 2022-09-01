import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_person.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripPerson extends Equatable {
  final int personId;
  final String name;
  final List<String>? roles;
  final String nationality;
  final List<Passport>? passport;

  const TripPerson({
    required this.personId,
    required this.name,
    required this.nationality,
    this.roles,
    this.passport,
  });

  TripPerson copyWith({
    required int personId,
    required String name,
    required String nationality,
    List<String>? roles,
    List<Passport>? passport,
  }) {
    return TripPerson(
      personId: personId,
      name: name,
      nationality: nationality,
      roles: roles,
      passport: passport,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripPerson].
  static TripPerson fromJson(JsonMap json) => _$TripPersonFromJson(json);

  /// Converts this [TripPerson] into a [JsonMap].
  JsonMap toJson() => _$TripPersonToJson(this);

  @override
  List<Object?> get props => [
        personId,
        name,
        nationality,
        roles,
        passport,
      ];
}
