import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/bloc/_schedule/trip_cancelled_sequence_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/_schedule/trip_cancelled_sequence_state.dart';

class CancelledSequenceDrawer extends StatefulWidget {
  const CancelledSequenceDrawer({Key? key}) : super(key: key);

  @override
  State<CancelledSequenceDrawer> createState() =>
      _CancelledSequenceDrawerState();
}

class _CancelledSequenceDrawerState extends State<CancelledSequenceDrawer> {
  @override
  Widget build(BuildContext context) {
    print("===");
    return Scaffold(
      body: BlocListener<TripCancelledSequenceBloc, TripCancelledSequenceState>(
        listener: (context, state) {},
        child:
            BlocBuilder<TripCancelledSequenceBloc, TripCancelledSequenceState>(
          builder: (context, personsState) {
            switch (personsState.status) {
              case TripCancelledSequenceStatus.initial:
              case TripCancelledSequenceStatus.loading:
                return loadingWidget();
              case TripCancelledSequenceStatus.success:
                return const Text("=======");
              case TripCancelledSequenceStatus.failure:
                return noDataFoundWidget();
            }
          },
        ),
      ),
    );
  }
}
