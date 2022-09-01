part of 'm_forgot_password_cubit.dart';

enum ForgotPasswordStatus {
  initial,
  loading,
  success,
  failure,
  paginationsuccess,
  paginationfailure
}

class MForgotPasswordState extends Equatable {
  final Email email;
  final ForgotPasswordStatus status;
  final String? errorMessage;

  const MForgotPasswordState({
    this.email = const Email.pure(),
    this.status = ForgotPasswordStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object> get props => [email, status];

  MForgotPasswordState copyWith({
    Email? email,
    ForgotPasswordStatus? status,
    String? errorMessage,
  }) {
    return MForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
