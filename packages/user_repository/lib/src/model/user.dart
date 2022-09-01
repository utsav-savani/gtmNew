import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/src/config/typedef_json.dart';

part 'user.g.dart';

/// auth user model
///
@immutable
@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  /// {user class for basic test}
  const User({
    required this.userId,
    this.emailAddress = '',
    this.firstName = '',
    this.lastName = '',
    this.lastSignIn = '',
    this.token = '',
  });

  final String userId;
  final String emailAddress;
  final String firstName;
  final String lastName;
  final String lastSignIn;
  final String token;

  ///  return a copy of this Object with the given values updated
  User copyWith({
    String? userId,
    String? emailAddress,
    String? firstName,
    String? lastName,
    String? lastSignIn,
    String? token,
  }) {
    return User(
      userId: userId ?? this.userId,
      emailAddress: emailAddress ?? this.emailAddress,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      lastSignIn: lastSignIn ?? this.lastSignIn,
      token: token ?? this.token,
    );
  }

  /// Deserializes the given [JsonMap] into a [UserData].
  static User fromJson(JsonMap json) => _$UserFromJson(json);

  /// Converts this [UserData] into a [JsonMap].
  JsonMap toJson() => _$UserToJson(this);

  /// Empty user which represents an unauthenticated user.
  static const empty = User(userId: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;
  @override
  List<Object> get props => [
        userId,
        emailAddress,
        token,
      ];
}
