import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_contacts.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_documents.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_financial.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_flight_categories.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_general_info.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_operation_notes.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_preferences.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';

class WCompanyProfileDetailPage extends StatefulWidget {
  const WCompanyProfileDetailPage({Key? key, required this.companyProfile})
      : super(key: key);
  final CompanyProfile companyProfile;

  @override
  State<WCompanyProfileDetailPage> createState() =>
      _WCompanyProfileDetailPageState();
}

class _WCompanyProfileDetailPageState extends State<WCompanyProfileDetailPage>
    with TickerProviderStateMixin {
  List<Widget> pages = [];
  List<String> headings = const [
    generalInfo,
    contacts,
    operationalNotes,
    preferences,
    documents,
    flightCategory,
    financial,
  ];
  List<bool> comingSoon = const [
    false,
    false,
    false,
    false,
    false,
    false,
    true,
  ];

  int _selectedIndex = 0;

  late bool _changePageByTapView;

  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<RelativeRect> rectAnimation;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = const AlwaysScrollableScrollPhysics();

  @override
  void initState() {
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
    pages.add(
        WCompanyProfileGeneralInfoPage(companyProfile: widget.companyProfile));
    pages.add(WCompanyProfileContacts(companyProfile: widget.companyProfile));
    pages.add(
        WCompanyProfileOperationalNotes(companyProfile: widget.companyProfile));
    pages
        .add(WCompanyProfilePreferences(companyProfile: widget.companyProfile));
    pages.add(WCompanyProfileDocuments(companyProfile: widget.companyProfile));
    pages.add(
        WCompanyProfileFlightCategories(companyProfile: widget.companyProfile));
    pages.add(WCompanyProfileFinancial(companyProfile: widget.companyProfile));

    super.initState();
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
                      closeTab(
                          widget.companyProfile.customerName ??
                              "Company Profile",
                          context);
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
        _changePageByTapView = true;
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
