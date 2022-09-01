import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/flight_category/bloc/flight_category_bloc.dart';

class MFlightCategoryListPage extends StatefulWidget {
  const MFlightCategoryListPage({Key? key}) : super(key: key);

  @override
  State<MFlightCategoryListPage> createState() =>
      _MFlightCategoryListPageState();
}

class _MFlightCategoryListPageState extends State<MFlightCategoryListPage> {
  List<FlightCategory> _categories = <FlightCategory>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Flight Categories'.translate()),
      body: BlocListener<FlightCategoryBloc, FlightCategoryState>(
        listener: (context, state) {
          if (state.status == FetchCategoriesStatus.initial) {
            _categories = (context.read<FlightCategoryBloc>()
                  ..add(const FetchFlightCategoryData(customerID: 93)))
                as List<FlightCategory>;
          }
          if (state.status == FetchCategoriesStatus.loading) {
            // AppLoader(context).show(title: 'loading');
          }
          if (state.status == FetchCategoriesStatus.success) {
            // AppLoader(context).hide();
          }
          // TODO: implement listener
        },
        child: BlocBuilder<FlightCategoryBloc, FlightCategoryState>(
          builder: (context, state) {
            if (state.status == FetchCategoriesStatus.success) {
              _categories = state.flightcategories ?? <FlightCategory>[];
            }
            if (state.status == FetchCategoriesStatus.loading) {
              //TODO:// Here need to load the loader when the request goes to API
            }
            if (_categories.isEmpty) {
              return Center(
                child: Text("noDataFound".translate()),
              );
            }

            return ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                FlightCategory _flightCategory = _categories[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      "$index ${_flightCategory.category} ${_flightCategory.flightCategoryId}",
                    ),
                    subtitle: Text(
                      _flightCategory.customerId.toString(),
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
