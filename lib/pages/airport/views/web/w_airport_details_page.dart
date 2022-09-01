import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/airport/views/web/w_airport_flight_req.dart';
import 'package:gtm/pages/airport/views/web/w_airport_general_info.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';

class WAiportDetailsPage extends StatefulWidget {
  final Airport airport;

  const WAiportDetailsPage({required this.airport, Key? key}) : super(key: key);

  @override
  State<WAiportDetailsPage> createState() => _WAiportDetailsPageState();
}

class _WAiportDetailsPageState extends State<WAiportDetailsPage>
    with TickerProviderStateMixin {
  List<Widget> pages = [];

  List<String> headings = const [
    generalInfo,
    //contacts,
    flightRequirements,
    //alerts,
    //weather,
    //notams,
    //documents,
  ];

  List<bool> comingSoon = const [
    false,
    false,
    // false,
    // false,
    // false,
    // false,
    // false
  ];
  int _selectedIndex = 0;

  late final Widget _selectedPage = pages[0];
  late final String _selectedHeading = headings[0];
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<RelativeRect> rectAnimation;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = const AlwaysScrollableScrollPhysics();

  @override
  void didChangeDependencies() {
    _selectedIndex = 0;
    for (int i = 0; i < headings.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    _selectTab(0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(0);
      setState(() {});
    });
    pages.clear();
    pages.add(WAirportGeneralInfoPage(airport: widget.airport));
    //pages.add(WAirportContacts(airport: widget.airport));
    pages.add(WAirportFlightRequirements(airport: widget.airport));
    //pages.add(WAirportAlerts(airport: widget.airport));
    //pages.add(WAirportWeather(airport: widget.airport));
    //pages.add(WAirportNotams(airport: widget.airport));
    //pages.add(WAirportDocuments(airport: widget.airport));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                return PageView.builder(
                    onPageChanged: (index) {
                      _selectTab(index);
                      setState(() {});
                    },
                    controller: pageController,
                    itemCount: headings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: pages[index],
                      );
                    });
              },
            ),
          ),
          SizedBox(
            width: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: headings.length,
                          itemBuilder: (context, index) {
                            return rightMenuItem(index);
                          }),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      closeTab(widget.airport.name, context);
                    },
                    child: const Text('Exit'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.redColor)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  rightMenuItem(int index) {
    Widget child = Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 40,
          width: 300,
          decoration: BoxDecoration(
            color: _selectedIndex == index ? AppColors.lightBlueGrey : null,
            border: const Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
          child: Text(headings[index].translate()),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            child: comingSoon[index]
                ? Image.asset((AppImages.comingSoonImage))
                : null,
          ),
        ),
      ],
    );
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectTab(index);
        });
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Container(
        child: child,
      ),
    );
  }
}
