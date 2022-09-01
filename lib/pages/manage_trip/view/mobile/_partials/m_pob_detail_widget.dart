import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/row_stripped_widget.dart';
import 'package:gtm/pages/widgets/trip_accordion.dart';

class POBDetailWidget extends StatefulWidget {
  final int personId;
  const POBDetailWidget({Key? key, required this.personId}) : super(key: key);

  @override
  State<POBDetailWidget> createState() => _POBDetailWidgetState();
}

class _POBDetailWidgetState extends State<POBDetailWidget> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              height(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    appText(
                      "POB Detail",
                      fontWeight: FontWeight.bold,
                      color: AppColors.defaultColor,
                      fontSize: 16,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: appText("Cancel", color: AppColors.redColor),
                      ),
                    )
                  ],
                ),
              ),
              _buildGeneralInfoWidget(),
              height(4),
              _buildPilotCredentialsWidget(),
              height(4),
              _buildProfileTypeWidget(),
              height(4),
              _buildPassportVisaWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralInfoWidget() {
    return TripAccordion(
      visualDensity: -3,
      titleWidget: const Text(
        "General Info",
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
      listTileColor: AppColors.deepLavender,
      titleColor: AppColors.whiteColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.paleGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Primary Data"),
                ),
                _buildPrimaryData(),
                height(12),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Permanent Address"),
                ),
                _buildPermanentAddressData(),
                height(12),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Contact Details"),
                ),
                _buildContactDetailsData(),
                height(12),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildPrimaryData() {
    return Card(
      child: Column(
        children: const [
          RowStrippedWidget(
            title: 'Given Name',
            details: "Safi Ahmed",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Surname',
            details: "Ahmed",
          ),
          RowStrippedWidget(
            title: 'Gender',
            details: "Male",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'DOB',
            details: "May 20 2020",
          ),
          RowStrippedWidget(
            title: 'Country of Birth',
            details: "India",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'State/Province of Birth',
            details: "India",
          ),
          RowStrippedWidget(
            title: 'City of Birth',
            details: "India",
            isLight: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPermanentAddressData() {
    return Card(
      child: Column(
        children: const [
          RowStrippedWidget(
            title: 'Apt/House No.',
            details: "100",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Street',
            details: "N/A",
          ),
          RowStrippedWidget(
            title: 'Address',
            details: "N/A",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Residence',
            details: "Dubai",
          ),
          RowStrippedWidget(
            title: 'City',
            details: "Dubai",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Zip Code',
            details: "123123",
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetailsData() {
    return Card(
      child: Column(
        children: const [
          RowStrippedWidget(
            title: 'Safi Ahmed',
            details: "100000",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Ahmed Safi',
            details: "100",
          ),
        ],
      ),
    );
  }

  Widget _buildPilotCredentialsWidget() {
    return TripAccordion(
      visualDensity: -3,
      titleWidget: const Text(
        "Pilot Credentials",
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
      listTileColor: AppColors.deepLavender,
      titleColor: AppColors.whiteColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.paleGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPilotCredentialsData(),
                height(12),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildPilotCredentialsData() {
    return Card(
      child: Column(
        children: const [
          RowStrippedWidget(
            title: 'Licence No.',
            details: "N/A",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Country of Issue',
            details: "N/A",
          ),
          RowStrippedWidget(
            title: 'Issue Date',
            details: "May 20 2020",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Expiry Date',
            details: "May 20 2020",
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTypeWidget() {
    return TripAccordion(
      visualDensity: -3,
      titleWidget: const Text(
        "Profile Type",
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
      listTileColor: AppColors.deepLavender,
      titleColor: AppColors.whiteColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.paleGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileTypeData(),
                height(12),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildProfileTypeData() {
    return Card(
      child: Column(
        children: const [
          RowStrippedWidget(
            title: 'Captain',
            details: "Yes",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Crew',
            details: "Yes",
          ),
          RowStrippedWidget(
            title: 'Passenger',
            details: "No",
            isLight: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPassportVisaWidget() {
    return TripAccordion(
      visualDensity: -3,
      titleWidget: const Text(
        "Passport & Visa",
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
      listTileColor: AppColors.deepLavender,
      titleColor: AppColors.whiteColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.paleGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Passport 1"),
                ),
                _buildPassportData(),
                height(8),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Passport 2"),
                ),
                _buildPassportData(),
                height(12),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildPassportData() {
    return Card(
      child: Column(
        children: const [
          RowStrippedWidget(
            title: 'Passport Number',
            details: "D2342342",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Nationality',
            details: "Indian",
          ),
          RowStrippedWidget(
            title: 'Issue Date',
            details: "May 20 2020",
            isLight: false,
          ),
          RowStrippedWidget(
            title: 'Expiry Date',
            details: "May 20 2023",
          ),
        ],
      ),
    );
  }
}
