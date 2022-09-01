import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:gtm/pages/login/models/models.dart';

part 'm_forgot_password_state.dart';

///
class MForgotPasswordCubit extends Cubit<MForgotPasswordState> {
  ///
  MForgotPasswordCubit(this._authenticationRepository)
      : super(const MForgotPasswordState());

  final AuthenticationRepository _authenticationRepository;

  /// email address state management
  void emailChanged(String value) {
    emit(state.copyWith(status: ForgotPasswordStatus.initial));
    final Email str = Email.dirty(value);
    emit(
      state.copyWith(
        email: str,
        // status: Formz.validate([str, state.email]),
      ),
    );
  }

  /// pass the login credentials to the unknown rest api and making the call now
  /// will have different api to test the real user....right now we are mocking with existing token user sample
  Future<void> sendOTP() async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      final String email = state.email.value;
      ResetPasswordOTPPayload _payload = ResetPasswordOTPPayload(email: email);
      Map<String, dynamic> res =
          await _authenticationRepository.sendOTPToResetPassword(_payload);
      //print(res);
      if (res['status'] == 'success') {
        emit(state.copyWith(status: ForgotPasswordStatus.success));
      } else if (res['status'] == 'error') {
        emit(
          state.copyWith(
            status: ForgotPasswordStatus.failure,
            errorMessage: res['message'],
          ),
        );
      } else {
        emit(state.copyWith(status: ForgotPasswordStatus.success));
      }
    } on Exception {
      // debugPrint(e.toString());
      //print(e);
      emit(
        state.copyWith(
          // errorMessage: e.message,
          status: ForgotPasswordStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ForgotPasswordStatus.failure));
    }
  }
}
