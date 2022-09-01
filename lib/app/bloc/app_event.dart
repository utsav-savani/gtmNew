// ignore_for_file: always_specify_types

part of 'app_bloc.dart';

///
abstract class AppEvent extends Equatable {
  ///
  const AppEvent();

  @override
  List<Object> get props => [];
}

///
class AppLogoutRequested extends AppEvent {}

///
class AppUserChanged extends AppEvent {
  ///
  const AppUserChanged(this.dataUser);

  ///
  final String dataUser;

  @override
  List<Object> get props => [dataUser];
}
