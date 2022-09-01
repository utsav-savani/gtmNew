import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/libraries/app_alert.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/enums/device_screen_type.dart';
import 'package:gtm/pages/aircraft/bloc/aircraft/aircraft_bloc.dart';
import 'package:gtm/pages/flight_category/bloc/flight_category_bloc.dart';
import 'package:gtm/pages/home/bloc/home_bloc.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:gtm/responsive/screen_type_layout.dart';
import 'package:gtm/utils/ui_utils.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class CreateTripModalWidget extends StatefulWidget {
  final Function? onCreateTrip;

  const CreateTripModalWidget({Key? key, this.onCreateTrip}) : super(key: key);

  @override
  State<CreateTripModalWidget> createState() => _CreateTripModalWidgetState();
}

class _CreateTripModalWidgetState extends State<CreateTripModalWidget> {
  Office? selectedOffice;
  Customer? selectedCustomer;
  Aircraft? selectedAircraft;
  Operator? selectedOperator;
  FlightCategory? selectedFlightCategory;
  bool selectedTripCostEstimate = false;
  TextEditingController customerReferenceTextController =
      TextEditingController();

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return ScreenTypeLayout(
        mobile: _buildMobile(context, homeBloc),
        tablet: _buildWeb(context, homeBloc),
        desktop: _buildWeb(context, homeBloc));
  }

  Widget _buildWeb(BuildContext context, HomeBloc homeBloc) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.blueBerryColor,
            height: spacing48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(spacing24, 0, 0, 0),
                child: Text(
                  createNewTrip,
                  style: Theme.of(context).textTheme.headline6!.merge(
                        const TextStyle(color: Colors.white),
                      ),
                ),
              ),
            ),
          ),
          height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOfficeDropdown(homeBloc),
              _buildCustomerDropdown(homeBloc),
            ],
          ),
          height(spacing20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAircraftDropdown(),
              _buildOperatorDropdown(),
            ],
          ),
          height(spacing20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFlightCategoryDropdown(),
              _buildCustomerRefWidget(),
            ],
          ),
          height(spacing20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildCreateButton(context),
              width(spacing24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(BuildContext context, HomeBloc homeBloc) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        height: MediaQuery.of(context).size.height - 100,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              appText(
                "New Trip",
                fontWeight: FontWeight.bold,
                color: AppColors.defaultColor,
                fontSize: 16,
              ),
              height(12),
              appText(
                "New trips are shown on dashboard.",
                color: AppColors.lightBlueGrey,
              ),
              height(12),
              SizedBox(
                width: spacing288,
                child: _buildOfficeDropdown(homeBloc),
              ),
              height(12),
              SizedBox(
                width: spacing288,
                child: _buildCustomerDropdown(homeBloc),
              ),
              height(12),
              SizedBox(
                width: spacing288,
                child: _buildAircraftDropdown(),
              ),
              height(12),
              SizedBox(
                width: spacing288,
                child: _buildOperatorDropdown(),
              ),
              height(12),
              SizedBox(
                width: spacing288,
                child: _buildFlightCategoryDropdown(),
              ),
              height(12),
              // _buildTripCostEstimateWidget(),
              // height(12),
              _buildCustomerRefWidget(),
              height(24),
              _buildCreateButton(context),
              height(24),
              _buildCancelWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfficeDropdown(HomeBloc homeBloc) {
    return FutureBuilder<List<Office>>(
      future: homeBloc.userRepository.getOffices(),
      builder: (context, snapshot) {
        List<Office> offices = snapshot.data ?? [];
        return CustomWidgets().buildDropdown<Office>(
          items: offices.map((Office office) {
            return DropdownMenuItem<Office>(
              value: office,
              child: Text(office.officeName),
            );
          }).toList(),
          onChanged: (office) {
            selectedOffice = office;
          },
          label: 'UAS Team',
          value: offices.contains(selectedOffice) ? selectedOffice : null,
        );
      },
    );
  }

  Widget _buildCustomerDropdown(HomeBloc homeBloc) {
    return FutureBuilder<List<Customer>>(
      future: homeBloc.userRepository.getCustomers(),
      builder: (context, snapshot) {
        List<Customer> customers = snapshot.data ?? [];
        return CustomWidgets().buildDropdown<Customer>(
          items: customers.map((Customer customer) {
            return DropdownMenuItem<Customer>(
              value: customer,
              child: Text(customer.name),
            );
          }).toList(),
          onChanged: (customer) {
            selectedCustomer = customer;
            if (selectedCustomer == null) {
              return;
            }
            AircraftBloc aircraftBloc = BlocProvider.of<AircraftBloc>(context);
            aircraftBloc.add(
              FetchAircraftData(
                customerID: selectedCustomer!.customerId.toString(),
              ),
            );
            FlightCategoryBloc flightCategoryBloc =
                BlocProvider.of<FlightCategoryBloc>(context);
            flightCategoryBloc.add(
              FetchFlightCategoryData(
                customerID: selectedCustomer!.customerId,
              ),
            );
          },
          label: 'Customer',
          value: customers.contains(selectedCustomer) ? selectedCustomer : null,
        );
      },
    );
  }

  Widget _buildAircraftDropdown() {
    return BlocBuilder<AircraftBloc, AircraftState>(
      builder: (context, state) {
        List<Aircraft> aircraft = state.aircrafts ?? [];
        return CustomWidgets().buildDropdown<Aircraft>(
          items: aircraft.map((Aircraft aircraft) {
            return DropdownMenuItem<Aircraft>(
              value: aircraft,
              child: Text(aircraft.registrationNumber),
            );
          }).toList(),
          onChanged: (aircraft) {
            selectedAircraft = aircraft;
            if (selectedAircraft == null) {
              return;
            }
            selectedOperator = null;
            OperatorBloc operatorBloc = BlocProvider.of<OperatorBloc>(context);
            operatorBloc.add(
              FetchOperatorData(
                aircraftID: selectedAircraft!.aircraftId.toString(),
              ),
            );
          },
          label: 'Aircraft',
          value: aircraft.contains(selectedAircraft) ? selectedAircraft : null,
        );
      },
    );
  }

  Widget _buildOperatorDropdown() {
    return BlocBuilder<OperatorBloc, OperatorState>(
      builder: (context, state) {
        List<Operator> operators = state.operators ?? [];
        return CustomWidgets().buildDropdown<Operator>(
          items: operators.map((Operator operator) {
            return DropdownMenuItem<Operator>(
              value: operator,
              child: Text(operator.customerName),
            );
          }).toList(),
          onChanged: (operator) {
            selectedOperator = operator;
          },
          label: 'Operator',
          value: operators.contains(selectedOperator) ? selectedOperator : null,
        );
      },
    );
  }

  Widget _buildFlightCategoryDropdown() {
    return BlocBuilder<FlightCategoryBloc, FlightCategoryState>(
      builder: (context, state) {
        List<FlightCategory> flightCategories = state.flightcategories ?? [];
        return CustomWidgets().buildDropdown<FlightCategory>(
          items: flightCategories.map((FlightCategory flightCategory) {
            return DropdownMenuItem<FlightCategory>(
              value: flightCategory,
              child: Text(flightCategory.category),
            );
          }).toList(),
          onChanged: (flightCategory) {
            selectedFlightCategory = flightCategory;
          },
          label: 'Flight Category',
          value: flightCategories.contains(selectedFlightCategory)
              ? selectedFlightCategory
              : null,
        );
      },
    );
  }

  // Widget _buildTripCostEstimateWidget() {
  //   return ConstrainedBox(
  //     constraints: const BoxConstraints(maxWidth: 280, maxHeight: spacing56),
  //     child: StatefulBuilder(
  //       builder:
  //           (BuildContext context, void Function(void Function()) setState) {
  //         return CustomWidgets().buildConstrainedTextFormField(TextFormField(
  //             readOnly: true,
  //             decoration: InputDecoration(
  //               hintText: requestTripCostEstimate,
  //               suffixIcon: selectedTripCostEstimate
  //                   ? IconButton(
  //                       icon: const Icon(Icons.check_box_rounded),
  //                       onPressed: () {
  //                         setState(() {
  //                           selectedTripCostEstimate =
  //                               !selectedTripCostEstimate;
  //                         });
  //                       },
  //                     )
  //                   : IconButton(
  //                       icon: const Icon(Icons.check_box_outline_blank_rounded),
  //                       onPressed: () {
  //                         setState(() {
  //                           selectedTripCostEstimate =
  //                               !selectedTripCostEstimate;
  //                         });
  //                       },
  //                     ),
  //             )));
  //       },
  //     ),
  //   );
  // }

  Widget _buildCustomerRefWidget() {
    return SizedBox(
      width: spacing288,
      child: TextFormField(
        controller: customerReferenceTextController,
        decoration: const InputDecoration(
          hintText: clientReference,
          labelText: "Client Reference",
        ),
      ),
    );
  }

  Widget _buildCancelWidget() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: spacing60,
            child: Text(
              "Cancel",
              style: TextStyle(color: AppColors.defaultColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, state) {
        if (state is CreateTripStateSuccess) {
          CreateTripStateSuccess result = state;
          TripDataResponse response = result.tripDataResponse;
          _navigateToTripManagerDetailScreen(response);
        }
      },
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is CreateTripStateSuccess) {
            AppHelper()
                .showSnackBar(context, message: 'Trip Created Successfully');
          }
          if (state is CreateTripStateFailure) {
            AppHelper().showSnackBar(context, message: 'Unable to Create Trip');
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is CreateTripStateLoading) {
              return const ElevatedButton(
                onPressed: null,
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: () {
                  if (selectedAircraft == null ||
                      selectedFlightCategory == null ||
                      selectedOffice == null ||
                      selectedCustomer == null ||
                      selectedOperator == null) {
                    AppAlert.show(
                      context,
                      body: 'Please select all the required fields',
                      buttonText: 'Okay',
                      title: 'Error Occurred',
                    );
                    return;
                  }
                  HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
                  homeBloc.add(
                    CreateTripEvent(
                      selectedAircraft!,
                      selectedFlightCategory!,
                      selectedOffice!,
                      selectedCustomer!.customerId,
                      selectedOperator!,
                      selectedTripCostEstimate,
                      customerReferenceTextController.text,
                    ),
                  );
                },
                child: const Text("Create"),
              );
            }
          },
        ),
      ),
    );
  }

  void _navigateToTripManagerDetailScreen(TripDataResponse response) {
    switch (getDeviceType(MediaQuery.of(context))) {
      case DeviceScreenType.mobile:
        context.push(Routes.tripDetailsScreen, extra: response.guid);
        break;
      case DeviceScreenType.tablet:
      case DeviceScreenType.desktop:
        Navigator.of(context).pop();
        if (widget.onCreateTrip != null) {
          widget.onCreateTrip!(response);
        }
        break;
    }
  }
}
