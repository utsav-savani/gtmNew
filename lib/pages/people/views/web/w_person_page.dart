// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/people/bloc/person_bloc.dart';
import 'package:gtm/pages/people/views/web/w_companies.dart';
import 'package:gtm/pages/people/views/web/w_documents.dart';
import 'package:gtm/pages/people/views/web/w_passport_visa.dart';
import 'package:gtm/pages/people/views/web/w_personal_info.dart';
import 'package:gtm/pages/people/views/web/w_pilot_credentials.dart';
import 'package:gtm/pages/people/views/web/w_profile_type.dart';
import 'package:people_repository/people_repository.dart';

class WPersonPage extends StatefulWidget {
  const WPersonPage({Key? key, this.people, this.isPassenger})
      : super(key: key);
  final People? people;
  final bool? isPassenger;

  @override
  State<WPersonPage> createState() => _WPersonPageState();
}

class _WPersonPageState extends State<WPersonPage>
    with TickerProviderStateMixin {
  List<Widget> pages = [];
  List<String> headings = const [
    personalInfo,
    pilot,
    companies,
    profile_type,
    passportndvisa,
    documents,
  ];
  List<bool> comingSoon = [];
  bool isPassenger = false;
  int _selectedIndex = 0;

  late bool _changePageByTapView;

  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<RelativeRect> rectAnimation;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = const AlwaysScrollableScrollPhysics();
  Person? personDetails;

  @override
  void initState() {
    isPassenger = widget.isPassenger ?? isPassenger;

    if (widget.isPassenger == null) {
      if (widget.people != null &&
          widget.people!.roles != null &&
          (widget.people!.roles!.contains(captain) ||
              widget.people!.roles!.contains(crew))) {
        isPassenger = false;
      } else {
        isPassenger = true;
      }
    }
    if (!isPassenger) {
      comingSoon = [false, false, false, false, false, true];
    } else {
      comingSoon = [false, false, false, false, true];
      headings = [
        personalInfo,
        companies,
        profile_type,
        passportndvisa,
        documents,
      ];
    }
    context.read<PersonBloc>().add(FetchPersonDetailEvent(
        isPassenger: isPassenger, guid: widget.people?.guid));
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
    return BlocBuilder<PersonBloc, PersonState>(
      builder: (context, state) {
        if (state.detailStatus == FetchPersonDetailStatus.initial ||
            state.detailStatus == FetchPersonDetailStatus.loading) {
          return loadingWidget();
        }
        if (state.detailStatus == FetchPersonDetailStatus.success) {
          personDetails = state.personDetails;
          pages.clear();
          pages.add(WPersonalInfoPage(
            person: state,
          ));
          if (!isPassenger) {
            pages.add(WPilotCredentialsPage(
              person: state,
            ));
          }
          pages.add(WCompaniesPage(
            person: state,
          ));
          pages.add(WProfileTypePage(
            people: state,
          ));
          pages.add(WPassportVisaPage(
            person: state,
          ));
          pages.add(WDocumentsPage(people: widget.people));
        }

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
                          closeTab(widget.people?.name ?? '', context);
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
      },
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
