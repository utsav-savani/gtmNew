part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterAccount extends RegisterEvent {
  final AccountPayload account;
  const RegisterAccount({required this.account});

  @override
  List<Object> get props => [account];
}

class ResetRegister extends RegisterEvent {
  final RegisterStatus status;
  const ResetRegister({required this.status});
}
