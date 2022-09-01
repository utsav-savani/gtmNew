// part of 'paginated_aircraft_bloc.dart';

// enum FetchAircraftsStatus { initial, loading, success, failure }

// class PaginatedAircraftState extends Equatable {
//   final FetchAircraftsStatus status;
//   final AircraftData? aircraft;

//   const PaginatedAircraftState({
//     this.status = FetchAircraftsStatus.initial,
//     this.aircraft,
//   });

//   PaginatedAircraftState copyWith({
//     FetchAircraftsStatus? status,
//     required AircraftData aircraft,
//   }) {
//     return PaginatedAircraftState(
//       status: status ?? this.status,
//       aircraft: aircraft,
//     );
//   }

//   @override
//   List<Object?> get props => [status, aircraft];
// }
