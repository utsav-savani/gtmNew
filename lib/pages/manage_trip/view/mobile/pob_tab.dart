// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gtm/_shared/shared.dart';
// import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
// import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_bloc.dart';
// import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_state.dart';
// import 'package:gtm/pages/manage_trip/bloc/pob/pob_persons/pob_persons_bloc.dart';
// import 'package:gtm/pages/manage_trip/bloc/pob/pob_persons/pob_persons_state.dart';
// import 'package:gtm/pages/manage_trip/bloc/pob/save_pob/save_pob_person_bloc.dart';
// import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_bloc.dart';
// import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_event.dart';
// import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_state.dart';
// import 'package:gtm/pages/manage_trip/manage_trip.dart';
// import 'package:gtm/pages/manage_trip/view/web/w_pob/w_pob_page.dart';
// import 'package:gtm/pages/manage_trip/view/web/w_pob/w_pob_select_person.dart';
// import 'package:gtm/pages/widgets/accordion.dart';
// import 'package:gtm/pages/widgets/pob_accordion.dart';
// import 'package:gtm/pages/widgets/service_accordion.dart';
// import 'package:trip_manager_repository/trip_manager_repository.dart';

// class PobTab extends StatefulWidget {
//   final String guid;
//   const PobTab({Key? key, required this.guid}) : super(key: key);

//   @override
//   State<PobTab> createState() => _PobTabState();
// }

// class _PobTabState extends State<PobTab> {
//   late List<TripPobSchedule> pobSchedules;
//   int selectedScheduleIndex = 0;
//   int crewCount = 0;
//   int captainCount = 0;
//   int passengerCount = 0;
//   List<TripPobScheduleDetail> captains = [];
//   List<TripPobScheduleDetail> crews = [];
//   List<TripPobScheduleDetail> passengers = [];
//   ListType listType = ListType.all;
//   @override
//   void initState() {
//     super.initState();
//     fetchTripPobDetails();
//   }

//   fetchTripPobDetails() {
//     POBListBloc pobListBloc = BlocProvider.of<POBListBloc>(context);
//     pobListBloc.add(FetchPOBList(guid: widget.guid));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<POBListBloc, POBListState>(
//       builder: (context, state) {
//         if (state.status == FetchPOBListState.initial ||
//             state.status == FetchPOBListState.loading) {
//           return loadingWidget();
//         }
//         if (state.status == FetchPOBListState.success) {
//           pobSchedules = state.tripPOBListSchedule;
//           captains = [];
//           crews = [];
//           passengers = [];
//           captainCount = 0;
//           crewCount = 0;
//           passengerCount = 0;
//           if (pobSchedules[selectedScheduleIndex].pobLists != null &&
//               pobSchedules[selectedScheduleIndex].pobLists!.isNotEmpty) {
//             final pobList = pobSchedules[selectedScheduleIndex].pobLists;
//             for (int i = 0; i < pobList!.length; i++) {
//               if (pobList[i].type == captain) {
//                 captains.add(pobList[i]);
//                 captainCount++;
//               } else if (pobList[i].type == passenger) {
//                 passengers.add(pobList[i]);
//                 passengerCount++;
//               } else if (pobList[i].type == crew) {
//                 crews.add(pobList[i]);
//                 crewCount++;
//               }
//             }
//           }
//         }
//         return Scaffold(
//           body: Stack(
//             children: [
//               SingleChildScrollView(
//                 child: Column(children: [
//                   ServiceAccordion(
//                     title: 'People On Board',
//                     visualDensity: -3,
//                     isCountry: false,
//                     isArrivale: false,
//                     isDepart: false,
//                     titleColor: AppColors.whiteColor,
//                     listTileColor: AppColors.defaultColor,
//                     iconColor: AppColors.whiteColor,
//                     content: Column(
//                       children: [
//                         Container(
//                           color: AppColors.lightPink,
//                           height: 80,
//                           child: ListView.builder(
//                               itemCount: pobSchedules.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedScheduleIndex = index;
//                                     });
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8, horizontal: 16),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text(
//                                           pobSchedules[index]
//                                                   .destinationpointwithicaoiata ??
//                                               '',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium
//                                               ?.copyWith(
//                                                   color:
//                                                       selectedScheduleIndex ==
//                                                               index
//                                                           ? AppColors
//                                                               .defaultColor
//                                                           : AppColors
//                                                               .blackColor,
//                                                   fontWeight:
//                                                       selectedScheduleIndex ==
//                                                               index
//                                                           ? FontWeight.bold
//                                                           : FontWeight.w100),
//                                         ),
//                                         pobSchedules[index].eTa != null
//                                             ? Row(
//                                                 children: [
//                                                   svgToIcon(
//                                                       appImagesName:
//                                                           'assets/images/flight_arrive_icon.svg'),
//                                                   width(5),
//                                                   Text(pobSchedules[index].eTa!,
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyMedium
//                                                           ?.copyWith(
//                                                               color: AppColors
//                                                                   .defaultColor,
//                                                               fontWeight:
//                                                                   selectedScheduleIndex ==
//                                                                           index
//                                                                       ? FontWeight
//                                                                           .bold
//                                                                       : FontWeight
//                                                                           .w100))
//                                                 ],
//                                               )
//                                             : Container(),
//                                         pobSchedules[index].eTD != null
//                                             ? Row(
//                                                 children: [
//                                                   svgToIcon(
//                                                       appImagesName:
//                                                           'assets/images/flight_depart_icon.svg'),
//                                                   width(5),
//                                                   Text(pobSchedules[index].eTD!,
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyMedium
//                                                           ?.copyWith(
//                                                               color: AppColors
//                                                                   .defaultColor,
//                                                               fontWeight:
//                                                                   selectedScheduleIndex ==
//                                                                           index
//                                                                       ? FontWeight
//                                                                           .bold
//                                                                       : FontWeight
//                                                                           .w100))
//                                                 ],
//                                               )
//                                             : Container()
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 16),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5)),
//                                 border: Border.all(
//                                     color: AppColors.lightBlueGrey, width: 1)),
//                             child: IntrinsicHeight(
//                               child: Row(children: [
//                                 InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       listType = ListType.all;
//                                     });
//                                   },
//                                   child: Container(
//                                     color: listType == ListType.all
//                                         ? AppColors.lightPink
//                                         : AppColors.whiteColor,
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 12, vertical: 12),
//                                       child: Text(
//                                         'All (${captainCount + crewCount + passengerCount})',
//                                         style: TextStyle(
//                                             color: AppColors.defaultColor),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 VerticalDivider(
//                                   width: 1,
//                                   color: AppColors.lightBlueGrey,
//                                   thickness: 1,
//                                 ),
//                                 InkWell(
//                                   onTap: (() {
//                                     setState(() {
//                                       listType = ListType.captain;
//                                     });
//                                   }),
//                                   child: Container(
//                                     color: listType == ListType.captain
//                                         ? AppColors.lightPink
//                                         : AppColors.whiteColor,
//                                     child: Padding(
//                                       padding: EdgeInsets.all(12.0),
//                                       child: Text('Captain ($captainCount)'),
//                                     ),
//                                   ),
//                                 ),
//                                 VerticalDivider(
//                                   width: 1,
//                                   color: AppColors.lightBlueGrey,
//                                   thickness: 1,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       listType = ListType.crew;
//                                     });
//                                   },
//                                   child: Container(
//                                     color: listType == ListType.crew
//                                         ? AppColors.lightPink
//                                         : AppColors.whiteColor,
//                                     child: Padding(
//                                       padding: EdgeInsets.all(12.0),
//                                       child: Text('Crew ($crewCount)'),
//                                     ),
//                                   ),
//                                 ),
//                                 VerticalDivider(
//                                   width: 1,
//                                   color: AppColors.lightBlueGrey,
//                                   thickness: 1,
//                                 ),
//                                 Expanded(
//                                   child: InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         listType = ListType.passenger;
//                                       });
//                                     },
//                                     child: Container(
//                                       color: listType == ListType.passenger
//                                           ? AppColors.lightPink
//                                           : AppColors.whiteColor,
//                                       child: Padding(
//                                         padding: EdgeInsets.all(12.0),
//                                         child: Text(
//                                           'Passenger ($passengerCount)',
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 16),
//                           child: TextFormField(
//                             decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.all(5),
//                                 prefixIcon: Icon(Icons.search),
//                                 hintText: 'Search'),
//                           ),
//                         ),
//                         (listType == ListType.all ||
//                                 listType == ListType.captain)
//                             ? Stack(
//                                 children: [
//                                   ServiceAccordion(
//                                     title: 'Captain ($captainCount)',
//                                     visualDensity: -3,
//                                     isCountry: false,
//                                     isArrivale: false,
//                                     isDepart: false,
//                                     listTileColor: AppColors.defaultColor,
//                                     titleColor: AppColors.whiteColor,
//                                     iconColor: AppColors.whiteColor,
//                                     content: Column(
//                                         children: List.generate(
//                                             captainCount,
//                                             (idx) => Column(
//                                                   children: [
//                                                     IntrinsicHeight(
//                                                         child: Row(
//                                                       children: [
//                                                         Expanded(
//                                                           flex: 16,
//                                                           child: Column(
//                                                             children: [
//                                                               infoRow(
//                                                                   context,
//                                                                   'Name',
//                                                                   (captains[idx]
//                                                                               .firstName ??
//                                                                           '') +
//                                                                       (captains[idx]
//                                                                               .lastName ??
//                                                                           ''),
//                                                                   true),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Passport',
//                                                                   captains[idx]
//                                                                           .passportNumber ??
//                                                                       '',
//                                                                   false),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Nationality',
//                                                                   captains[idx]
//                                                                           .nationality ??
//                                                                       '',
//                                                                   true),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Pref',
//                                                                   captains[idx]
//                                                                           .pref ??
//                                                                       '',
//                                                                   true)
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           flex: 1,
//                                                           child: Stack(
//                                                             children: [
//                                                               Material(
//                                                                   elevation: 8,
//                                                                   child: Container(
//                                                                       color: AppColors
//                                                                           .departBoxColor)),
//                                                               RotatedBox(
//                                                                 quarterTurns: 1,
//                                                                 child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .center,
//                                                                     children: [
//                                                                       Text(
//                                                                         captain +
//                                                                             " " +
//                                                                             '${idx + 1}',
//                                                                         style: Theme.of(context)
//                                                                             .textTheme
//                                                                             .bodySmall
//                                                                             ?.copyWith(
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: AppColors.defaultColor),
//                                                                       )
//                                                                     ]),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         )
//                                                       ],
//                                                     )),
//                                                     Divider(
//                                                       thickness: 1,
//                                                       height: 1,
//                                                       color: AppColors
//                                                           .lightBlueGrey,
//                                                     ),
//                                                   ],
//                                                 ))),
//                                   ),
//                                   Positioned(
//                                     top: 15,
//                                     child: Row(
//                                       children: [
//                                         width(
//                                             MediaQuery.of(context).size.width *
//                                                 0.65),
//                                         svgToIcon(
//                                             appImagesName:
//                                                 'assets/images/user-edit.svg')
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 12,
//                                     child: Row(
//                                       children: [
//                                         width(
//                                             MediaQuery.of(context).size.width *
//                                                 0.75),
//                                         Icon(
//                                           Icons.delete_outline,
//                                           color: AppColors.whiteColor,
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : Container(),
//                         (listType == ListType.all || listType == ListType.crew)
//                             ? Stack(
//                                 children: [
//                                   ServiceAccordion(
//                                     title: 'Crew ($crewCount)',
//                                     visualDensity: -3,
//                                     isCountry: false,
//                                     isArrivale: false,
//                                     isDepart: false,
//                                     listTileColor: AppColors.defaultColor,
//                                     titleColor: AppColors.whiteColor,
//                                     iconColor: AppColors.whiteColor,
//                                     content: Column(
//                                         children: List.generate(
//                                             crewCount,
//                                             (idx) => Column(
//                                                   children: [
//                                                     IntrinsicHeight(
//                                                         child: Row(
//                                                       children: [
//                                                         Expanded(
//                                                           flex: 16,
//                                                           child: Column(
//                                                             children: [
//                                                               infoRow(
//                                                                   context,
//                                                                   'Name',
//                                                                   (crews[idx].firstName ??
//                                                                           '') +
//                                                                       (crews[idx]
//                                                                               .lastName ??
//                                                                           ''),
//                                                                   true),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Passport',
//                                                                   crews[idx]
//                                                                           .passportNumber ??
//                                                                       '',
//                                                                   false),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Nationality',
//                                                                   crews[idx]
//                                                                           .nationality ??
//                                                                       '',
//                                                                   true),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Pref',
//                                                                   crews[idx]
//                                                                           .pref ??
//                                                                       '',
//                                                                   true)
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           flex: 1,
//                                                           child: Stack(
//                                                             children: [
//                                                               Material(
//                                                                   elevation: 8,
//                                                                   child: Container(
//                                                                       color: AppColors
//                                                                           .departBoxColor)),
//                                                               RotatedBox(
//                                                                 quarterTurns: 1,
//                                                                 child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .center,
//                                                                     children: [
//                                                                       Text(
//                                                                         'Crew ${idx + 1}',
//                                                                         style: Theme.of(context)
//                                                                             .textTheme
//                                                                             .bodySmall
//                                                                             ?.copyWith(
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: AppColors.defaultColor),
//                                                                       )
//                                                                     ]),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         )
//                                                       ],
//                                                     )),
//                                                     Divider(
//                                                       thickness: 1,
//                                                       height: 1,
//                                                       color: AppColors
//                                                           .lightBlueGrey,
//                                                     ),
//                                                   ],
//                                                 ))),
//                                   ),
//                                   Positioned(
//                                     top: 15,
//                                     child: Row(
//                                       children: [
//                                         width(
//                                             MediaQuery.of(context).size.width *
//                                                 0.65),
//                                         svgToIcon(
//                                             appImagesName:
//                                                 'assets/images/user-edit.svg')
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 12,
//                                     child: Row(
//                                       children: [
//                                         width(
//                                             MediaQuery.of(context).size.width *
//                                                 0.75),
//                                         Icon(
//                                           Icons.delete_outline,
//                                           color: AppColors.whiteColor,
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : Container(),
//                         (listType == ListType.all ||
//                                 listType == ListType.passenger)
//                             ? Stack(
//                                 children: [
//                                   ServiceAccordion(
//                                     title: 'Passenger ($passengerCount)',
//                                     visualDensity: -3,
//                                     isCountry: false,
//                                     isArrivale: false,
//                                     isDepart: false,
//                                     listTileColor: AppColors.defaultColor,
//                                     titleColor: AppColors.whiteColor,
//                                     iconColor: AppColors.whiteColor,
//                                     content: Column(
//                                         children: List.generate(
//                                             passengerCount,
//                                             (idx) => Column(
//                                                   children: [
//                                                     IntrinsicHeight(
//                                                         child: Row(
//                                                       children: [
//                                                         Expanded(
//                                                           flex: 16,
//                                                           child: Column(
//                                                             children: [
//                                                               infoRow(
//                                                                   context,
//                                                                   'Name',
//                                                                   (passengers[idx]
//                                                                               .firstName ??
//                                                                           '') +
//                                                                       (passengers[idx]
//                                                                               .lastName ??
//                                                                           ''),
//                                                                   true),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Passport',
//                                                                   passengers[idx]
//                                                                           .passportNumber ??
//                                                                       '',
//                                                                   false),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Nationality',
//                                                                   passengers[idx]
//                                                                           .nationality ??
//                                                                       '',
//                                                                   true),
//                                                               infoRow(
//                                                                   context,
//                                                                   'Pref',
//                                                                   passengers[idx]
//                                                                           .pref ??
//                                                                       '',
//                                                                   true)
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           flex: 1,
//                                                           child: Stack(
//                                                             children: [
//                                                               Material(
//                                                                   elevation: 8,
//                                                                   child: Container(
//                                                                       color: AppColors
//                                                                           .departBoxColor)),
//                                                               RotatedBox(
//                                                                 quarterTurns: 1,
//                                                                 child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .center,
//                                                                     children: [
//                                                                       Text(
//                                                                         passenger +
//                                                                             " " +
//                                                                             '${idx + 1}',
//                                                                         style: Theme.of(context)
//                                                                             .textTheme
//                                                                             .bodySmall
//                                                                             ?.copyWith(
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: AppColors.defaultColor),
//                                                                       )
//                                                                     ]),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         )
//                                                       ],
//                                                     )),
//                                                     Divider(
//                                                       thickness: 1,
//                                                       height: 1,
//                                                       color: AppColors
//                                                           .lightBlueGrey,
//                                                     ),
//                                                   ],
//                                                 ))),
//                                   ),
//                                   Positioned(
//                                     top: 15,
//                                     child: Row(
//                                       children: [
//                                         width(
//                                             MediaQuery.of(context).size.width *
//                                                 0.65),
//                                         svgToIcon(
//                                             appImagesName:
//                                                 'assets/images/user-edit.svg')
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 12,
//                                     child: Row(
//                                       children: [
//                                         width(
//                                             MediaQuery.of(context).size.width *
//                                                 0.75),
//                                         Icon(
//                                           Icons.delete_outline,
//                                           color: AppColors.whiteColor,
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : Container(),
//                         height(50)
//                       ],
//                     ),
//                   )
//                 ]),
//               ),
//               Column(
//                 children: [
//                   Expanded(child: Container()),
//                   Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//                     color: AppColors.defaultColor,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         InkWell(
//                           onTap: () => Navigator.pop(context),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.dashboard,
//                                 color: AppColors.whiteColor,
//                               ),
//                               Text('DASHBOARD',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall
//                                       ?.copyWith(
//                                           color: AppColors.whiteColor,
//                                           fontWeight: FontWeight.bold))
//                             ],
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             showAddCrewBottomSheet(pobSchedules);
//                           },
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               svgToIcon(
//                                   appImagesName: 'assets/images/add_crew.svg'),
//                               Text('CREW/PASSENGER',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall
//                                       ?.copyWith(
//                                           color: AppColors.whiteColor,
//                                           fontWeight: FontWeight.bold))
//                             ],
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.download,
//                               color: AppColors.whiteColor,
//                             ),
//                             Text('REPORTS',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall
//                                     ?.copyWith(
//                                         color: AppColors.whiteColor,
//                                         fontWeight: FontWeight.bold))
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Container infoRow(
//       BuildContext context, String header, String value, bool isLight) {
//     return Container(
//       color: isLight ? AppColors.whiteColor : AppColors.paleGrey,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         child: Row(children: [
//           SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: Text(header)),
//           Expanded(
//               child: Text(
//             value,
//             overflow: TextOverflow.visible,
//           ))
//         ]),
//       ),
//     );
//   }

//   showAddCrewBottomSheet(List<TripPobSchedule> pobSchedules) {
//     POBPersonsBloc pobListBloc = BlocProvider.of<POBPersonsBloc>(context);
//     pobListBloc.add(FetchPOBPersons(guid: widget.guid));
//     List<TripPerson> tripPersons = [];
//     List<TripPerson> captains = [];
//     List<TripPerson> crews = [];
//     List<TripPerson> passengers = [];
//     ListType listType = ListType.all;
//     bool loadPobScheduele = false;
//     Map<String, Map<String, String>> sequencePersonPassportMap = {};
//     for (int i = 0; i < pobSchedules.length; i++) {
//       Map<String, String> personPassportMap = {};
//       if (pobSchedules[i].pobLists != null) {
//         for (int j = 0; j < pobSchedules[i].pobLists!.length; j++) {
//           personPassportMap.putIfAbsent(
//               pobSchedules[i].pobLists![j].personId.toString(),
//               () => pobSchedules[i].pobLists![j].passportId.toString());
//         }
//         sequencePersonPassportMap.putIfAbsent(
//             pobSchedules[i].tripScheduleId.toString(), () => personPassportMap);
//       }
//     }

//     Map<String, Set<int>> newPersonSequencesMap = {};
//     return showModalBottomSheet(
//         isScrollControlled: true,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         context: context,
//         builder: (context) {
//           final MediaQueryData mediaQueryData = MediaQuery.of(context);
//           return Padding(
//               padding:
//                   EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
//               child: BlocBuilder<POBListBloc, POBListState>(
//                 builder: (context, state) {
//                   if (state.status == FetchPOBListState.initial ||
//                       state.status == FetchPOBListState.loading) {
//                     return loadingWidget();
//                   }
//                   if (state.status == FetchPOBListState.success) {
//                     if (loadPobScheduele) {
//                       pobSchedules = state.tripPOBListSchedule;
//                       sequencePersonPassportMap = {};
//                       for (int i = 0; i < pobSchedules.length; i++) {
//                         Map<String, String> personPassportMap = {};
//                         if (pobSchedules[i].pobLists != null) {
//                           for (int j = 0;
//                               j < pobSchedules[i].pobLists!.length;
//                               j++) {
//                             personPassportMap.putIfAbsent(
//                                 pobSchedules[i]
//                                     .pobLists![j]
//                                     .personId
//                                     .toString(),
//                                 () => pobSchedules[i]
//                                     .pobLists![j]
//                                     .passportId
//                                     .toString());
//                           }
//                           sequencePersonPassportMap.putIfAbsent(
//                               pobSchedules[i].tripScheduleId.toString(),
//                               () => personPassportMap);
//                         }
//                       }
//                       loadPobScheduele = false;
//                     }
//                   }
//                   return FractionallySizedBox(
//                       heightFactor: 0.95,
//                       child: StatefulBuilder(builder: (context, setMethod) {
//                         return BlocBuilder<POBPersonsBloc, POBPersonsState>(
//                           builder: (context, state) {
//                             if (state.status == FetchPOBPersonsState.initial ||
//                                 state.status == FetchPOBPersonsState.loading) {
//                               return loadingWidget();
//                             } else if (state.status ==
//                                 FetchPOBPersonsState.success) {
//                               tripPersons = state.tripPersons;
//                               captains = [];
//                               crews = [];
//                               passengers = [];
//                               if (tripPersons.isNotEmpty) {
//                                 for (int i = 0; i < tripPersons.length; i++) {
//                                   if (tripPersons[i].roles != null) {
//                                     if (tripPersons[i]
//                                         .roles!
//                                         .contains(captain)) {
//                                       captains.add(tripPersons[i]);
//                                     }
//                                     if (tripPersons[i]
//                                         .roles!
//                                         .contains(passenger)) {
//                                       passengers.add(tripPersons[i]);
//                                     }
//                                     if (tripPersons[i].roles!.contains(crew)) {
//                                       crews.add(tripPersons[i]);
//                                     }
//                                   }
//                                 }
//                               }
//                             }
//                             return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     decoration: const BoxDecoration(
//                                         color: AppColors.defaultColor,
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(20),
//                                             topRight: Radius.circular(20))),
//                                     width: MediaQuery.of(context).size.width,
//                                     height: MediaQuery.of(context).size.height *
//                                         0.07,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 20),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             'Select Crew/Passenger',
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                           ),
//                                           Expanded(child: Container()),
//                                           ElevatedButton(
//                                               onPressed: () {},
//                                               style: ElevatedButton.styleFrom(
//                                                   primary: AppColors.whiteColor
//                                                       .withAlpha(110)),
//                                               child: Row(
//                                                 children: [
//                                                   svgToIcon(
//                                                       appImagesName:
//                                                           'assets/images/close-circle.svg'),
//                                                   Text(
//                                                     'Add a new',
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodySmall
//                                                         ?.copyWith(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: AppColors
//                                                                 .whiteColor),
//                                                   ),
//                                                 ],
//                                               )),
//                                           width(20),
//                                           IconButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               icon: Icon(
//                                                 Icons.clear,
//                                                 color: Colors.white,
//                                               )),
//                                           width(5)
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8, horizontal: 16),
//                                     child: TextFormField(
//                                       decoration: InputDecoration(
//                                           contentPadding: EdgeInsets.all(5),
//                                           hintText: 'Search',
//                                           prefixIcon: Icon(Icons.search)),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8, horizontal: 16),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(5)),
//                                           border: Border.all(
//                                               color: AppColors.lightBlueGrey,
//                                               width: 1)),
//                                       child: IntrinsicHeight(
//                                         child: Row(children: [
//                                           InkWell(
//                                             onTap: () {
//                                               setMethod(() {
//                                                 listType = ListType.all;
//                                               });
//                                             },
//                                             child: Container(
//                                               color: listType == ListType.all
//                                                   ? AppColors.lightPink
//                                                   : AppColors.whiteColor,
//                                               child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 12,
//                                                     vertical: 12),
//                                                 child: Text(
//                                                   'All (${tripPersons.length})',
//                                                   style: TextStyle(
//                                                       color: AppColors
//                                                           .defaultColor),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           VerticalDivider(
//                                             width: 1,
//                                             color: AppColors.lightBlueGrey,
//                                             thickness: 1,
//                                           ),
//                                           InkWell(
//                                             onTap: (() {
//                                               setMethod(() {
//                                                 listType = ListType.captain;
//                                               });
//                                             }),
//                                             child: Container(
//                                               color:
//                                                   listType == ListType.captain
//                                                       ? AppColors.lightPink
//                                                       : AppColors.whiteColor,
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(12.0),
//                                                 child: Text(
//                                                     'Captain (${captains.length})'),
//                                               ),
//                                             ),
//                                           ),
//                                           VerticalDivider(
//                                             width: 1,
//                                             color: AppColors.lightBlueGrey,
//                                             thickness: 1,
//                                           ),
//                                           InkWell(
//                                             onTap: () {
//                                               setMethod(() {
//                                                 listType = ListType.crew;
//                                               });
//                                             },
//                                             child: Container(
//                                               color: listType == ListType.crew
//                                                   ? AppColors.lightPink
//                                                   : AppColors.whiteColor,
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(12.0),
//                                                 child: Text(
//                                                     'Crew (${crews.length})'),
//                                               ),
//                                             ),
//                                           ),
//                                           VerticalDivider(
//                                             width: 1,
//                                             color: AppColors.lightBlueGrey,
//                                             thickness: 1,
//                                           ),
//                                           Expanded(
//                                             child: InkWell(
//                                               onTap: () {
//                                                 setMethod(() {
//                                                   listType = ListType.passenger;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 color: listType ==
//                                                         ListType.passenger
//                                                     ? AppColors.lightPink
//                                                     : AppColors.whiteColor,
//                                                 child: Padding(
//                                                   padding: EdgeInsets.all(12.0),
//                                                   child: Text(
//                                                     'Passenger (${passengers.length})',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ]),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                       child: SingleChildScrollView(
//                                     child: Column(
//                                         children: List.generate(
//                                             personListHepler(
//                                                     tripPersons,
//                                                     captains,
//                                                     crews,
//                                                     passengers,
//                                                     listType)
//                                                 .length, (index) {
//                                       TripPerson person = personListHepler(
//                                           tripPersons,
//                                           captains,
//                                           crews,
//                                           passengers,
//                                           listType)[index];
//                                       int groupValue = 0;
//                                       return PobAccordion(
//                                         title: person.name,
//                                         designation: listType == ListType.all
//                                             ? person.roles != null
//                                                 ? person.roles!.join(', ')
//                                                 : ''
//                                             : toCamleCase(listType.name),
//                                         country: person.nationality,
//                                         profileUrl:
//                                             'https://via.placeholder.com/40/',
//                                         iconColor: AppColors.defaultColor,
//                                         listTileColor:
//                                             AppColors.accordionHeaderColor,
//                                         content: Column(
//                                           children: [
//                                             listType != ListType.all
//                                                 ? ServiceAccordion(
//                                                     title: 'Select Journey',
//                                                     visualDensity: -3,
//                                                     listTileColor:
//                                                         AppColors.lightBlueBack,
//                                                     titleColor:
//                                                         AppColors.defaultColor,
//                                                     iconColor:
//                                                         AppColors.defaultColor,
//                                                     isCountry: false,
//                                                     isArrivale: false,
//                                                     isDepart: false,
//                                                     content: Column(children: [
//                                                       Column(
//                                                         children: List.generate(
//                                                             pobSchedules.length,
//                                                             (idx1) => Row(
//                                                                   children: [
//                                                                     Checkbox(
//                                                                         tristate:
//                                                                             true,
//                                                                         value: sequencePersonPassportMap.containsKey(pobSchedules[idx1].tripScheduleId.toString())
//                                                                             ? sequencePersonPassportMap[pobSchedules[idx1].tripScheduleId.toString()]!.containsKey(person.personId.toString())
//                                                                                 ? null
//                                                                                 : newPersonSequencesMap.containsKey(person.personId.toString())
//                                                                                     ? newPersonSequencesMap[person.personId.toString()]!.contains(pobSchedules[idx1].tripScheduleId)
//                                                                                     : false
//                                                                             : newPersonSequencesMap.containsKey(person.personId.toString())
//                                                                                 ? newPersonSequencesMap[person.personId.toString()]!.contains(pobSchedules[idx1].tripScheduleId)
//                                                                                 : false,
//                                                                         onChanged: (value) {
//                                                                           if (sequencePersonPassportMap[pobSchedules[idx1].tripScheduleId.toString()] != null &&
//                                                                               sequencePersonPassportMap[pobSchedules[idx1].tripScheduleId.toString()]!.containsKey(person.personId.toString())) {
//                                                                           } else if (value!) {
//                                                                             if (newPersonSequencesMap.containsKey(person.personId.toString())) {
//                                                                               Set<int> temp = newPersonSequencesMap[person.personId.toString()]!;
//                                                                               temp.add(pobSchedules[idx1].tripScheduleId);
//                                                                               newPersonSequencesMap.putIfAbsent(person.personId.toString(), () => temp);
//                                                                             } else {
//                                                                               newPersonSequencesMap.putIfAbsent(
//                                                                                   person.personId
//                                                                                       .toString(),
//                                                                                   () => {
//                                                                                         pobSchedules[idx1].tripScheduleId
//                                                                                       });
//                                                                             }
//                                                                           } else if (!value) {
//                                                                             if (newPersonSequencesMap.containsKey(person.personId.toString())) {
//                                                                               Set<int> sequences = newPersonSequencesMap[person.personId.toString()]!;
//                                                                               sequences.remove(pobSchedules[idx1].tripScheduleId);
//                                                                               newPersonSequencesMap.putIfAbsent(person.personId.toString(), () => sequences);
//                                                                             }
//                                                                           }

//                                                                           setMethod(
//                                                                               () {});
//                                                                         }),
//                                                                     Text(
//                                                                         'Seq ${idx1 + 1} - ${pobSchedules[idx1].destinationpointwithicaoiata}')
//                                                                   ],
//                                                                 )),
//                                                       ),
//                                                       Divider(
//                                                         color: AppColors
//                                                             .lightBlueGrey,
//                                                         thickness: 1,
//                                                       ),
//                                                     ]),
//                                                   )
//                                                 : Container(),
//                                             ServiceAccordion(
//                                               title: 'Select Passport',
//                                               visualDensity: -3,
//                                               isCountry: false,
//                                               isArrivale: false,
//                                               isDepart: false,
//                                               listTileColor:
//                                                   AppColors.lightBlueBack,
//                                               titleColor:
//                                                   AppColors.defaultColor,
//                                               iconColor: AppColors.defaultColor,
//                                               content: StatefulBuilder(
//                                                   builder: (context, setRadio) {
//                                                 return Column(
//                                                   children: List.generate(
//                                                       person.passport != null
//                                                           ? person
//                                                               .passport!.length
//                                                           : 0,
//                                                       (idx1) => Column(
//                                                             children: [
//                                                               IntrinsicHeight(
//                                                                   child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     flex: 1,
//                                                                     child:
//                                                                         Stack(
//                                                                       children: [
//                                                                         Material(
//                                                                             elevation:
//                                                                                 8,
//                                                                             child:
//                                                                                 Container(color: AppColors.departBoxColor)),
//                                                                         RotatedBox(
//                                                                           quarterTurns:
//                                                                               -1,
//                                                                           child: Row(
//                                                                               mainAxisAlignment: MainAxisAlignment.center,
//                                                                               children: [
//                                                                                 Text(
//                                                                                   'Pref. ${idx1 + 1}',
//                                                                                   style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.defaultColor),
//                                                                                 )
//                                                                               ]),
//                                                                         )
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     flex: 16,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         Stack(
//                                                                           children: [
//                                                                             infoRow(
//                                                                                 context,
//                                                                                 'Passport',
//                                                                                 person.passport![idx1].number ?? '',
//                                                                                 true),
//                                                                             listType != ListType.all
//                                                                                 ? Row(
//                                                                                     children: [
//                                                                                       Expanded(child: Container()),
//                                                                                       Radio<int>(
//                                                                                           visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//                                                                                           value: idx1,
//                                                                                           groupValue: groupValue,
//                                                                                           onChanged: (value) {
//                                                                                             setRadio(() {
//                                                                                               groupValue = value!;
//                                                                                             });
//                                                                                           }),
//                                                                                     ],
//                                                                                   )
//                                                                                 : Container()
//                                                                           ],
//                                                                         ),
//                                                                         infoRow(
//                                                                             context,
//                                                                             'Expiry Date',
//                                                                             person.passport![idx1].expireDate ??
//                                                                                 '',
//                                                                             false),
//                                                                         infoRow(
//                                                                             context,
//                                                                             'Nationality',
//                                                                             person.passport![idx1].nationality ??
//                                                                                 '',
//                                                                             true),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               )),
//                                                               Divider(
//                                                                 thickness: 1,
//                                                                 height: 1,
//                                                                 color: AppColors
//                                                                     .lightBlueGrey,
//                                                               ),
//                                                             ],
//                                                           )),
//                                                 );
//                                               }),
//                                             ),
//                                             BlocBuilder<SavePOBBloc,
//                                                 SavePOBStatus>(
//                                               builder: (context, state) {
//                                                 if (state ==
//                                                     SavePOBStatus.loading) {
//                                                   return loadingWidget();
//                                                 } else if (state ==
//                                                     SavePOBStatus.success) {
//                                                   fetchTripPobDetails();

//                                                   context
//                                                       .read<SavePOBBloc>()
//                                                       .add(ResetPOBState());
//                                                 }
//                                                 return Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: ElevatedButton(
//                                                       onPressed: () {
//                                                         if (newPersonSequencesMap
//                                                             .containsKey(person
//                                                                 .personId
//                                                                 .toString())) {
//                                                           context
//                                                               .read<
//                                                                   SavePOBBloc>()
//                                                               .add(SavePOBScheduleDetails(
//                                                                   podScheduleDetails: [
//                                                                     SavePOBScheduleDetailsPayload(
//                                                                         person
//                                                                             .personId,
//                                                                         person.passport != null && person.passport!.isNotEmpty
//                                                                             ? person
//                                                                                 .passport![
//                                                                                     groupValue]
//                                                                                 .personPassportDocumentId
//                                                                             : null,
//                                                                         toCamleCase(listType
//                                                                             .name),
//                                                                         newPersonSequencesMap[person.personId.toString()]!
//                                                                             .toList())
//                                                                   ]));
//                                                           newPersonSequencesMap
//                                                               .remove(person
//                                                                   .personId
//                                                                   .toString());
//                                                           loadPobScheduele =
//                                                               true;
//                                                         }
//                                                       },
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .symmetric(
//                                                                 horizontal: 16),
//                                                         child: text('Save'),
//                                                       )),
//                                                 );
//                                               },
//                                             )
//                                           ],
//                                         ),
//                                       );
//                                     })),
//                                   ))
//                                 ]);
//                           },
//                         );
//                       }));
//                 },
//               ));
//         });
//   }

//   personListHepler(List<TripPerson> all, List<TripPerson> captains,
//       List<TripPerson> crews, List<TripPerson> passengers, ListType listType) {
//     switch (listType) {
//       case ListType.all:
//         return all;
//       case ListType.captain:
//         return captains;
//       case ListType.crew:
//         return crews;
//       case ListType.passenger:
//         return passengers;

//       default:
//         return all;
//     }
//   }
// }
