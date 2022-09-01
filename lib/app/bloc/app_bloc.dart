import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart' as localUserRepo;

part 'app_event.dart';

part 'app_state.dart';

///
class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  ///
  AppBloc({required AuthenticationRepository authenticationRepository, required localUserRepo.UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser.userId)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    _userLoggedIn = _authenticationRepository.loggedInUser.stream.listen((String? event) {
      add(AppUserChanged(event ?? ''));
      debugPrint(event.toString());
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final localUserRepo.UserRepository _userRepository;

  //late final StreamSubscription<AppStatus> _appStatus;

  late final StreamSubscription<User> _userSubscription;

  late final StreamSubscription<String?> _userLoggedIn;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    emit(event.dataUser.isNotEmpty ? AppState.authenticated(event.dataUser) : const AppState.unauthenticated());
    notifyListeners();
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) async {
    await (_authenticationRepository.logOut());
    emit(const AppState.unauthenticated());
    notifyListeners();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _authenticationRepository.dispose();
    _userLoggedIn.cancel();
    return super.close();
  }
}
