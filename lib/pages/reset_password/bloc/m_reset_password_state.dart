part of 'm_reset_password_cubit.dart';

class MResetPasswordState extends Equatable {
  final TextValidator password;
  final TextValidator cpassword;
  final FormzStatus status;
  final String? errorMessage;

  const MResetPasswordState({
    this.password = const TextValidator.pure(),
    this.cpassword = const TextValidator.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object> get props => [password,cpassword, status];

  MResetPasswordState copyWith({
    TextValidator? password,
    TextValidator? cpassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    MResetPasswordState state = MResetPasswordState(
      password: password ?? this.password,
      cpassword: cpassword ?? this.cpassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
    return state;
  }
}
