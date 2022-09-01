import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_overview_details_state.dart';

class TripOverviewDetailsCubit extends Cubit<TripOverviewDetailsState> {
  TripOverviewDetailsCubit(this.tripManagerRepository)
      : super(TripOverviewDetailsInitial());

  final TripManagerRepository tripManagerRepository;

  Future<void> getTripOverviewDetails(String guid) async {
    emit(TripOverviewDetailsLoading());
    try {
      final tripDetails =
          await tripManagerRepository.getTripManagerDetails(guid: guid);
      emit(TripOverviewDetailsSuccess(tripDetails));
    } catch (e) {
      log(e.toString());
      emit(TripOverviewDetailsFailure(e.toString()));
    }
  }

  changeTripTab(TabType? tabType) async {
    emit(TripOverviewDetailsLoading());
    try {
      final _tabType = tabType ?? TabType.tripData;
      emit(TripTabChanged(_tabType));
      await Future.delayed(Duration(seconds: 1));
      emit(TripTabChangeInitial());
    } catch (e) {
      log(e.toString());
      emit(TripOverviewDetailsFailure(e.toString()));
    }
  }
}

enum TabType { tripData, schedule, services, pob, doucuments, submitReview }
