import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:gtm/pages/login/models/models.dart';

part 'm_reset_password_state.dart';

///
class MResetPasswordCubit extends Cubit<MResetPasswordState> {
  ///
  MResetPasswordCubit(this._authenticationRepository)
      : super(const MResetPasswordState());

  final AuthenticationRepository _authenticationRepository;

  /// password address state management
  void passwordChanged(String value) {
    final TextValidator str = TextValidator.dirty(value);
    emit(
      state.copyWith(
        password: str,
        // status: Formz.validate([str, state.email]),
      ),
    );
  }

  /// password address state management
  void confirmPasswordChanged(String value) {
    final TextValidator str = TextValidator.dirty(value);
    emit(
      state.copyWith(
        cpassword: str,
        // status: Formz.validate([str, state.email]),
      ),
    );
  }

  /// pass the login credentials to the unknown rest api and making the call now
  /// will have different api to test the real user....right now we are mocking with existing token user sample
  Future<void> updatePassword({required String token}) async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final String password = state.password.value;
      final String cpassword = state.cpassword.value;
      ResetPasswordPayload _payload = ResetPasswordPayload(
        password: password,
        confirm_password: cpassword,
      );
      var res = await _authenticationRepository.resetPassword(
        payload: _payload,
        token: token,
      );
      //print(res);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      // debugPrint(e.toString());
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
