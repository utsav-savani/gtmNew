import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:gtm/pages/login/models/models.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  /// email address state management
  void emailChanged(String value) {
    final Email email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        password: state.password,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  /// password  state management
  void passwordChanged(String value) {
    final Password password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        email: state.email,
        // status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository
          .logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      )
          .then((value) {
        emit(
          state.copyWith(status: FormzStatus.submissionSuccess),
        );
      });
    } on LogInWithEmailAndPasswordFailure catch (e) {
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
