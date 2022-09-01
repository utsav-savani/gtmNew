import 'package:flutter/material.dart';
import 'package:gtm/_shared/constants/string_constants.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:gtm/_shared/widgets/_common/spacing.dart';
import 'package:gtm/_shared/widgets/_common/widget_size.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ExpandableTripBar extends StatefulWidget {
  final TripDetail tripDetail;

  const ExpandableTripBar({Key? key, required this.tripDetail})
      : super(key: key);

  @override
  State<ExpandableTripBar> createState() => _ExpandableTripBarState();
}

class _ExpandableTripBarState extends State<ExpandableTripBar>
    with SingleTickerProviderStateMixin {
  late AnimationController transitionAnimation;

  @override
  void didChangeDependencies() {
    transitionAnimation = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          child: AnimatedBuilder(
            animation: transitionAnimation,
            builder: (context, child) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: const Offset(0, 0),
                  ).animate(CurvedAnimation(
                      curve: Curves.linear, parent: transitionAnimation)),
                  child: child);
            },
            child: Row(children: [
              Padding(
                padding: paddingLarge,
                child: SizedBox(
                  width: spacing152,
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(spacing16),
                        borderSide: const BorderSide(
                          color: AppColors.powderBlue,
                        ),
                      ),
                      labelText: tripId,
                    ),
                    enabled: false,
                    controller: TextEditingController()
                      ..text = widget.tripDetail.tripNumber ?? '',
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: spacing152,
                    child: TextFormField(
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(spacing16),
                              bottomLeft: Radius.circular(spacing16),
                              bottomRight: Radius.zero,
                              topRight: Radius.zero),
                          borderSide: BorderSide(
                            color: AppColors.defaultColor,
                          ),
                        ),
                        labelText: customer,
                      ),
                      enabled: false,
                      controller: TextEditingController()
                        ..text = widget.tripDetail.customerName!,
                    ),
                  ),
                  Container(
                    width: spacing26,
                    child: const Center(
                      child: Icon(Icons.switch_right_rounded),
                    ),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: spacing152,
                    child: TextFormField(
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.zero,
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.circular(spacing16),
                            topRight: Radius.circular(spacing16),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.defaultColor,
                          ),
                        ),
                        labelText: operator,
                      ),
                      enabled: false,
                      controller: TextEditingController()
                        ..text = widget.tripDetail.customerName!,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: paddingLarge,
                child: Row(
                  children: [
                    SizedBox(
                      width: spacing152,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(spacing16),
                            borderSide: const BorderSide(
                              color: AppColors.defaultColor,
                            ),
                          ),
                          labelText: primaryAC,
                        ),
                        enabled: false,
                        controller: TextEditingController()
                          ..text =
                              widget.tripDetail.primaryAircraftId.toString(),
                      ),
                    ),
                    SizedBox(
                      width: spacing152,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(spacing16),
                            borderSide: const BorderSide(
                              color: AppColors.defaultColor,
                            ),
                          ),
                          labelText: subsituteAc,
                        ),
                        enabled: false,
                        controller: TextEditingController()
                          ..text =
                              widget.tripDetail.primaryAircraftId.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: paddingLarge,
                child: Row(
                  children: [
                    SizedBox(
                      width: spacing152,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(spacing16),
                            borderSide: const BorderSide(
                              color: AppColors.defaultColor,
                            ),
                          ),
                          labelText: tripStatus,
                        ),
                        enabled: false,
                        controller: TextEditingController()
                          ..text = widget.tripDetail.tripStatus ?? '',
                      ),
                    ),
                    SizedBox(
                      width: spacing152,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(spacing16),
                            borderSide: const BorderSide(
                              color: AppColors.defaultColor,
                            ),
                          ),
                          labelText: fileStatus,
                        ),
                        enabled: false,
                        controller: TextEditingController()
                          ..text = widget.tripDetail.fileStatus.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: paddingLarge,
                child: SizedBox(
                  width: spacing152,
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(spacing16),
                        borderSide: const BorderSide(
                          color: AppColors.defaultColor,
                        ),
                      ),
                      labelText: submit,
                    ),
                    enabled: false,
                    controller: TextEditingController()
                      ..text = widget.tripDetail.accountStatus.toString(),
                  ),
                ),
              ),
              Padding(
                padding: paddingLarge,
                child: SizedBox(
                  width: spacing152,
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(spacing16),
                        borderSide: const BorderSide(
                          color: AppColors.defaultColor,
                        ),
                      ),
                      labelText: request,
                    ),
                    enabled: false,
                    controller: TextEditingController()
                      ..text = widget.tripDetail.tripStatus ?? '',
                  ),
                ),
              ),
            ]),
          ),
        ),
        Align(
          child: ElevatedButton(
            onPressed: () {
              if (transitionAnimation.isCompleted) {
                transitionAnimation.reverse();
                return;
              }
              transitionAnimation.forward();
            },
            child: const Text('expand'),
          ),
        ),
      ],
    );
  }
}
