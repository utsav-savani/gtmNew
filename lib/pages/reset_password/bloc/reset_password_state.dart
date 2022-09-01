part of 'reset_password_bloc.dart';

enum ResetPasswordStatus { initial, loading, success, failure }

class ResetPasswordState extends Equatable {
  final ResetPasswordStatus status;
  final String newPassword;
  final String confirmPassword;
  final String token;
  const ResetPasswordState({
    this.status = ResetPasswordStatus.initial,
    required this.newPassword,
    required this.confirmPassword,
    required this.token,
  });

  ResetPasswordState copyWith(
      {ResetPasswordStatus? status,
      required String newPassword,
      required String confirmPassword,
      required String token}) {
    return ResetPasswordState(
      status: status ?? this.status,
      confirmPassword: confirmPassword,
      newPassword: newPassword,
      token: token,
    );
  }

  @override
  List<Object> get props => [status, newPassword, confirmPassword, token];
}
