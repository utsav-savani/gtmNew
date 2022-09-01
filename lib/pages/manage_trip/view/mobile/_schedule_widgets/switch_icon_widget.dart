import 'package:flutter/cupertino.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleUTCLCLWidget extends StatelessWidget {
  final bool utc;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  const TripScheduleUTCLCLWidget({
    Key? key,
    required this.repo,
    required this.utc,
    required this.updateWidgetHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: spacing128,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("LCL"),
          CupertinoSwitch(
            value: utc,
            onChanged: (bool value) {
              repo.setUTC(
                isUTC: value,
              );
              updateWidgetHandler(value);
            },
          ),
          const Text("UTC"),
        ],
      ),
    );
  }
}
