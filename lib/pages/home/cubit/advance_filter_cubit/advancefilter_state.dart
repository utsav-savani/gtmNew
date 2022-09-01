part of 'advancefilter_cubit.dart';

//enum AdvanceFilterStatus { initial, loading, success, failure }

class AdvanceFilterState extends Equatable {
  /*  final TripManagerFilter? filter;
  final List<Trip> tripList;
  final AdvanceFilterStatus status;
  final String message;
  const AdvanceFilterState({
    this.filter,
    this.tripList = const [],
    this.status = AdvanceFilterStatus.initial,
    this.message = '',
  });

  AdvanceFilterState copyWith({
    TripManagerFilter? filter,
    List<Trip>? tripList,
    AdvanceFilterStatus? status,
    String? message,
  }) {
    return AdvanceFilterState(
        filter: filter ?? this.filter,
        tripList: tripList ?? this.tripList,
        status: status ?? this.status,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [
        filter!,
        tripList,
        status,
        message,
      ]; */

  const AdvanceFilterState();
  @override
  List<Object> get props => [];
}

class InitiateAdvanceFilter extends AdvanceFilterState {
  final TripManagerFilter? filter;
  final List<Trip> tripList;
  final String message;

  const InitiateAdvanceFilter(
    this.filter,
    this.tripList,
    this.message,
  );
  @override
  List<Object> get props => [
        filter!,
        tripList,
        message,
      ];
}

class AdvancFilterSuccess extends AdvanceFilterState {
  final List<Trip> tripList;
  final TripManagerFilter filter;

  const AdvancFilterSuccess(this.tripList, this.filter);

  @override
  List<Object> get props => [
        tripList,
        filter,
      ];
}

class AdvancFilterLoading extends AdvanceFilterState {
  @override
  List<Object> get props => [];
}

class AdvancFilterFailure extends AdvanceFilterState {
  final String message;

  const AdvancFilterFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AdvancFilterDataTableSuccess extends AdvanceFilterState {
  final TripDataTable dataTableSource;

  const AdvancFilterDataTableSuccess(this.dataTableSource);

  @override
  List<Object> get props => [dataTableSource];
}

class AdvancefilterInitial extends AdvanceFilterState {}
