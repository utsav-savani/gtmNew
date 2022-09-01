import 'package:authentication_repository/config/typedef_json.dart';
import 'package:authentication_repository/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'token.g.dart';

/// auth user model
///
@immutable
@JsonSerializable()
class Token extends Equatable {
  /// {user class for basic test}
  Token({required this.token, required this.data})
      : assert(
          token.isNotEmpty,
          'id can not be null and should be empty',
        );

  /// basic token of user we get from the server api
  final String token;

  /// basic user data from the rest api
  final User data;

  ///  return a copy of this Object with the given values updated
  Token copyWith({String? token, User? userData}) {
    return Token(
      token: token ?? this.token,
      data: userData ?? this.data,
    );
  }

  /// Deserializes the given [JsonMap] into a [Token].
  static Token fromJson(JsonMap json) => _$TokenFromJson(json);

  /// Converts this [Token] into a [JsonMap].
  JsonMap toJson() => _$TokenToJson(this);

  @override
  List<Object> get props => [token, data];
}
