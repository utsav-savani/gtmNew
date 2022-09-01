import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/_mobile/uas_logo_section_widget.dart';
import 'package:gtm/app/bloc/app_bloc.dart';
import 'package:gtm/pages/authentication/auth_info.dart';

class MAppDrawerScreen extends StatefulWidget {
  const MAppDrawerScreen({Key? key}) : super(key: key);

  @override
  State<MAppDrawerScreen> createState() => _MAppDrawerScreenState();
}

class _MAppDrawerScreenState extends State<MAppDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.brownGrey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          height(32),
          SizedBox(
            height: 92,
            child: Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  child: FutureBuilder(
                    future: getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }
                      String userName = snapshot.data.toString();
                      return Row(
                        children: [
                          Avatar(
                            shape: AvatarShape.circle(16),
                            name: userName,
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.white),
                            placeholderColors: [
                              Theme.of(context).primaryColor,
                            ],
                          ),
                          width(8),
                          Text(
                            userName,
                            style: const TextStyle(
                              color: AppColors.charcoalGrey,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 124,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 12,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                height(12),
                _buildListMenuWidget(
                  title: "Trip Manager",
                  iconName: AppImages.tripManagerIcon,
                  shortname: "TRIPMANAGER",
                ),
                _buildListMenuWidget(
                  title: "APIS Submissions",
                  iconName: AppImages.apisSubmissionIcon,
                  shortname: "APISSUBMISSIOn",
                  isComingSoon: true,
                ),
                _buildListMenuWidget(
                  title: "Executive Travel Desk",
                  iconName: AppImages.executiveTravelDeskIcon,
                  shortname: "EXECUTIVETRAVELDESK",
                  isComingSoon: true,
                ),
                _buildListMenuWidget(
                  title: "Passport, Visa & Health",
                  iconName: AppImages.passportVisaAndHealthIcon,
                  shortname: "PASSPORTVISAHEALTH",
                ),
                _buildListMenuWidget(
                  title: "Content Management",
                  iconName: AppImages.contentManagementIcon,
                  shortname: "CONTENTMANAGEMENT",
                  isMenu: false,
                ),
                _buildListMenuWidget(
                  title: "Company Profile",
                  iconName: AppImages.companyProfileIcon,
                  shortname: "COMPANYPROFILE",
                ),
                _buildListMenuWidget(
                  title: "People",
                  iconName: AppImages.peopleIcon,
                  shortname: "PEOPLE",
                ),
                _buildListMenuWidget(
                  title: "Aircraft",
                  iconName: AppImages.aircraftIcon,
                  shortname: "AIRCRAFT",
                ),
                _buildListMenuWidget(
                  title: "Airports",
                  iconName: AppImages.airportsIcon,
                  shortname: "AIRPORTS",
                ),
                _buildListMenuWidget(
                  title: "Countries",
                  iconName: AppImages.countriesIcon,
                  shortname: "COUNTRIES",
                ),
                _buildListMenuWidget(
                  title: "Checklist",
                  iconName: AppImages.checklistIcon,
                  shortname: "CHECKLISTICON",
                ),
                _buildListMenuWidget(
                  title: "Settings",
                  iconName: AppImages.settingsIcon,
                  shortname: "SETTINGS",
                  isMenu: false,
                ),
                _buildListMenuWidget(
                  title: "User Management",
                  iconName: AppImages.peopleIcon,
                  shortname: "USERMANAGEMENT",
                  isComingSoon: true,
                ),
                _buildListMenuWidget(
                  title: "Logs",
                  iconName: AppImages.logsIcon,
                  shortname: "LOGS",
                  isComingSoon: true,
                ),
                _buildLogoutSection(),
                height(24),
                UASLogoSectionWidget(
                  color: AppColors.charcoalGrey.withOpacity(0.3),
                ),
                height(30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListMenuWidget({
    required String title,
    required String iconName,
    required String shortname,
    bool isMenu = true,
    bool isComingSoon = false,
  }) {
    return InkWell(
      onTap: () {
        if (isMenu) _navigateToInnerScreen(shortname);
      },
      child: Container(
        color: isMenu
            ? AppColors.whiteColor
            : AppColors.brownGrey.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.0),
          child: Row(
            children: [
              svgToIcon(
                appImagesName: iconName,
                width: 16,
                height: 22,
                color: AppColors.greyishBrown.withOpacity(0.6),
              ),
              width(12),
              Expanded(
                child: appText(
                  title,
                  textStyle: TextStyle(
                    color: AppColors.greyishBrown.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isComingSoon)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 12,
                    ),
                    child: appText("Soon", color: AppColors.whiteColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutSection() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          AlertDialog alert = AlertDialog(
            title: const Text("Logout from GTM?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthInfo>().logout();
                    context.read<AppBloc>().add(AppLogoutRequested());
                  },
                  child: const Text('Yes, log out')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.0),
          child: appText(
            "Logout",
            color: AppColors.redColor,
          ),
        ),
      ),
    );
  }

  void _navigateToInnerScreen(String shortname) {
    switch (shortname) {
      case "TRIPMANAGER":
        context.push(Routes.dashboard);
        break;
      default:
        //print(shortname);
        break;
    }
  }
}
