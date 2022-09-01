part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SaveResetPassword extends ResetPasswordEvent {
  final String newPassword;
  final String confirmPassword;
  final String token;
  const SaveResetPassword(
      {required this.newPassword,
      required this.confirmPassword,
      required this.token});
  @override
  List<Object> get props => [newPassword, confirmPassword];
}
