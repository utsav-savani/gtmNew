part of 'register_bloc.dart';

enum RegisterStatus { inital, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final AccountPayload? account;

  const RegisterState({
    this.status = RegisterStatus.inital,
    this.account,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    required AccountPayload account,
  }) {
    return RegisterState(
      status: status ?? this.status,
      account: account,
    );
  }

  @override
  List<Object?> get props => [status, account];
}

class RegisterInitial extends RegisterState {}
