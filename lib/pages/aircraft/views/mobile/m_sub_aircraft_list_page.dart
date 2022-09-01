import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/aircraft/bloc/aircraft/aircraft_bloc.dart';

class MSubAircraftListPage extends StatefulWidget {
  const MSubAircraftListPage({Key? key}) : super(key: key);

  @override
  State<MSubAircraftListPage> createState() => _MSubAircraftListPageState();
}

class _MSubAircraftListPageState extends State<MSubAircraftListPage> {
  List<Aircraft> _aircrafts = <Aircraft>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Sub Aircraft'.translate()),
      body: BlocListener<AircraftBloc, AircraftState>(
        listener: (context, state) {
          if (state.status == FetchAircraftsStatus.initial) {
            _aircrafts = (context.read<AircraftBloc>()
              ..add(const FetchSubAircraftData())) as List<Aircraft>;
          }
          if (state.status == FetchAircraftsStatus.loading) {
            // AppLoader(context).show(title: 'loading');
          }
          if (state.status == FetchAircraftsStatus.success) {
            // AppLoader(context).hide();
          }
          // TODO: implement listener
        },
        child: BlocBuilder<AircraftBloc, AircraftState>(
          builder: (context, state) {
            //print(state.aircrafts);
            if (state.status == FetchAircraftsStatus.success) {
              _aircrafts = state.aircrafts ?? <Aircraft>[];
            }
            if (state.status == FetchAircraftsStatus.loading) {
              //TODO:// Here need to load the loader when the request goes to API
            }
            if (_aircrafts.isEmpty) {
              return Center(
                child: Text("noDataFound".translate()),
              );
            }

            return ListView.builder(
              itemCount: _aircrafts.length,
              itemBuilder: (BuildContext context, int index) {
                Aircraft _aircraft = _aircrafts[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      "${_aircraft.aircraftId.toString()} ${_aircraft.aircraftType!.fullName}",
                    ),
                    subtitle: Text(
                      _aircraft.registrationNumber,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
