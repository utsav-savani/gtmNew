import 'dart:async';

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:people_repository/people_repository.dart';
import 'package:uuid/uuid.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PeopleRepository _peopleRepository;
  PersonBloc({required PeopleRepository peopleRepository})
      : _peopleRepository = peopleRepository,
        super(PeopleInitial(detailStatus: FetchPersonDetailStatus.initial)) {
    on<FetchPersonDetailEvent>(_fetchPersonDetails);
    on<UploadPassportEvent>(_uploadPassport);
    on<UploadVisaEvent>(_uploadVisa);
    on<UpdateCustomerDataEvent>(_updateCustomerData);
    on<UpdateAddressCity>(_updateAddressCity);
    on<UpdateBirthCity>(_upateBirthCity);
  }

  FutureOr<void> _fetchPersonDetails(
      FetchPersonDetailEvent event, Emitter<PersonState> emit) async {
    try {
      state.detailStatus = FetchPersonDetailStatus.loading;
      emit(copyWith(state));
      final customers = await UserRepository().getCustomers();
      final countries = await _peopleRepository.getCountryList();
      final res = await _peopleRepository.fetchPersonDetails(event.guid);
      String guid = const Uuid().v1();
      if (event.guid != null) {
        guid = event.guid!;
      }
      Map<int, Country> countryIdMap = {
        for (var v in countries) v.countryId: v
      };
      List<City> birthCities = [];
      List<City> addressCity = [];
      if (res != null) {
        if (res.birthCountryId != null) {
          if (countryIdMap.containsKey(res.birthCountryId)) {
            birthCities = await _peopleRepository
                .fetchCities(countryIdMap[res.birthCountryId]!.countryName!);
          }
        }
        if (res.countryId != null) {
          if (countryIdMap.containsKey(res.countryId)) {
            if (res.birthCountryId != null &&
                res.birthCountryId == res.countryId) {
              addressCity = birthCities;
            } else {
              addressCity = await _peopleRepository
                  .fetchCities(countryIdMap[res.countryId]!.countryName!);
            }
          }
        }
      }
      emit(PersonState(
          detailStatus: FetchPersonDetailStatus.success,
          personDetails: res,
          isPassenger: event.isPassenger,
          guid: guid,
          countries: countryIdMap,
          birthCities: {for (var v in birthCities) v.cityId: v},
          addressCities: {for (var v in addressCity) v.cityId: v},
          customers: customers));
    } catch (e) {
      emit(PersonState(
          detailStatus: FetchPersonDetailStatus.failure,
          isPassenger: state.isPassenger,
          guid: state.guid,
          countries: state.countries,
          birthCities: state.birthCities,
          addressCities: state.addressCities,
          customers: state.customers));
    }
  }

  FutureOr<void> _uploadPassport(
      UploadPassportEvent event, Emitter<PersonState> emit) async {
    state.detailStatus = FetchPersonDetailStatus.loading;
    emit(copyWith(state));
    try {
      bool res;
      if (event.documentDetails.personPassportDocumentId == null) {
        res = await _peopleRepository.uploadPassportData(
            filesToUpload: event.filesToUpload,
            documentDetails: event.documentDetails);
      } else {
        res = await _peopleRepository.updatePassportData(
            filesToUpload: event.filesToUpload,
            documentDetails: event.documentDetails);
      }
      if (res) {
        final details = await _peopleRepository
            .fetchPersonDetails(event.documentDetails.guid);
        state.personDetails = details;
        state.detailStatus = FetchPersonDetailStatus.success;
        emit(copyWith(state));
      } else {
        state.detailStatus = FetchPersonDetailStatus.failure;
        emit(copyWith(state));
      }
    } catch (e) {
      state.detailStatus = FetchPersonDetailStatus.failure;
      emit(copyWith(state));
    }
  }

  FutureOr<void> _uploadVisa(
      UploadVisaEvent event, Emitter<PersonState> emit) async {
    state.detailStatus = FetchPersonDetailStatus.loading;
    emit(copyWith(state));
    try {
      bool res;
      if (event.documentDetails.visaId == null) {
        res = await _peopleRepository.uploadVisaData(
            filesToUpload: event.filesToUpload,
            documentDetails: event.documentDetails);
      } else {
        res = await _peopleRepository.updateVisaData(
            filesToUpload: event.filesToUpload,
            documentDetails: event.documentDetails);
      }
      if (res) {
        final details = await _peopleRepository
            .fetchPersonDetails(event.documentDetails.guid);
        state.personDetails = details;
        state.detailStatus = FetchPersonDetailStatus.success;
        emit(copyWith(state));
      } else {
        state.detailStatus = FetchPersonDetailStatus.failure;
        emit(copyWith(state));
      }
    } catch (e) {
      state.detailStatus = FetchPersonDetailStatus.failure;
      emit(copyWith(state));
    }
  }

  FutureOr<void> _updateCustomerData(
      UpdateCustomerDataEvent event, Emitter<PersonState> emit) async {
    state.detailStatus = FetchPersonDetailStatus.loading;
    emit(copyWith(state));
    try {
      final res = await _peopleRepository.updatePersonData(
          event.formData, event.customerId, event.guid, event.isPassenger);
      final personDetails =
          await _peopleRepository.fetchPersonDetails(event.guid);
      if (res && personDetails != null) {
        state.detailStatus = FetchPersonDetailStatus.success;
        state.personDetails = personDetails;
        emit(copyWith(state));
      } else {
        state.detailStatus = FetchPersonDetailStatus.failure;
        emit(copyWith(state));
      }
    } catch (e) {
      state.detailStatus = FetchPersonDetailStatus.failure;
      emit(copyWith(state));
    }
  }

  FutureOr<void> _updateAddressCity(
      UpdateAddressCity event, Emitter<PersonState> emit) async {
    List<City> res = await _peopleRepository.fetchCities(event.country);
    if (res.isNotEmpty) {
      state.addressCities = {for (var item in res) item.cityId: item};
      emit(state);
    }
  }

  FutureOr<void> _upateBirthCity(
      UpdateBirthCity event, Emitter<PersonState> emit) {}
}
