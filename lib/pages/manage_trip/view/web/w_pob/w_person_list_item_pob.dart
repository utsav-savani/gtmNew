import 'package:flutter/material.dart';
import 'package:gtm/_shared/extensions/string_extension.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class PersonListItem extends StatefulWidget {
  TripPerson tripPerson;

  PersonListItem(this.tripPerson, {Key? key}) : super(key: key);

  @override
  State<PersonListItem> createState() => _PersonListItemState();
}

class _PersonListItemState extends State<PersonListItem> {
  final TextEditingController _searchBoxController = TextEditingController();
  bool isPassportExpanded = false;
  bool isAddWindowOpen = false;
  List<bool> selectedPassport = [];
  List<bool> selectedSequence = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.account_circle_rounded),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.tripPerson.name),
                    Text(widget.tripPerson.roles != null
                        ? widget.tripPerson.roles!.join(',')
                        : ''),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: isPassportExpanded ? 1 : 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {
                        setState(() {
                          isPassportExpanded = !isPassportExpanded;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: isAddWindowOpen
                        ? const Icon(Icons.person_add_alt_1)
                        : const Icon(Icons.person_add_alt),
                    onPressed: () {
                      setState(() {
                        isAddWindowOpen = !isAddWindowOpen;
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
        Visibility(
          visible: isPassportExpanded,
          maintainSize: false,
          maintainAnimation: true,
          maintainState: true,
          child: getPassportView(widget.tripPerson),
        ),
        Visibility(
          visible: isAddWindowOpen,
          maintainSize: false,
          maintainAnimation: true,
          maintainState: true,
          child: getAddToSequenceView(widget.tripPerson),
        ),
      ],
    );
  }

  Widget getPassportView(TripPerson tripPerson) {
    if (tripPerson.passport == null) {
      return getNoData();
    }
    if (tripPerson.passport!.isEmpty) {
      return getNoData();
    }
    selectedPassport = List.filled(tripPerson.passport!.length, false);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: const [
                Expanded(child: Text('Passport')),
                Expanded(child: Text('Expiry Date')),
                Expanded(child: Text('Pref.')),
                Expanded(child: Text('Nationality')),
              ],
            ),
          ),
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: tripPerson.passport != null
                    ? tripPerson.passport!.length
                    : 0,
                itemBuilder: (context, index) {
                  Passport passport = tripPerson.passport![index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Checkbox(
                            value: selectedPassport[index],
                            onChanged: (val) {
                              setState((){
                                bool oldState = selectedPassport[index];
                                selectedPassport = List.filled(tripPerson.passport!.length, false);
                                selectedPassport[index] = !oldState;
                              });
                            }),
                        Expanded(child: Text(passport.number ?? '')),
                        Expanded(child: Text(passport.expireDate ?? '')),
                        Expanded(child: Text(passport.preference ?? '')),
                        Expanded(child: Text(passport.nationality ?? '')),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getAddToSequenceView(TripPerson tripPerson) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _searchBoxController,
                onChanged: (value) {
                  //searchCountries(searchText: value);
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text('Search'.translate()),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  getNoData() {
    return Center(
      child: Text('noDataFound'.translate()),
    );
  }
}
