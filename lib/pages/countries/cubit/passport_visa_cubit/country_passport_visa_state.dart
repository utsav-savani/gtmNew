part of 'country_passport_visa_cubit.dart';

enum FetchPassportVisaStatus { initial, loading, success, failure }

class CountryPassportVisaState extends Equatable {
  final FetchPassportVisaStatus status;
  final List<PassportVisa>? passportVisa;

  const CountryPassportVisaState({
    this.status = FetchPassportVisaStatus.initial,
    this.passportVisa,
  });

  CountryPassportVisaState copyWith({
    FetchPassportVisaStatus? status,
    required List<PassportVisa> passportVisa,
  }) {
    return CountryPassportVisaState(
      status: status ?? this.status,
      passportVisa: passportVisa,
    );
  }

  @override
  List<Object?> get props => [status, passportVisa];
}
