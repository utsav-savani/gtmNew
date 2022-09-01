import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/save_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_state.dart';

class TripServiceFormSubmitButtonsWidget extends StatelessWidget {
  final BuildContext context;
  final String guid;
  final TripServiceBloc tripServiceBloc;
  final TripServiceState state;
  final VoidCallback updateSetstate;
  final VoidCallback fetchTripService;
  const TripServiceFormSubmitButtonsWidget({
    Key? key,
    required this.context,
    required this.guid,
    required this.tripServiceBloc,
    required this.state,
    required this.updateSetstate,
    required this.fetchTripService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildDiscardButton(),
              _buildSaveButton(state: state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDiscardButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        child: TextButton(
          onPressed: () {
            if (TripServiceBloc.payload.isEmpty) {
              tripServiceBloc.add(DiscardChanges());
              updateSetstate();
              return;
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Unsaved Changes'),
                  content: const Text(
                    'Are you sure want to discard the changes?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        tripServiceBloc.add(DiscardChanges());
                        Navigator.of(context).pop();
                        updateSetstate();
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Discard'),
        ),
        visible: tripServiceBloc.editMode,
      ),
    );
  }

  Widget _buildSaveButton({required TripServiceState state}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (!tripServiceBloc.editMode) {
            tripServiceBloc.add(EditServices());
            updateSetstate();
            return;
          }
          if (TripServiceBloc.payload.isEmpty) {
            AppHelper().showSnackBar(
              context,
              message: 'No changes made to save',
            );
            return;
          }
          SaveServiceBloc saveServiceBloc = BlocProvider.of(context);

          final service = SaveService(
            guid: guid,
            tripServiceSchedulePayload: TripServiceBloc.payload,
            flightCategoryId:
                state.tripServiceMain.schedule![0].flightCategoryId ?? 0,
          );
          saveServiceBloc.add(service);
        },
        child: BlocListener<SaveServiceBloc, SaveServiceState>(
          listener: (context, state) {
            if (state == SaveServiceState.success) {
              AppHelper().showSnackBar(context, message: 'Saved Successfully');
              fetchTripService();
            } else if (state == SaveServiceState.failure) {
              AppHelper().showSnackBar(
                context,
                message: 'Failed to save service data',
              );
            }
          },
          child: BlocBuilder<SaveServiceBloc, SaveServiceState>(
            builder: (context, state) {
              switch (state) {
                case SaveServiceState.initial:
                case SaveServiceState.success:
                case SaveServiceState.failure:
                  if (tripServiceBloc.editMode) {
                    return const Text('Save');
                  } else {
                    return const Text('Edit');
                  }
                case SaveServiceState.loading:
                  return CustomWidgets().buildCircularProgressSmall(
                    color: Colors.white,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
