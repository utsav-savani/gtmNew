import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/libraries/app_loader.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleSaveButtonWidget extends StatelessWidget {
  final String guid;
  final bool isEditableMode;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  final bool? isMobile;
  const TripScheduleSaveButtonWidget({
    Key? key,
    required this.guid,
    required this.isEditableMode,
    required this.repo,
    required this.updateWidgetHandler,
    this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await AppLoader(context).show(title: "Saving Details...");
        await repo.saveTripSchedule(
          guid: guid,
        );
        AppHelper().showSnackBar(
          context,
          message: "Trip scheduled saved successfully",
        );
        await AppLoader(context).hide();
        updateWidgetHandler();
      },
      child: const Text('Save'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(130, 48),
      ),
    );
  }
}
