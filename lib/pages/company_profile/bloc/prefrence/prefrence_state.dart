part of 'prefrence_bloc.dart';

enum PrefrenceListStatus { initial, loading, success, failure }

class PrefrenceState extends Equatable {
  final PrefrenceListStatus status;
  final List<Prefrence> prefrences;
  const PrefrenceState({required this.status, required this.prefrences});

  @override
  List<Object> get props => [status, prefrences];
}

class PrefrenceInitial extends PrefrenceState {
  PrefrenceInitial({required PrefrenceListStatus status})
      : super(status: status, prefrences: []);
}
