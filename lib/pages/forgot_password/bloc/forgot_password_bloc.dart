import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthenticationRepository _authenticationRepository;
  ForgotPasswordBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const ForgotPasswordState(email: '')) {
    on<SendOtpToEmail>(_sendOtpToEmail);
    on<ResetForgotPasswordBloc>(_resetBloc);
  }

  Future<void> _sendOtpToEmail(
      SendOtpToEmail event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(
        email: event.email, status: ForgotPasswordStatus.loading));
    try {
      //   print(event.email);
      Map<String, dynamic> response =
          await _authenticationRepository.sendOTPToResetPassword(
              _authenticationRepository.generateSendOTPToResetPasswordPayload(
                  email: event.email.toLowerCase()));
      // await Future<void>.delayed(const Duration(seconds: 5));
      if (response['status'] == 'success') {
        emit(state.copyWith(
            email: event.email, status: ForgotPasswordStatus.success));
      } else {
        emit(state.copyWith(
            email: event.email, status: ForgotPasswordStatus.failure));
      }
    } catch (e) {
      ///   print(e);
      emit(state.copyWith(
          email: event.email, status: ForgotPasswordStatus.failure));
    }
  }

  _resetBloc(ResetForgotPasswordBloc event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(
        email: event.email, status: ForgotPasswordStatus.inital));
  }
}
