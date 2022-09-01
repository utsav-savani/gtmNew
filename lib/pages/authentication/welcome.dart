import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/config/router/routes.dart';
import 'package:gtm/responsive/screen_type_layout.dart';
import 'package:gtm/generated/l10n.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _buildMobile(context),
        tablet: _buildWeb(context),
        desktop: _buildWeb(context));
  }

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomWidgets().buildRobotHandImage(),
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomWidgets().buildGTMLogoVertical(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                height(MediaQuery.of(context).size.height / 20),
                _buildWelcomeText(),
                height(MediaQuery.of(context).size.height / 12),
                _buildLoginButton(context),
                height(MediaQuery.of(context).size.height / 14),
                _buildDoNotHaveAccount(),
                _buildRequestAccount(context),
                const Spacer(),
                CustomWidgets().buildUASLogo(),
                height(20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeb(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //CustomWidgets().buildGTMLogoHorizontal(),
          Expanded(
            flex: 98,
            child: Row(
              children: [
                Expanded(
                  child: CustomWidgets().buildRobotHandImage(),
                  flex: 6,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ConstrainedBox(
                              child: CustomWidgets().buildGTMWelcomeLogoSvg(
                                  width: 260, height: 270),
                              constraints: const BoxConstraints(
                                maxHeight: 270,
                                maxWidth: 260,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 64),
                            child: _buildWelcomeText(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 64),
                            child: _buildLoginButton(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: _buildDoNotHaveAccount(),
                          ),
                          _buildRequestAccount(context),
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: CustomWidgets().buildUASLogo(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomWidgets().buildHorizontalLine(
              color: AppColors.blueBerryColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.push(Routes.login);
      },
      child: Text(S.current.login),
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      S.current.welcomeBack,
      style: const TextStyle(
        color: AppColors.defaultColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDoNotHaveAccount() {
    return Text(
      S.current.dontHaveAnAccount,
      style: const TextStyle(
        color: AppColors.lightBlueGrey,
        fontSize: 12,
      ),
    );
  }

  Widget _buildRequestAccount(BuildContext context) {
    return InkWell(
      child: Text(
        S.current.requestAccount,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: AppColors.deepSkyBlue,
          fontSize: 14,
        ),
      ),
      onTap: () => context.pushNamed(Routes.register),
    );
  }
}
