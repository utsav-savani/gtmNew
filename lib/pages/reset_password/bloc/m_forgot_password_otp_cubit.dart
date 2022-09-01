import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:gtm/pages/login/models/models.dart';

part 'm_forgot_password_otp_state.dart';

///
class MForgotPasswordOtpCubit extends Cubit<MForgotPasswordOtpState> {
  ///
  MForgotPasswordOtpCubit(this._authenticationRepository)
      : super(const MForgotPasswordOtpState());

  final AuthenticationRepository _authenticationRepository;

  /// otp1 state management
  void otp1Changed(String value) {
    emit(state.copyWith(status: EnterOptStatus.initial));
    final TextValidator str = TextValidator.dirty(value);
    emit(
      state.copyWith(
        otp1: str,
        // status: Formz.validate([str, state.email]),
      ),
    );
  }

  /// otp1 state management
  void otp2Changed(String value) {
    emit(state.copyWith(status: EnterOptStatus.initial));
    final TextValidator str = TextValidator.dirty(value);
    emit(
      state.copyWith(
        otp2: str,
        // status: Formz.validate([str, state.email]),
      ),
    );
  }

  /// otp1 state management
  void otp3Changed(String value) {
    emit(state.copyWith(status: EnterOptStatus.initial));
    final TextValidator str = TextValidator.dirty(value);
    emit(
      state.copyWith(
        otp3: str,
        // status: Formz.validate([str, state.email]),
      ),
    );
  }

  /// otp1 state management
  void otp4Changed(String value) {
    emit(state.copyWith(status: EnterOptStatus.initial));
    final TextValidator str = TextValidator.dirty(value);
    emit(
      state.copyWith(
        otp4: str,
        // status: Formz.validate([str, state.email]),
      ),
    );
  }

  /// pass the login credentials to the unknown rest api and making the call now
  /// will have different api to test the real user....right now we are mocking with existing token user sample
  Future<void> verifyOTP({required String email}) async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(status: EnterOptStatus.loading));
    try {
      final String otp =
          "${state.otp1.value}${state.otp2.value}${state.otp3.value}${state.otp4.value}";
      ResetPasswordVerifyOTPPayload _payload =
          ResetPasswordVerifyOTPPayload(email: email, otp: otp);
      Map<String, dynamic> response =
          await _authenticationRepository.verifyOTPToResetPassword(_payload);
      //print(response);
      if (response['status'] == 'success') {
        emit(
          state.copyWith(
            status: EnterOptStatus.success,
            token: response['token'],
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: EnterOptStatus.failure,
            errorMessage: response["message"],
          ),
        );
      }
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      // debugPrint(e.toString());
      emit(
        state.copyWith(
          errorMessage: e.message,
          // status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: EnterOptStatus.failure));
    }
  }
}
