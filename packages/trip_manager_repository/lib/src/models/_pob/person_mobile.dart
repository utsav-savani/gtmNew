import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'person_mobile.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class PersonMobile extends Equatable {
  final int? personMobileId;
  final int? personId;
  final String? mobile;

  const PersonMobile({
    this.personMobileId,
    this.personId,
    this.mobile,
  });

  PersonMobile copyWith({
    int? personMobileId,
    int? personId,
    String? mobile,
  }) {
    return PersonMobile(
      personMobileId: personMobileId,
      personId: personId,
      mobile: mobile,
    );
  }

  /// Deserializes the given [JsonMap] into a [PersonMobile].
  static PersonMobile fromJson(JsonMap json) => _$PersonMobileFromJson(json);

  /// Converts this [PersonMobile] into a [JsonMap].
  JsonMap toJson() => _$PersonMobileToJson(this);

  @override
  List<Object?> get props => [
        personMobileId,
        personId,
        mobile,
      ];
}
