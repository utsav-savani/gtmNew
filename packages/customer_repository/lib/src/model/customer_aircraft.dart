import 'package:customer_repository/src/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_aircraft.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CustomerAircraft extends Equatable {
  final int customerId;
  final int aircraftId;

  const CustomerAircraft({required this.customerId, required this.aircraftId});

  CustomerAircraft copyWith({
    required int customerId,
    required int aircraftId,
  }) {
    return CustomerAircraft(customerId: customerId, aircraftId: aircraftId);
  }

  /// Deserializes the given [JsonMap] into a [CustomerAircraft].
  static CustomerAircraft fromJson(JsonMap json) =>
      _$CustomerAircraftFromJson(json);

  /// Converts this [CustomerAircraft] into a [JsonMap].
  JsonMap toJson() => _$CustomerAircraftToJson(this);

  @override
  List<Object?> get props => [customerId, aircraftId];
}
