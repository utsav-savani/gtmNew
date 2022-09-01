part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendOtpToEmail extends ForgotPasswordEvent {
  final String email;

  const SendOtpToEmail({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetForgotPasswordBloc extends ForgotPasswordEvent {
  final String email;
  const ResetForgotPasswordBloc({required this.email});

  @override
  List<Object> get props => [email];
}
