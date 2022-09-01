import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/cubit/health_cubit/country_health_cubit.dart';

class WCountryHealthPage extends StatefulWidget {
  final Country country;

  const WCountryHealthPage({required this.country, Key? key}) : super(key: key);

  @override
  State<WCountryHealthPage> createState() => _WCountryHealthPageState();
}

class _WCountryHealthPageState extends State<WCountryHealthPage> {
  Health? _health;

  @override
  void didChangeDependencies() {
    // fetchCountryHealth();
    super.didChangeDependencies();
  }

  // fetchCountryHealth() {
  //   context.read<CountryHealthCubit>().getCountryHealthInfo(widget.country.countryId!);
  //   // CountryHealthInfoBloc countryHealthInfoBloc = BlocProvider.of<CountryHealthInfoBloc>(context);
  //   // countryHealthInfoBloc.add(FetchCountryHealthInfo(widget.country.countryId ?? 0));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CountryHealthCubit, CountryHealthState>(
        listener: (context, state) {},
        child: BlocBuilder<CountryHealthCubit, CountryHealthState>(
          builder: (context, state) {
            if (state is CountryHealthInitial) {
              context
                  .read<CountryHealthCubit>()
                  .getCountryHealthInfo(widget.country.countryId!);
            }
            if (state is CountryHealthSuccess) {
              _health = state.countryHealth;
            }
            return _health != null
                ? Padding(
                    padding: const EdgeInsets.all(spacing8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView(
                          children: [
                            getListTile(
                                mandatoryVaccines, _health!.mondatoryVaccine),
                            getListTile(
                                routineVaccines, _health!.routineVaccine),
                            getListTile(recommendedVaccines,
                                _health!.recommendedVaccine),
                            getListTile(warnings, _health!.warnings),
                            getListTile(covid19Testing, _health!.cOVIDTesting,
                                isLastItem: true),
                          ],
                        ))
                      ],
                    ))
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  getListTile(String key, String? value, {bool isLastItem = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: AppColors.powderBlue),
          right: const BorderSide(color: AppColors.powderBlue),
          left: const BorderSide(color: AppColors.powderBlue),
          bottom: isLastItem
              ? const BorderSide(color: AppColors.powderBlue)
              : const BorderSide(color: Colors.transparent),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      key,
                      style: const TextStyle(color: AppColors.charcoalGrey),
                    ))),
            const VerticalDivider(
              color: AppColors.powderBlue,
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(value ?? notAvailable,
                        style: const TextStyle(color: AppColors.brownGrey)))),
          ],
        ),
      ),
    );
  }
}
