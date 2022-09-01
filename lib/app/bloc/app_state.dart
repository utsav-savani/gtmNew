part of 'app_bloc.dart';

/// status of user state management
enum AppStatus {
  /// logged in
  authenticated,

  /// loged out Or new user
  unauthenticated,
}

///
class AppState extends Equatable {
  const AppState._({
    required this.status,
    required this.user,
  });

  /// return authenticated state
  const AppState.authenticated(String user) : this._(status: AppStatus.authenticated, user: user);

  /// return unauthenticated
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated, user: '');

  /// return status based upon
  final AppStatus status;

  /// Data from the rest api is not structured well or not optimised right now
  final String user;

  @override
  List<Object> get props => <Object>[status, user];
}
