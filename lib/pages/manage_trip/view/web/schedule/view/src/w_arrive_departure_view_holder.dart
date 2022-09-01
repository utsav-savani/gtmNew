// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:gtm/_shared/shared.dart';
// import 'package:gtm/_shared/utils/app_images.dart';
// import 'package:gtm/pages/manage_trip/view/web/schedule/models/schedule.dart';
// import 'package:sizer/sizer.dart';

// class ArrivalDepartureViewHolder extends StatefulWidget {
//   const ArrivalDepartureViewHolder({
//     Key? key,
//     this.onTap,
//     required this.item,
//   }) : super(key: key);
//   final VoidCallback? onTap;
//   final Schedule item;

//   @override
//   State<ArrivalDepartureViewHolder> createState() =>
//       _ArrivalDepartureViewHolderState();
// }

// class _ArrivalDepartureViewHolderState
//     extends State<ArrivalDepartureViewHolder> {
//   bool tba = false;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Padding(
//         padding: const EdgeInsets.all(spacing20),

//         /// main container 0
//         child: Container(

//             /// 300 height
//             height: spacing300,
//             width: 100.w,
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.powderBlue),
//               borderRadius: BorderRadius.circular(spacing8),
//             ),

//             /// main row 1
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 /// row 1
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           child: Row(children: [
//                             /// sequence no
//                             const Padding(
//                               padding: EdgeInsets.all(spacing6),
//                               child: SizedBox(
//                                 width: spacing24,
//                                 height: spacing36,
//                                 child: Text(
//                                   'Seq \n 00',
//                                   style: TextStyle(color: AppColors.powderBlue),
//                                 ),
//                               ),
//                             ),

//                             /// arrival and departure image
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.all(spacing4),
//                                       child: VerticalDivider(
//                                         color: AppColors.powderBlue,
//                                         width: spacing6,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       // child: Image.asset(arrivalImage),
//                                       width: spacing48,
//                                       height: spacing36,
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.all(spacing4),
//                                       child: VerticalDivider(
//                                         color: AppColors.powderBlue,
//                                         width: spacing6,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(spacing4),
//                                       child: Container(
//                                         width: spacing4,
//                                         height: spacing4,
//                                         color: AppColors.powderBlue,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       // child: Image.asset(departureImage),
//                                       width: spacing48,
//                                       height: spacing36,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(spacing4),
//                                       child: Container(
//                                         width: 1,
//                                         color: AppColors.powderBlue,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),

//                             ///ETD with top and bottom flight image
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Container(
//                                   width: spacing164,
//                                   height: spacing96,
//                                   decoration: const BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(topFlightImage),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: spacing48,
//                                   width: spacing288,
//                                   child: TextFormField(
//                                     decoration: InputDecoration(
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(spacing16),
//                                         borderSide: const BorderSide(
//                                           color: AppColors.powderBlue,
//                                         ),
//                                       ),
//                                       labelText: 'ETD',
//                                     ),
//                                     enabled: false,
//                                     //controller: TextEditingController()..text = widget.tripDetail.,
//                                   ),
//                                 ),
//                                 Container(
//                                   width: spacing164,
//                                   height: spacing96,
//                                   child: svgToIcon(
//                                       appImagesName: AppImages.addIcon),
//                                 ),
//                               ],
//                             ),
//                             ////
//                             //// TBA top and bottom
//                             Padding(
//                               padding: paddingSmall,
//                               child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         const Tooltip(
//                                           message: toBeAnnouncedBreif,
//                                           child: Text(toBeAnnounced),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.all(spacing4),
//                                           child: Checkbox(
//                                               value: false,
//                                               onChanged: (onChanged) {
//                                                 setState(() {
//                                                   tba = !tba;
//                                                 });
//                                               }),
//                                         )
//                                       ],
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         const Tooltip(
//                                           message: toBeAnnouncedBreif,
//                                           child: Text(toBeAnnounced),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.all(spacing4),
//                                           child: Checkbox(
//                                               value: false,
//                                               onChanged: (onChanged) {
//                                                 setState(() {
//                                                   tba = !tba;
//                                                 });
//                                               }),
//                                         )
//                                       ],
//                                     ),
//                                   ]),
//                             ),

//                             //// ETD and ETE with SPLIT and without SPLIT
//                             Container(
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     alignment: Alignment.centerRight,
//                                     image: AssetImage(
//                                       worldWebImage,
//                                     ),
//                                     fit: BoxFit.contain),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Padding(
//                                         padding: paddingMedium,
//                                         child: SizedBox(
//                                           height: spacing56,
//                                           width: spacing220,
//                                           child: TextFormField(
//                                             decoration: InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         spacing16),
//                                                 borderSide: const BorderSide(
//                                                   color: AppColors.powderBlue,
//                                                 ),
//                                               ),
//                                               labelText: 'ETD',
//                                             ),
//                                             enabled: false,
//                                             controller: TextEditingController()
//                                               ..text = location,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: paddingMedium,
//                                         child: SizedBox(
//                                           height: spacing56,
//                                           width: spacing92,
//                                           child: TextFormField(
//                                             decoration: InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         spacing16),
//                                                 borderSide: const BorderSide(
//                                                   color: AppColors.powderBlue,
//                                                 ),
//                                               ),
//                                               labelText: 'ETE',
//                                             ),
//                                             enabled: false,
//                                             //controller: TextEditingController()..text = widget.tripDetail.,
//                                           ),
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           const Text(split),
//                                           Padding(
//                                             padding: const EdgeInsets.all(
//                                                 spacing4),
//                                             child: Checkbox(
//                                                 value: false,
//                                                 onChanged: (onChanged) {
//                                                   setState(() {
//                                                     tba = !tba;
//                                                   });
//                                                 }),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   ConstrainedBox(
//                                     constraints: BoxConstraints(
//                                       maxWidth: 58.w, minWidth: 30.w,
//                                       // minWidth = 0.0,
//                                       // maxWidth = double.infinity,
//                                       // minHeight = 0.0,
//                                       // maxHeight = double.infinity,
//                                     ),
//                                     child: const DottedLine(
//                                       direction: Axis.horizontal,
//                                       lineThickness: 1.0,
//                                       dashLength: 4.0,
//                                       dashColor: AppColors.powderBlue,
//                                       dashGapLength: 4.0,
//                                       dashGapColor: Colors.transparent,
//                                       dashGapRadius: 0.0,
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Padding(
//                                         padding: paddingMedium,
//                                         child: SizedBox(
//                                           height: spacing56,
//                                           width: spacing220,
//                                           child: TextFormField(
//                                             decoration: InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         spacing16),
//                                                 borderSide: const BorderSide(
//                                                   color: AppColors.powderBlue,
//                                                 ),
//                                               ),
//                                               labelText: 'ETD',
//                                             ),
//                                             enabled: false,
//                                             //controller: TextEditingController()..text = widget.tripDetail.,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: paddingMedium,
//                                         child: SizedBox(
//                                           height: spacing56,
//                                           width: spacing92,
//                                           child: TextFormField(
//                                             decoration: InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         spacing16),
//                                                 borderSide: const BorderSide(
//                                                   color: AppColors.powderBlue,
//                                                 ),
//                                               ),
//                                               labelText: 'ETE',
//                                             ),
//                                             enabled: false,
//                                             //controller: TextEditingController()..text = widget.tripDetail.,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                             // Expanded(
//                             //   child: Container(
//                             //     height: spacing248,
//                             //     decoration: const BoxDecoration(
//                             //       image: DecorationImage(
//                             //           image: AssetImage(
//                             //             worldWebImage,
//                             //           ),
//                             //           fit: BoxFit.cover),
//                             //     ),
//                             //     child: Column(children: [
//                             //       Container(
//                             //         width: spacing32,
//                             //         height: 100,
//                             //         color: AppColors.blueGrey,
//                             //         child: RotatedBox(
//                             //           quarterTurns: -1,
//                             //           child: Center(
//                             //             child: ExpansionPanelList(
//                             //               expansionCallback: (int index, bool isExpanded) {},
//                             //               children: [
//                             //                 ExpansionPanel(
//                             //                   headerBuilder: (BuildContext context, bool isExpanded) {
//                             //                     return const ListTile(
//                             //                       title: Text('Item 1'),
//                             //                     );
//                             //                   },
//                             //                   body: const ListTile(
//                             //                     title: Text('Item 1 child'),
//                             //                     subtitle: Text('Details goes here'),
//                             //                   ),
//                             //                   isExpanded: true,
//                             //                 ),
//                             //               ],
//                             //             ),
//                             //           ),
//                             //         ),
//                             //       ),
//                             //     ]),
//                             //   ),
//                             // ),
//                             // Column(
//                             //   children: [
//                             //     //// ETD and ETE with [TBA ATC RTE] and
//                             //     Expanded(
//                             //       child: Row(
//                             //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             //         mainAxisSize: MainAxisSize.max,
//                             //         children: [
//                             //           /// only with etd and ete
//                             //           Row(
//                             //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             //             mainAxisSize: MainAxisSize.max,
//                             //             children: [
//                             //               Container(
//                             //                 width: spacing288,
//                             //                 decoration: const BoxDecoration(
//                             //                     image: DecorationImage(
//                             //                   image: AssetImage(worldWebImage),
//                             //                   fit: BoxFit.cover,
//                             //                 )),
//                             //               ),
//                             //               Container(
//                             //                 width: spacing32,
//                             //                 color: AppColors.blueGrey,
//                             //                 child: const RotatedBox(
//                             //                   quarterTurns: -1,
//                             //                   child: Center(child: Text('ATC RTE')),
//                             //                 ),
//                             //               ),
//                             //               Container(
//                             //                 width: spacing32,
//                             //                 color: AppColors.draft,
//                             //                 child: const RotatedBox(
//                             //                   quarterTurns: -1,
//                             //                   child: Center(child: Text('DRAFT')),
//                             //                 ),
//                             //               ),
//                             //             ],
//                             //           )
//                             //         ],
//                             //       ),
//                             //     ),
//                             //     ////  ETD and ETE with ONLY [ATC RTE] and
//                             //     Row(
//                             //       children: [
//                             //         Row(
//                             //           children: [
//                             //             Container(
//                             //               width: spacing288,
//                             //               decoration: const BoxDecoration(
//                             //                   image: DecorationImage(
//                             //                 image: AssetImage(worldWebImage),
//                             //                 fit: BoxFit.cover,
//                             //               )),
//                             //             ),
//                             //             Container(
//                             //               width: spacing32,
//                             //               color: AppColors.blueGrey,
//                             //               child: const RotatedBox(
//                             //                 quarterTurns: -1,
//                             //                 child: Center(child: Text('ATC RTE')),
//                             //               ),
//                             //             ),
//                             //             Container(
//                             //               width: spacing32,
//                             //               color: AppColors.draft,
//                             //               child: const RotatedBox(
//                             //                 quarterTurns: -1,
//                             //                 child: Center(child: Text('DRAFT')),
//                             //               ),
//                             //             ),
//                             //           ],
//                             //         )
//                             //       ],
//                             //     )
//                             //   ],
//                             // ),
//                           ]),
//                         ),
//                       ),

//                       /// side container for deletion
//                       Container(
//                         color: AppColors.powderBlue,
//                         width: 1,
//                         height: spacing300,
//                       ),
//                       SizedBox(
//                         width: spacing64,
//                         height: spacing300,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             InkWell(
//                               onTap: () {},
//                               child: const Icon(
//                                 Icons.add_rounded,
//                                 size: spacing32,
//                                 color: AppColors.powderBlue,
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {},
//                               child: const Icon(
//                                 Icons.delete_forever_rounded,
//                                 size: spacing32,
//                                 color: AppColors.redColor,
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {},
//                               child: const Icon(
//                                 Icons.add_rounded,
//                                 size: spacing32,
//                                 color: AppColors.powderBlue,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   color: AppColors.powderBlue,
//                   height: 1,
//                   width: 100.w,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         /// height 48
//                         height: spacing32,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.all(spacing4),
//                                   child: Text(category),
//                                 ),
//                                 SizedBox(
//                                   width: spacing180,

//                                   /// height 36
//                                   height: spacing32,
//                                   child: DropdownButtonFormField<String>(
//                                     isExpanded: true,
//                                     decoration: const InputDecoration(
//                                       isDense: true,
//                                       contentPadding: EdgeInsets.fromLTRB(
//                                         spacing20,
//                                         spacing20,
//                                         spacing20,
//                                         0,
//                                       ),
//                                     ),
//                                     hint:
//                                         const Text(selectaircraftRegistration),
//                                     items:
//                                         ['strtr', 'fsfsf'].map((String string) {
//                                       return DropdownMenuItem<String>(
//                                         value: string,
//                                         child: Text(string),
//                                       );
//                                     }).toList(),
//                                     onChanged: (string) {
//                                       // selectedAircraft = aircraft;
//                                       // debugPrint(selectedAircraft!.aircraftId.toString() + ' aircraftId');
//                                       // context.read<HomeBloc>().add(GetOperatorEvent(aircraft!.aircraftId.toString()));
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.all(spacing4),
//                                   child: Text(purpos),
//                                 ),
//                                 SizedBox(
//                                   width: spacing180,

//                                   /// height 36
//                                   height: spacing32,
//                                   child: DropdownButtonFormField<String>(
//                                     decoration: const InputDecoration(
//                                       isDense: true,
//                                       contentPadding: EdgeInsets.fromLTRB(
//                                         spacing20,
//                                         spacing20,
//                                         spacing20,
//                                         0,
//                                       ),
//                                     ),
//                                     isExpanded: true,
//                                     hint:
//                                         const Text(selectaircraftRegistration),
//                                     items:
//                                         ['strtr', 'fsfsf'].map((String string) {
//                                       return DropdownMenuItem<String>(
//                                         value: string,
//                                         child: Text(string),
//                                       );
//                                     }).toList(),
//                                     onChanged: (string) {
//                                       // selectedAircraft = aircraft;
//                                       // debugPrint(selectedAircraft!.aircraftId.toString() + ' aircraftId');
//                                       // context.read<HomeBloc>().add(GetOperatorEvent(aircraft!.aircraftId.toString()));
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.all(spacing4),
//                                   child: Text(callSign),
//                                 ),
//                                 SizedBox(
//                                   width: spacing180,
//                                   height: spacing26,
//                                   child: TextFormField(
//                                     decoration: const InputDecoration(
//                                       isDense: true,
//                                       contentPadding: EdgeInsets.fromLTRB(
//                                         spacing20,
//                                         spacing20,
//                                         spacing20,
//                                         0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       color: AppColors.powderBlue,
//                       width: 1,
//                       height: spacing48,
//                     ),
//                     SizedBox(
//                       width: spacing64,
//                       height: spacing48,
//                       child: InkWell(
//                           onTap: () {},
//                           child: const Icon(
//                             Icons.expand_more_rounded,
//                             color: AppColors.powderBlue,
//                           )),
//                     )
//                   ],
//                 )

//                 /// column 2
//               ],
//             )),
//       ),
//       Positioned(
//         bottom: spacing6,
//         left: spacing6,
//         child: InkWell(
//             onTap: () {
//               debugPrint('clicked on overflight');
//             },
//             child: Image.asset("overflightImage")),
//       ),
//     ]);
//   }
// }

// //                                 SizedBox(
// //                                   height: 100,
// //                                   child: Column(
// //                                     children: [
// //                                       Row(
// //                                         children: [
// //                                           Padding(
// //                                             padding: paddingMedium,
// //                                             child: SizedBox(
// //                                               height: spacing56,
// //                                               width: spacing220,
// //                                               child: TextFormField(
// //                                                 decoration: InputDecoration(
// //                                                   enabledBorder: OutlineInputBorder(
// //                                                     borderRadius: BorderRadius.circular(spacing16),
// //                                                     borderSide: const BorderSide(
// //                                                       color: AppColors.powderBlue,
// //                                                     ),
// //                                                   ),
// //                                                   labelText: 'ETD',
// //                                                 ),
// //                                                 enabled: false,
// //                                                 //controller: TextEditingController()..text = widget.tripDetail.,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           Padding(
// //                                             padding: paddingMedium,
// //                                             child: SizedBox(
// //                                               height: spacing56,
// //                                               width: spacing92,
// //                                               child: TextFormField(
// //                                                 decoration: InputDecoration(
// //                                                   enabledBorder: OutlineInputBorder(
// //                                                     borderRadius: BorderRadius.circular(spacing16),
// //                                                     borderSide: const BorderSide(
// //                                                       color: AppColors.powderBlue,
// //                                                     ),
// //                                                   ),
// //                                                   labelText: 'ETE',
// //                                                 ),
// //                                                 enabled: false,
// //                                                 //controller: TextEditingController()..text = widget.tripDetail.,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           Row(
// //                                             mainAxisSize: MainAxisSize.max,
// //                                             crossAxisAlignment: CrossAxisAlignment.stretch,
// //                                             children: [
// //                                               Container(
// //                                                 width: spacing288,
// //                                                 decoration: const BoxDecoration(
// //                                                     image: DecorationImage(
// //                                                   image: AssetImage(worldWebImage),
// //                                                   fit: BoxFit.cover,
// //                                                 )),
// //                                               ),
// //                                               Container(
// //                                                 width: spacing32,
// //                                                 color: AppColors.blueGrey,
// //                                                 child: const RotatedBox(
// //                                                   quarterTurns: -1,
// //                                                   child: Center(child: Text('ATC RTE')),
// //                                                 ),
// //                                               ),
// //                                               Container(
// //                                                 width: spacing32,
// //                                                 color: AppColors.draft,
// //                                                 child: const RotatedBox(
// //                                                   quarterTurns: -1,
// //                                                   child: Center(child: Text('DRAFT')),
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           )
// //                                         ],
// //                                       ),
// //                                       Row(
// //                                         children: [
// //                                           Padding(
// //                                             padding: paddingMedium,
// //                                             child: SizedBox(
// //                                               height: spacing56,
// //                                               width: spacing220,
// //                                               child: TextFormField(
// //                                                 decoration: InputDecoration(
// //                                                   enabledBorder: OutlineInputBorder(
// //                                                     borderRadius: BorderRadius.circular(spacing16),
// //                                                     borderSide: const BorderSide(
// //                                                       color: AppColors.powderBlue,
// //                                                     ),
// //                                                   ),
// //                                                   labelText: 'ETD',
// //                                                 ),
// //                                                 enabled: false,
// //                                                 //controller: TextEditingController()..text = widget.tripDetail.,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           Padding(
// //                                             padding: paddingMedium,
// //                                             child: SizedBox(
// //                                               height: spacing56,
// //                                               width: spacing92,
// //                                               child: TextFormField(
// //                                                 decoration: InputDecoration(
// //                                                   enabledBorder: OutlineInputBorder(
// //                                                     borderRadius: BorderRadius.circular(spacing16),
// //                                                     borderSide: const BorderSide(
// //                                                       color: AppColors.powderBlue,
// //                                                     ),
// //                                                   ),
// //                                                   labelText: 'ETE',
// //                                                 ),
// //                                                 enabled: false,
// //                                                 //controller: TextEditingController()..text = widget.tripDetail.,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           Row(
// //                                             mainAxisSize: MainAxisSize.max,
// //                                             crossAxisAlignment: CrossAxisAlignment.stretch,
// //                                             children: [
// //                                               Container(
// //                                                 width: spacing288,
// //                                                 decoration: const BoxDecoration(
// //                                                     image: DecorationImage(
// //                                                   image: AssetImage(worldWebImage),
// //                                                   fit: BoxFit.cover,
// //                                                 )),
// //                                               ),
// //                                               Container(
// //                                                 width: spacing32,
// //                                                 color: AppColors.blueGrey,
// //                                                 child: const RotatedBox(
// //                                                   quarterTurns: -1,
// //                                                   child: Center(child: Text('ATC RTE')),
// //                                                 ),
// //                                               ),
// //                                               Container(
// //                                                 width: spacing32,
// //                                                 color: AppColors.draft,
// //                                                 child: const RotatedBox(
// //                                                   quarterTurns: -1,
// //                                                   child: Center(child: Text('DRAFT')),
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           )
// //                                         ],
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ),
