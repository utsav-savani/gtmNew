// import 'package:flutter/material.dart';
// import 'package:gtm/_shared/shared.dart';
// import 'package:gtm/pages/people/views/web/w_companies.dart';
// import 'package:gtm/pages/people/views/web/w_documents.dart';
// import 'package:gtm/pages/people/views/web/w_passport_visa.dart';
// import 'package:gtm/pages/people/views/web/w_personal_info.dart';
// import 'package:gtm/pages/people/views/web/w_pilot_credentials.dart';
// import 'package:gtm/pages/people/views/web/w_profile_type.dart';
// import 'package:people_repository/people_repository.dart';

// class WCrewDetailsPage extends StatefulWidget {
//   const WCrewDetailsPage({
//     Key? key,
//     this.people,
//   }) : super(key: key);
//   final People? people;
//   @override
//   State<WCrewDetailsPage> createState() => _WCrewDetailsPageState();
// }

// class _WCrewDetailsPageState extends State<WCrewDetailsPage>
//     with TickerProviderStateMixin {
//   List<String> crewDetailsPageTabHeader = [
//     'Personal Info',
//     'Pilot Credentials',
//     'Companies',
//     'Profile Type',
//     'Passport & Visa',
//     'Documents',
//   ];
//   late TabController _tabController;
//   @override
//   Widget build(BuildContext context) {
//     _tabController =
//         TabController(length: crewDetailsPageTabHeader.length, vsync: this);
//     return Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SizedBox(
//                 child: Text(
//                   'Crew Details',
//                   style: TextStyle(color: AppColors.charcoalGrey),
//                 ),
//               ),
//               Text(
//                 getCompanyName(widget.people!.name ?? 'New'),
//                 style: const TextStyle(color: AppColors.charcoalGrey),
//               ),
//             ],
//           ),
//           centerTitle: false,
//           elevation: 0,
//           backgroundColor: AppColors.paleGrey1,
//           actions: [
//             IconButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 icon: const Icon(
//                   Icons.close,
//                   color: AppColors.charcoalGrey,
//                 )),
//           ],
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                   top: spacing44, bottom: spacing32, left: spacing20),
//               child: TabBar(
//                 controller: _tabController,
//                 labelPadding: const EdgeInsets.all(spacing12),
//                 isScrollable: true,
//                 labelColor: AppColors.deepLilac,
//                 labelStyle:
//                     const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                 unselectedLabelColor: AppColors.powderBlue,
//                 indicatorColor: AppColors.deepLilac,
//                 tabs: crewDetailsPageTabHeader.map((e) => Text(e)).toList(),
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   const WPersonalInfoPage(),
//                   WPilotCredentialsPage(people: widget.people),
//                   WCompaniesPage(
//                     people: widget.people,
//                   ),
//                   WProfileTypePage(
//                     people: widget.people,
//                   ),
//                   WPassportVisaPage(
//                     people: widget.people,
//                   ),
//                   WDocumentsPage(
//                     people: widget.people,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }

//   getCompanyName(String companyName) {
//     try {
//       return companyName.toUpperCase();
//     } catch (e) {
//       return '';
//     }
//   }
// }
