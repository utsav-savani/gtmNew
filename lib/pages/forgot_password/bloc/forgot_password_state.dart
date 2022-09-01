part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus { inital, loading, success, failure }

class ForgotPasswordState extends Equatable {
  final String email;
  final ForgotPasswordStatus status;
  const ForgotPasswordState({
    required this.email,
    this.status = ForgotPasswordStatus.inital,
  });

  ForgotPasswordState copyWith(
      {required String email, ForgotPasswordStatus? status}) {
    return ForgotPasswordState(
      email: email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, status];
}
