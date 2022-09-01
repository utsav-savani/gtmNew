import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtm/pages/home/cubit/tab_cubit/tab_repository.dart';
import 'package:gtm/pages/home/home.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit({required this.tabRepository}) : super(const TabInitial());

  TabRepository tabRepository;

  Future<void> addTab(GtmTab tab) async {
    emit(TabLoading());
    try {
      final tabs = await tabRepository.addTabToList(tab);
      emit(TabSuccess(tabs));
    } catch (e) {
      log(e.toString());
      emit(TabFailure(e.toString()));
    }
  }

  Future<void> removeTab(GtmTab removeTab) async {
    emit(TabLoading());
    try {
      final tabs = await tabRepository.removeTabFromList(removeTab);
      log("tab removed");
      emit(TabSuccess(tabs));
    } catch (e) {
      log(e.toString());
      emit(TabFailure(e.toString()));
    }
  }

  Future<List<GtmTab>> getActiveTabs() async {
    emit(TabLoading());
    try {
      final tabs = await tabRepository.userSelectedTabs();
      return tabs;
    } catch (e) {
      log(e.toString());
      emit(TabFailure(e.toString()));
    }
    return [];
  }
}
