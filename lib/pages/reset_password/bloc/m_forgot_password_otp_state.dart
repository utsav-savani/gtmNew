part of 'm_forgot_password_otp_cubit.dart';

enum EnterOptStatus { initial, loading, success, failure }

class MForgotPasswordOtpState extends Equatable {
  final TextValidator otp1;
  final TextValidator otp2;
  final TextValidator otp3;
  final TextValidator otp4;
  final String token;
  final EnterOptStatus status;
  final String? errorMessage;

  const MForgotPasswordOtpState({
    this.otp1 = const TextValidator.pure(),
    this.otp2 = const TextValidator.pure(),
    this.otp3 = const TextValidator.pure(),
    this.otp4 = const TextValidator.pure(),
    this.token = "",
    this.status = EnterOptStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object> get props => [otp1, otp2, otp3, otp4, token, status];

  MForgotPasswordOtpState copyWith({
    TextValidator? otp1,
    TextValidator? otp2,
    TextValidator? otp3,
    TextValidator? otp4,
    String? token,
    EnterOptStatus? status,
    String? errorMessage,
  }) {
    return MForgotPasswordOtpState(
      otp1: otp1 ?? this.otp1,
      otp2: otp2 ?? this.otp2,
      otp3: otp3 ?? this.otp3,
      otp4: otp4 ?? this.otp4,
      token: token ?? this.token,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
