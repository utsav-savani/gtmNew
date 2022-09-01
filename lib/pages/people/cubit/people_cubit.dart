import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:people_repository/people_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit({required this.peopleRepository})
      : super(const PeopleState(customers: [], people: []));
  PeopleRepository peopleRepository;

  Future<void> getPeople() async {
    emit(state.copyWith(
        people: [],
        status: FetchPeopleStatus.loading,
        customers: state.customers));
    try {
      final people = await peopleRepository.getPeoples();
      final customers = await UserRepository().getCustomers();
      emit(state.copyWith(
          people: people,
          status: FetchPeopleStatus.success,
          customers: customers));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          people: state.people,
          status: FetchPeopleStatus.failure,
          customers: state.customers));
    }
  }
}
