import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/pages/widgets/widgets.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripListViewWidgetMobile extends StatefulWidget {
  final List<Trip> trips;
  final GlobalKey? globalKey;
  const TripListViewWidgetMobile(
      {Key? key, required this.trips, this.globalKey})
      : super(key: key);

  @override
  State<TripListViewWidgetMobile> createState() =>
      _TripListViewWidgetMobileState();
}

class _TripListViewWidgetMobileState extends State<TripListViewWidgetMobile> {
  @override
  Widget build(BuildContext context) {
    final List<Trip> _trips = widget.trips;
    return ListView.builder(
      itemCount: _trips.length,
      itemBuilder: (BuildContext context, int index) {
        Trip trip = _trips[index];
        return Accordion(
          title: trip.tripNumber,
          guid: trip.guid,
          tripNumber: trip.tripNumber,
          tripStatus: trip.tripStatus,
          isDashboard: true,
          isLast: index == (_trips.length - 1),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TripRowDetail(
                  header: 'Reg No',
                  value: trip.regNo,
                  isShadow: true,
                ),
                TripRowDetail(
                  header: 'Route',
                  value: trip.route!.join(', '),
                ),
                TripRowDetail(
                  header: 'File Status',
                  value: trip.fileStatus,
                  isShadow: true,
                ),
                TripRowDetail(
                  header: 'ETA',
                  value: trip.start,
                ),
                TripRowDetail(
                  header: 'ETD',
                  value: trip.end,
                  isShadow: true,
                ),
                TripRowDetail(
                  header: 'Callsign',
                  value: trip.callsign,
                ),
                TripRowDetail(
                  header: 'Flight Category',
                  value: trip.flightCategory,
                  isShadow: true,
                ),
                TripRowDetail(
                  header: 'Aircraft Type',
                  value: trip.acType,
                ),
                TripRowDetail(
                  header: 'Operator',
                  value: trip.operator,
                  isShadow: true,
                ),
                index == (_trips.length - 1) ? height(50) : Container()
              ],
            ),
          ),
        );
      },
    );
  }
}

class TripRowDetail extends StatelessWidget {
  final bool? isShadow;
  final String header;
  final String value;
  final bool? showArrow;
  const TripRowDetail({
    Key? key,
    this.isShadow = false,
    required this.header,
    required this.value,
    this.showArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            isShadow! ? const Color.fromARGB(233, 237, 235, 235) : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(header),
            ),
          ),
          Flexible(
            child: Text(
              value,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: header == 'File Status'
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : const TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
