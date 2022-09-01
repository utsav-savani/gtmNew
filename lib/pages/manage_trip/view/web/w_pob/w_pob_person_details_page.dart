import 'package:flutter/material.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_details/pob_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_details/pob_details_state.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:trip_manager_repository/src/models/_pob/pob_customer.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class WPOBPersonDetailsPage extends StatefulWidget {
  final int personID;
  final String? type;

  const WPOBPersonDetailsPage({
    Key? key,
    required this.personID,
    required this.type,
  }) : super(key: key);

  @override
  State<WPOBPersonDetailsPage> createState() => _WPOBPersonDetailsPageState();
}

class _WPOBPersonDetailsPageState extends State<WPOBPersonDetailsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void fetchPOBDetails() {
    POBDetailBloc pobDetailBloc = BlocProvider.of(context);
    pobDetailBloc.add(FetchPOBDetails(personID: widget.personID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<POBDetailBloc, POBDetailsState>(
      builder: (context, POBDetailsState state) {
        switch (state.status) {
          case FetchPOBDetailsState.initial:
          case FetchPOBDetailsState.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case FetchPOBDetailsState.success:
            TripPobDetail tripPobDetail = state.pobDetail;
            String name = tripPobDetail.firstMiddleName ?? '' ' ' + (tripPobDetail.surname ?? '');
            String type = '';
            if (tripPobDetail.isCaptain ?? false) {
              type = 'Captain';
            } else if (tripPobDetail.isCrew ?? false) {
              type = ', Crew';
            } else if (tripPobDetail.isPassenger ?? false) {
              type = ', Passenger';
            } else if (tripPobDetail.isVip ?? false) {
              type = ', VIP';
            } else if (tripPobDetail.isOther ?? false) {
              type = ', Other';
            }
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                leading: const Padding(
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      type,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                      )),
                ],
              ),
              body: DefaultTabController(
                length: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        getTab('Personal Info'),
                        getTab('Pilot Credentials'),
                        getTab('Customers'),
                        getTab('Profile Type'),
                        getTab('Passport & Visa'),
                        getTab('Documents'),
                      ],
                      labelColor: AppColors.deepLilac,
                      unselectedLabelColor: AppColors.blueGrey,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          getPersonalProfile(tripPobDetail),
                          getPilotCredentials(tripPobDetail),
                          getCustomers(tripPobDetail),
                          getProfileType(tripPobDetail),
                          getPassportVisa(tripPobDetail),
                          //getDocuments(tripPobDetail),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          case FetchPOBDetailsState.failure:
            return const Scaffold(
              body: Center(
                child: Text('Unable to load'),
              ),
            );
        }
      },
    );
  }

  getTab(String title) {
    return Tab(
      child: Text(title),
    );
  }

  getPersonalProfile(TripPobDetail tripPobScheduleDetail) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'PRIMARY',
                style: TextStyle(color: AppColors.charcoalGrey),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(),
                      ),
                      Text(
                        widget.type ?? '',
                        style: const TextStyle(color: AppColors.deepLilac, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    getListTile(
                        key1: 'Given Names',
                        key2: 'Surname',
                        value1: tripPobScheduleDetail.firstMiddleName ?? '',
                        value2: tripPobScheduleDetail.surname ?? '',
                        isAlternativeTile: true),
                    getListTile(
                        key1: 'Gender',
                        key2: 'Birth Date',
                        value1: tripPobScheduleDetail.gender ?? '',
                        value2: tripPobScheduleDetail.dob ?? '',
                        isAlternativeTile: false),
                    getListTile(
                        key1: 'Country of Birth',
                        key2: 'State/Province of Birth',
                        value1: () {
                          if (tripPobScheduleDetail.personBirthCountry == null) {
                            return 'N/A';
                          }
                          return tripPobScheduleDetail.personBirthCountry!.name ?? '';
                        }(),
                        value2: 'No Data',
                        isAlternativeTile: true),
                    getListTile(key1: 'City of Birth', value1: 'No Data', isAlternativeTile: false),
                  ],
                ))
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'PERMANENT ADDRESS',
                style: TextStyle(color: AppColors.charcoalGrey),
              ),
            ),
            getListTile(key1: 'Apt/House No', key2: 'Street', value1: 'No Data', value2: 'No Data', isAlternativeTile: true),
            getListTile(key1: 'Address', key2: 'City', value1: tripPobScheduleDetail.address ?? 'N/A', value2: 'No Data', isAlternativeTile: false),
            getListTile(key1: 'Residence', value1: 'No Data', isAlternativeTile: true),
            getListTile(key1: 'Zip Code', value1: 'No Data', isAlternativeTile: false),
            const Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'CONTACT',
                style: TextStyle(color: AppColors.charcoalGrey),
              ),
            ),
            getListTile(
                key1: 'Mobile 1',
                value1: () {
                  if (tripPobScheduleDetail.personMobile == null) {
                    return 'N/A';
                  }
                  return tripPobScheduleDetail.personMobile!.mobile ?? '';
                }(),
                isAlternativeTile: true),
            getListTile(key1: 'Email 1', value1: 'No Data', isAlternativeTile: false),
            getListTile(key1: 'Email 2', value1: 'No Data', isAlternativeTile: true),
          ],
        ),
      ),
    );
  }

  getPilotCredentials(TripPobDetail tripPobScheduleDetail) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'PILOT CREDENTIALS',
                style: TextStyle(color: AppColors.charcoalGrey),
              ),
            ),
            getListTile(
                key1: 'License No',
                key2: 'Country of Issue',
                value1: tripPobScheduleDetail.licenseNumber ?? 'N/A',
                value2: () {
                  if (tripPobScheduleDetail.licenseIssuedCountry == null) {
                    return 'N/A';
                  }
                  return tripPobScheduleDetail.licenseIssuedCountry!.name ?? '';
                }(),
                isAlternativeTile: true),
            getListTile(
                key1: 'Issue Date',
                key2: 'Expiry Date',
                value1: tripPobScheduleDetail.issueDate ?? 'N/A',
                value2: tripPobScheduleDetail.expirationDate ?? 'N/A',
                isAlternativeTile: false),
          ],
        ),
      ),
    );
  }

  getCustomers(TripPobDetail tripPobScheduleDetail) {
    List<PobCustomer> customers = tripPobScheduleDetail.contractedBy ?? [];
    if (customers.isEmpty) {
      return const Center(
        child: Text('We din\'t find any customers'),
      );
    }
    return Wrap(
      children: customers.map((e) {
        return Chip(label: Text(e.customerName ?? ''));
      }).toList(),
    );
  }

  getProfileType(TripPobDetail tripPobScheduleDetail) {
    return Center(
      child: Text(widget.type ?? ''),
    );
  }

  getPassportVisa(TripPobDetail tripPobScheduleDetail) {
    List<Passport> passports = tripPobScheduleDetail.personHasPassportDocument ?? [];
    return ListView.builder(
      itemCount: passports.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            () {
              if (passports[index].personPassportIssueCountry == null) {
                return '';
              }
              return passports[index].personPassportIssueCountry!.name ?? '';
            }(),
          ),
          subtitle: Text(passports[index].number??''),
        );
      },
    );
  }

  getDocuments(TripPobDetail tripPobScheduleDetail) {
    return const Center(
      child: Text('No Data'),
    );
  }

  getListTile({String key1 = '', String value1 = '', String key2 = '', String value2 = '', bool isAlternativeTile = false}) {
    return Container(
      color: isAlternativeTile ? AppColors.paleGrey : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
                child: Visibility(
              visible: key1.isNotEmpty,
              child: Text(
                key1 + ':',
                style: const TextStyle(color: AppColors.brownGrey, fontSize: 14),
              ),
            )),
            Expanded(
                child: Visibility(
              visible: value1.isNotEmpty,
              child: Text(
                value1,
                style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 14),
              ),
            )),
            Expanded(
                child: Visibility(
              visible: key2.isNotEmpty,
              child: Text(
                key2 + ':',
                style: const TextStyle(color: AppColors.brownGrey, fontSize: 14),
              ),
            )),
            Expanded(
                child: Visibility(
              visible: value2.isNotEmpty,
              child: Text(
                value2,
                style: const TextStyle(color: AppColors.charcoalGrey, fontSize: 14),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
