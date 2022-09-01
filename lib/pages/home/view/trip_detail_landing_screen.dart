import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/view/m_trip_detail_page.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripDetailLandingScreen extends StatefulWidget {
  final String guid;
  const TripDetailLandingScreen({Key? key, required this.guid})
      : super(key: key);

  @override
  State<TripDetailLandingScreen> createState() =>
      _TripDetailLandingScreenState();
}

class _TripDetailLandingScreenState extends State<TripDetailLandingScreen> {
  TripDetail? tripDetail;
  @override
  void didChangeDependencies() {
    getTripDetailsData();
    super.didChangeDependencies();
  }

  getTripDetailsData() {
    TripDetailsBloc tripDetailsBloc = BlocProvider.of<TripDetailsBloc>(context);
    tripDetailsBloc.add(FetchTripDetails(guid: widget.guid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip Manager')),
      body: BlocListener<TripDetailsBloc, FetchTripDetailsState>(
        listener: (context, state) {
          if (state.status == FetchTripDetailsStatus.success) {
            tripDetail = state.tripDetail;
          }
        },
        child: BlocBuilder<TripDetailsBloc, FetchTripDetailsState>(
            buildWhen: (previous, current) {
          return previous.status != current.status;
        }, builder: (context, state) {
          if (state.status == FetchTripDetailsStatus.initial) {
            return loadingWidget();
          } else if (state.status == FetchTripDetailsStatus.loading) {
            return loadingWidget();
          } else if (tripDetail != null) {
            return MTripDetailWidget(tripDetail: tripDetail!);
          } else {
            return loadingWidget();
          }
        }),
      ),
    );
  }
}
