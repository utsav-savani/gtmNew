part of 'm_register_cubit.dart';

enum RegisterFormStatus { initial, loading, success, failure }

class MRegiserState extends Equatable {
  const MRegiserState({
    this.email = const Email.pure(),
    this.companyName = const TextValidator.pure(),
    this.name = const TextValidator.pure(),
    this.status = RegisterFormStatus.initial,
    this.errorMessage,
  });

  final Email email;
  final TextValidator companyName;
  final TextValidator name;
  final RegisterFormStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email, companyName, name, status];

  MRegiserState copyWith({
    Email? email,
    TextValidator? companyName,
    TextValidator? name,
    RegisterFormStatus? status,
    String? errorMessage,
  }) {
    return MRegiserState(
      email: email ?? this.email,
      companyName: companyName ?? this.companyName,
      name: name ?? this.name,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
