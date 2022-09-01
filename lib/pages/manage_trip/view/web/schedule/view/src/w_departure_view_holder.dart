import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:sizer/sizer.dart';

class DepartureViewHolder extends StatefulWidget {
  const DepartureViewHolder({
    Key? key,
    // required this.tripSchedulePrePayload,
    //required this.animation,
    this.onTap,
    // required this.item,
    //required this.index,
    // required this.selected,
  }) : super(key: key);
  //final TripSchedulePrePayload tripSchedulePrePayload;
//  final Animation<double> animation;
  final VoidCallback? onTap;
  // final ListModel<Schedule> item;
  // final int index;
  //final bool selected;
  @override
  State<DepartureViewHolder> createState() => _DepartureViewHolderState();
}

class _DepartureViewHolderState extends State<DepartureViewHolder> {
  bool tba = false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(spacing20),

        /// main container 0
        child: Container(

            /// 178 to 180 height
            height: spacing184,
            width: 100.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.powderBlue),
              borderRadius: BorderRadius.circular(spacing8),
            ),

            /// main row 1
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// row 1
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        /// height 132
                        height: spacing132,
                        child: Row(children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(spacing6),
                                  child: SizedBox(
                                    width: spacing24,
                                    height: spacing36,
                                    child: Text(
                                      'Seq \n 00',
                                      style: TextStyle(
                                          color: AppColors.powderBlue),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(spacing4),
                                  child: VerticalDivider(
                                    color: AppColors.powderBlue,
                                    width: spacing6,
                                  ),
                                ),
                                // Image.asset(
                                //   departureImage,
                                //   width: spacing36,
                                //   height: spacing36,
                                // ),
                                const Padding(
                                  padding: EdgeInsets.all(spacing4),
                                  child: VerticalDivider(
                                    color: AppColors.powderBlue,
                                    width: spacing6,
                                  ),
                                ),
                                Padding(
                                  padding: paddingMedium,
                                  child: SizedBox(
                                    height: spacing56,
                                    width: spacing288,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(spacing16),
                                          borderSide: const BorderSide(
                                            color: AppColors.powderBlue,
                                          ),
                                        ),
                                        labelText: tripId,
                                      ),
                                      enabled: false,
                                      //controller: TextEditingController()..text = widget.tripDetail.,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('TBA'),
                                    Padding(
                                      padding: const EdgeInsets.all(spacing4),
                                      child: Checkbox(
                                          value: false,
                                          onChanged: (onChanged) {
                                            setState(() {
                                              tba = !tba;
                                            });
                                          }),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: paddingMedium,
                                  child: SizedBox(
                                    height: spacing56,
                                    width: spacing220,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(spacing16),
                                          borderSide: const BorderSide(
                                            color: AppColors.powderBlue,
                                          ),
                                        ),
                                        labelText: 'ETD',
                                      ),
                                      enabled: false,
                                      //controller: TextEditingController()..text = widget.tripDetail.,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: paddingMedium,
                                  child: SizedBox(
                                    height: spacing56,
                                    width: spacing92,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(spacing16),
                                          borderSide: const BorderSide(
                                            color: AppColors.powderBlue,
                                          ),
                                        ),
                                        labelText: 'ETE',
                                      ),
                                      enabled: false,
                                      //controller: TextEditingController()..text = widget.tripDetail.,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: spacing288,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(worldWebImage),
                                  fit: BoxFit.cover,
                                )),
                              ),
                              Container(
                                width: spacing32,
                                color: AppColors.blueGrey,
                                child: const RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(child: Text('ATC RTE')),
                                ),
                              ),
                              Container(
                                width: spacing32,
                                color: AppColors.draft,
                                child: const RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(child: Text('DRAFT')),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                    Container(
                      color: AppColors.powderBlue,
                      width: 1,
                      height: spacing132,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: spacing64,
                          height: spacing128,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: /* widget.item[widget.index].entryOut.isEmpty ? null : */ widget
                                    .onTap,
                                child: const Icon(
                                  Icons.add_rounded,
                                  size: spacing32,
                                  color: AppColors.powderBlue,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.delete_forever_rounded,
                                  size: spacing32,
                                  color: AppColors.redColor,
                                ),
                              ),
                              InkWell(
                                onTap: widget.onTap,
                                child: const Icon(
                                  Icons.add_rounded,
                                  size: spacing32,
                                  color: AppColors.powderBlue,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  color: AppColors.powderBlue,
                  height: 1,
                  width: 100.w,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        /// height 48
                        height: spacing32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(spacing4),
                                  child: Text(category),
                                ),
                                SizedBox(
                                  width: spacing180,

                                  /// height 36
                                  height: spacing32,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(
                                        spacing20,
                                        spacing20,
                                        spacing20,
                                        0,
                                      ),
                                    ),
                                    hint:
                                        const Text(selectaircraftRegistration),
                                    items:
                                        ['strtr', 'fsfsf'].map((String string) {
                                      return DropdownMenuItem<String>(
                                        value: string,
                                        child: Text(string),
                                      );
                                    }).toList(),
                                    onChanged: (string) {
                                      // selectedAircraft = aircraft;
                                      // debugPrint(selectedAircraft!.aircraftId.toString() + ' aircraftId');
                                      // context.read<HomeBloc>().add(GetOperatorEvent(aircraft!.aircraftId.toString()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(spacing4),
                                  child: Text(purpos),
                                ),
                                SizedBox(
                                  width: spacing180,

                                  /// height 36
                                  height: spacing32,
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(
                                        spacing20,
                                        spacing20,
                                        spacing20,
                                        0,
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint:
                                        const Text(selectaircraftRegistration),
                                    items:
                                        ['strtr', 'fsfsf'].map((String string) {
                                      return DropdownMenuItem<String>(
                                        value: string,
                                        child: Text(string),
                                      );
                                    }).toList(),
                                    onChanged: (string) {
                                      // selectedAircraft = aircraft;
                                      // debugPrint(selectedAircraft!.aircraftId.toString() + ' aircraftId');
                                      // context.read<HomeBloc>().add(GetOperatorEvent(aircraft!.aircraftId.toString()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(spacing4),
                                  child: Text(callSign),
                                ),
                                SizedBox(
                                  width: spacing180,
                                  height: spacing26,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(
                                        spacing20,
                                        spacing20,
                                        spacing20,
                                        0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: AppColors.powderBlue,
                      width: 1,
                      height: spacing48,
                    ),
                    SizedBox(
                      width: spacing64,
                      height: spacing48,
                      child: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.expand_more_rounded,
                            color: AppColors.powderBlue,
                          )),
                    )
                  ],
                )

                /// column 2
              ],
            )),
      ),
      Positioned(
        bottom: spacing6,
        left: spacing6,
        child: InkWell(
            onTap: () {
              debugPrint('clicked on overflight');
            },
            child: Image.asset("overflightImage")),
      ),
    ]);
  }
}




//  const Divider(color: AppColors.powderBlue),
