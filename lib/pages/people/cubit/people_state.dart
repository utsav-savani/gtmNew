part of 'people_cubit.dart';

enum FetchPeopleStatus { initial, loading, success, failure }

class PeopleState extends Equatable {
  final FetchPeopleStatus status;
  final List<People> people;
  final List<Customer> customers;

  const PeopleState({
    this.status = FetchPeopleStatus.initial,
    required this.people,
    required this.customers,
  });

  PeopleState copyWith(
      {FetchPeopleStatus? status,
      required List<People> people,
      required List<Customer> customers}) {
    return PeopleState(
        status: status ?? this.status, people: people, customers: customers);
  }

  @override
  List<Object?> get props => [status, people, customers];
}
