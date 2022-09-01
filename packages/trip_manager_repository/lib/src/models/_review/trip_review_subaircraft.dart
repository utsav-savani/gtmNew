import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_review_subaircraft.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripReviewSubaircraft extends Equatable {
  final String name;

  const TripReviewSubaircraft({required this.name});

  TripReviewSubaircraft copyWith({required String name}) {
    return TripReviewSubaircraft(name: name);
  }

  /// Deserializes the given [JsonMap] into a [TripReviewSubaircraft].
  static TripReviewSubaircraft fromJson(JsonMap json) =>
      _$TripReviewSubaircraftFromJson(json);

  /// Converts this [TripReviewSubaircraft] into a [JsonMap].
  JsonMap toJson() => _$TripReviewSubaircraftToJson(this);

  @override
  List<Object?> get props => [name];
}
