import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:gtm/pages/login/models/models.dart';

part 'm_register_state.dart';

///
class MRegisterCubit extends Cubit<MRegiserState> {
  ///
  MRegisterCubit(this._authenticationRepository) : super(const MRegiserState());

  final AuthenticationRepository _authenticationRepository;

  /// email address state management
  void emailChanged(String value) {
    emit(state.copyWith(status: RegisterFormStatus.initial));
    final Email str = Email.dirty(value);
    emit(
      state.copyWith(
        email: str,
        // status: Formz.validate([str, state.email]),
      ),
    );
  }

  /// Company name state management
  void companyNameChanged(String value) {
    emit(state.copyWith(status: RegisterFormStatus.initial));
    final TextValidator str = TextValidator.dirty(value);
    emit(
      state.copyWith(
        companyName: str,
        // status: Formz.validate([state.companyName, str]),
      ),
    );
  }

  /// name state management
  void nameChanged(String value) {
    emit(state.copyWith(status: RegisterFormStatus.initial));
    final TextValidator str = TextValidator.dirty(value);
    emit(
      state.copyWith(
        name: str,
        // status: Formz.validate([state.name, str]),
      ),
    );
  }

  /// pass the login credentials to the unknown rest api and making the call now
  /// will have different api to test the real user....right now we are mocking with existing token user sample
  Future<void> createAccount() async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(status: RegisterFormStatus.loading));
    try {
      AccountPayload _payload = AccountPayload(
        companyName: state.companyName.value,
        firstName: state.name.value,
        emailAddress: state.email.value,
        location: 'Dubai',
        //TODO: This has to be dynamic location, this is static basically, i am from india and i am in Dubai, then the current location is not correct
      );
      var res = await _authenticationRepository.createAccount(_payload);
      //print(res);
      emit(state.copyWith(status: RegisterFormStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      // debugPrint(e.toString());
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: RegisterFormStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: RegisterFormStatus.failure));
    }
  }
}
