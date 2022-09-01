import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/messages_icon_widget.dart';
import 'package:gtm/app/bloc/app_bloc.dart';
import 'package:gtm/pages/authentication/auth_info.dart';
import 'package:user_repository/src/model/logged_user.dart';
import 'package:user_repository/user_repository.dart';

Widget webAppBar(BuildContext context) {
  final bool _isWeb = MediaQuery.of(context).size.width >= web;
  late var newNotifications = true;
  late var newMessages = true;
  return Container(
    height: appBarHeight,
    color: AppColors.paleGrey1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MessagesIconWidget(newMessages: newMessages),
        Padding(
          padding: paddingMedium,
          child: InkWell(
            onTap: () {},
            child: Stack(children: [
              Container(
                child: svgToIcon(
                  appImagesName: AppImages.userIcon,
                ),
              ),
            ]),
          ),
        ),
        Padding(
          padding: paddingMedium,
          child: InkWell(
            onTap: () {
              // TODO: User settings page
            },
            child: Row(
              children: [
                FutureBuilder(
                    future: getUserData(),
                    builder: (context, builder) {
                      final userName = builder.data.toString();
                      return Text(
                        userName,
                        style: const TextStyle(
                          color: AppColors.blackColor,
                        ),
                      );
                    }),
                const Icon(
                  Icons.expand_more_rounded,
                  color: AppColors.blackColor,
                ),
              ],
            ),
          ),
        ),
        InkWell(
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
            padding: paddingLarge,
            child: Tooltip(
              margin: paddingSmall,
              message: 'Logout',
              child: Image.asset(existAsset),
            ),
          ),
        ),
        // Container(width: 70),
      ],
    ),
  );
}

Future<String> getUserData() async {
  final UserRepository userRepository = UserRepository();
  LoggedUser userData = await userRepository.readUser();
  return userData.data.firstName.toString() +
      " " +
      userData.data.lastName.toString();
}
