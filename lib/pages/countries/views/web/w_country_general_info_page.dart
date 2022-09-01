import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';
import 'package:gtm/pages/countries/bloc/general_info/country_general_info_bloc.dart';

class WCountryGeneralInfoPage extends StatefulWidget {
  final Country country;

  const WCountryGeneralInfoPage({required this.country, Key? key})
      : super(key: key);

  @override
  State<WCountryGeneralInfoPage> createState() =>
      _WCountryGeneralInfoPageState();
}

class _WCountryGeneralInfoPageState extends State<WCountryGeneralInfoPage> {
  @override
  void didChangeDependencies() {
    //  fetchCountryGeneralInfo();
    super.didChangeDependencies();
  }

  fetchCountryGeneralInfo() {
    CountryGeneralInfoBloc countryGeneralInfoBloc =
        BlocProvider.of<CountryGeneralInfoBloc>(context);
    countryGeneralInfoBloc
        .add(FetchCountryGeneralInfo(widget.country.countryId ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CountryGeneralInfoBloc, CountryGeneralInfoState>(
        listener: (context, state) {},
        child: BlocBuilder<CountryGeneralInfoBloc, CountryGeneralInfoState>(
          // buildWhen: (previous, current) {
          //   return previous.status != current.status;
          // },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(spacing8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: () {
                    // if (state.status == FetchGeneralInfoStatus.loading) {
                    //   return const Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                    //   Country? country = state.country;

                    return Row(
                      children: [
                        Expanded(
                            child: ListView(
                          children: [
                            getListTile(countryName,
                                widget.country.name ?? notAvailable),
                            getListTile(twoIsoCode,
                                widget.country.code ?? notAvailable),
                            getListTile(currencyCode,
                                widget.country.currencyCode ?? notAvailable),
                            getListTile(security,
                                widget.country.security ?? notAvailable),
                            getListTile(emergencyService, ''),
                            getListTile(police,
                                widget.country.emergencyPolice ?? notAvailable),
                            getListTile(fire,
                                widget.country.emergencyFire ?? notAvailable),
                            getListTile(
                                ambulance,
                                widget.country.emergencyAmbulance ??
                                    notAvailable),
                            getListTile(
                                notes, widget.country.notes ?? notAvailable),
                          ],
                        )),
                        Expanded(
                            child: ListView(
                          children: [
                            getListTile(threeIsoCode,
                                widget.country.code3 ?? notAvailable),
                            getListTile(capitalCity,
                                widget.country.capitalCity ?? notAvailable),
                            getListTile(
                                region, widget.country.region ?? notAvailable),
                            getListTile(officalLanguage, notAvailable),
                          ],
                        )),
                      ],
                    );
                  }()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  getListTile(String key, String? value) {
    return Row(
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(spacing8),
                child: Text(
                  key + ':',
                  style: const TextStyle(color: AppColors.charcoalGrey),
                ))),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(spacing8),
                child: Text(value ?? '',
                    style: const TextStyle(color: AppColors.brownGrey)))),
      ],
    );
  }
}
