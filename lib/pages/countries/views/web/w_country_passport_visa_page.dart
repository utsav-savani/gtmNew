import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/countries.dart';
import 'package:gtm/pages/countries/cubit/passport_visa_cubit/country_passport_visa_cubit.dart';

class WCountryPassportVisaPage extends StatefulWidget {
  final Country country;

  const WCountryPassportVisaPage({required this.country, Key? key})
      : super(key: key);

  @override
  State<WCountryPassportVisaPage> createState() =>
      _WCountryPassportVisaPageState();
}

class _WCountryPassportVisaPageState extends State<WCountryPassportVisaPage> {
  List<PassportVisa>? _passportVisaList;

  @override
  void didChangeDependencies() {
    fetchPassportVisa();
    super.didChangeDependencies();
  }

  fetchPassportVisa() {
    context
        .read<CountryPassportVisaCubit>()
        .getCountryPassportVisaInfo(widget.country.countryId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CountryPassportVisaCubit, CountryPassportVisaState>(
        listener: (context, state) {},
        child: BlocBuilder<CountryPassportVisaCubit, CountryPassportVisaState>(
          // buildWhen: (previous, current) {
          //   //return previous.status != current.status;
          // },
          builder: (context, state) {
            if (state.status == FetchPassportVisaStatus.success) {
              _passportVisaList = state.passportVisa;
            }
            if (state.passportVisa!.isEmpty) {
              return getNoData();
            }
            return _passportVisaList != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: () {
                        return ListView.builder(
                          itemBuilder: (context, index) => getItem(
                              _passportVisaList![index],
                              isLastItem:
                                  index == _passportVisaList!.length - 1),
                          itemCount: _passportVisaList!.length,
                        );
                      }()),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  //  return getNoData();

  getNoData() {
    return Center(
      child: Text(notAvailable.translate()),
    );
  }

  getItem(PassportVisa passportVisa, {bool isLastItem = false}) {
    return Padding(
        padding: const EdgeInsets.only(
            top: spacing10, right: spacing10, left: spacing10),
        child: Column(
          children: [
            getHeading(passportVisa.toCountry.name!, passport, visa),
            getListTile(crew, passportVisa.crewPassport, passportVisa.crewVISA),
            getListTile(passenger, passportVisa.passengerPassport,
                passportVisa.passengerVISA,
                isLastItem: isLastItem),
          ],
        ));
  }

  getHeading(
    String key,
    String value,
    String value2,
  ) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.powderBlue),
          right: BorderSide(color: AppColors.powderBlue),
          left: BorderSide(color: AppColors.powderBlue),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(spacing10),
                    child: Text(
                      key,
                      style: const TextStyle(
                          color: AppColors.charcoalGrey,
                          fontWeight: FontWeight.bold),
                    ))),
            const VerticalDivider(
              color: AppColors.powderBlue,
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(spacing10),
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: AppColors.charcoalGrey,
                          fontWeight: FontWeight.bold),
                    ))),
            const VerticalDivider(
              color: AppColors.powderBlue,
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(spacing10),
                    child: Text(
                      value2,
                      style: const TextStyle(
                          color: AppColors.charcoalGrey,
                          fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
      ),
    );
  }

  getListTile(String key, String value, String value2,
      {bool isLastItem = false}) {
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
                    padding: const EdgeInsets.all(spacing10),
                    child: Text(
                      key,
                      style: const TextStyle(
                          color: AppColors.charcoalGrey,
                          fontWeight: FontWeight.bold),
                    ))),
            const VerticalDivider(
              color: AppColors.powderBlue,
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(spacing10),
                    child: Text(value,
                        style: const TextStyle(color: AppColors.brownGrey)))),
            const VerticalDivider(
              color: AppColors.powderBlue,
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(spacing10),
                    child: Text(value2,
                        style: const TextStyle(color: AppColors.brownGrey)))),
          ],
        ),
      ),
    );
  }
}
