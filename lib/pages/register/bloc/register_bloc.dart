import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository _authenticationRepository;

  RegisterBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    on<RegisterAccount>(_registerUser);
    on<ResetRegister>(_resetBloc);
  }

  Future<void> _registerUser(
    RegisterAccount event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
        state.copyWith(status: RegisterStatus.loading, account: event.account));
    try {
      AccountPayload account = event.account;
      // TODO fetch country from current location
      await _authenticationRepository.createAccount(
          _authenticationRepository.generateAccountPayload(
              firstName: account.firstName,
              companyName: account.companyName,
              emailAddress: account.emailAddress,
              location: 'india'));
      await Future<void>.delayed(const Duration(seconds: 5));
      emit(state.copyWith(
        status: RegisterStatus.success,
        account: event.account,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          account: event.account, status: RegisterStatus.failure));
    }
  }

  _resetBloc(ResetRegister event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
        account: AccountPayload(), status: RegisterStatus.inital));
  }
}
