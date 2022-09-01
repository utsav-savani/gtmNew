part of 'prefrence_bloc.dart';

abstract class PrefrenceEvent extends Equatable {
  const PrefrenceEvent();

  @override
  List<Object> get props => [];
}

class FetchPrefrenceEvent extends PrefrenceEvent {
  final int customerId;
  final int page;
  const FetchPrefrenceEvent({required this.customerId, required this.page});
}
