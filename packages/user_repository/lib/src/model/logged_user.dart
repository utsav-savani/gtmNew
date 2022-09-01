import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/src/config/typedef_json.dart';
import 'package:user_repository/src/model/models.dart';

part 'logged_user.g.dart';

/// auth user model
///
@immutable
@JsonSerializable(explicitToJson: true)
class LoggedUser extends Equatable {
  final User data;

  /// {user class for basic test}
  const LoggedUser({
    required this.data,
  });

  LoggedUser copyWith({
    bool? status,
    User? data,
  }) {
    return LoggedUser(
      data: data ?? this.data,
    );
  }

  /// Deserializes the given [JsonMap] into a [LoginUser].
  static LoggedUser fromJson(JsonMap json) => _$LoggedUserFromJson(json);

  /// Converts this [LoginUser] into a [JsonMap].
  JsonMap toJson() => _$LoggedUserToJson(this);

  @override
  List<Object?> get props => [data];
}
