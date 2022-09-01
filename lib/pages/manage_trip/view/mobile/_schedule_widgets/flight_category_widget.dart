import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/selectors/m_category_selector.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleFlightCategoryWidget extends StatelessWidget {
  final BuildContext context;
  final int sequence;
  final bool isEditableMode;
  final TripSchedulePrePayload payload;
  final TripManagerScheduleRepository repo;
  final Function updateWidgetHandler;
  final bool isLastSequence;
  final bool? isMobile;
  const TripScheduleFlightCategoryWidget({
    Key? key,
    required this.context,
    required this.sequence,
    required this.isEditableMode,
    required this.payload,
    required this.repo,
    required this.updateWidgetHandler,
    required this.isLastSequence,
    this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool _isMobile = isMobile ?? false;
    FlightCategory? _category = payload.flightCategory();
    String _categoryName = "";
    if (_category != null) _categoryName = _category.category;
    return InkWell(
      onTap: () => _openFlightCategory(tripPayload: payload),
      child: Container(
        decoration: drodownDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: spacing64,
                child: label("Category"),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: spacing120),
                child: Text(
                  _categoryName,
                  style: const TextStyle(
                    fontSize: spacing13,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.powderBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openFlightCategory({
    required TripSchedulePrePayload tripPayload,
  }) async {
    if (!isEditableMode) return;
    Customer customer = await UserRepository().getCustomer();
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: MCategorySelector(
            customerId: "${customer.customerId}",
            categorySelectHandler: (FlightCategory category) async {
              repo.setFlightCategoryId(
                index: sequence - 1,
                flightCategory: category,
                categoryId: category.flightCategoryId,
              );
              Navigator.pop(context);
              updateWidgetHandler();
            },
          ),
        );
      },
    );
  }
}
