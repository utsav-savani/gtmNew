import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthenticationRepository _authenticationRepository;
  ResetPasswordBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const ResetPasswordState(
            newPassword: '', confirmPassword: '', token: '')) {
    on<SaveResetPassword>(_saveNewPassword);
  }

  _saveNewPassword(
      SaveResetPassword event, Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
        token: event.token,
        status: ResetPasswordStatus.loading));
    try {
      bool response = await _authenticationRepository.resetPassword(
        payload: _authenticationRepository.generateResetPasswordPayload(
            password: event.newPassword,
            confirm_password: event.confirmPassword),
        token: event.token,
      );
      if (response) {
        emit(state.copyWith(
          newPassword: event.newPassword,
          confirmPassword: event.confirmPassword,
          token: event.token,
          status: ResetPasswordStatus.success,
        ));
      } else {
        emit(state.copyWith(
          newPassword: event.newPassword,
          confirmPassword: event.confirmPassword,
          token: event.token,
          status: ResetPasswordStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
        token: event.token,
        status: ResetPasswordStatus.failure,
      ));
    }
  }
}
