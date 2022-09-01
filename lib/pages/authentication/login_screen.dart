import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/_mobile/back_icon_section_widget.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/authentication/auth_info.dart';
import 'package:gtm/pages/login/view/cubit/login_cubit.dart';
import 'package:gtm/responsive/screen_type_layout.dart';

GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }

    // add buildVersionNumber to the Version prefix from utilities.dart
    getVersionNumber().then((str) {
      versionNumber = versionNumberPrefix +
          (int.parse(str.split('-')[0]) / 1000).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _buildMobile(context),
      tablet: _buildMobile(context),
      desktop: _buildMobile(context),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionFailure) {
            AppHelper().showSnackBar(context, message: loginError);
          }
        },
        child: OnTapHideKeyBoard(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  height(32),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BackIconSectionWidget(),
                  ),
                  CustomWidgets()
                      .buildGTMWelcomeLogoSvg(width: 180, height: 180),
                  height(24),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          _buildEmailTextField(),
                          height(16),
                          _buildPasswordTextField(),
                          height(28),
                          _buildSubmitButton(),
                          height(MediaQuery.of(context).size.height / 20),
                          _buildForgotPassword(),
                          _buildResetPassword(context),
                        ],
                      ),
                    ),
                  ),
                  CustomWidgets().buildUASLogo(),
                  height(20),
                  appText(
                    versionNumber,
                    fontSize: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return const Text(
      'Forgot Your Password?',
      style: TextStyle(
        color: AppColors.lightBlueGrey,
        fontSize: 12,
      ),
    );
  }

  Widget _buildResetPassword(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Routes.forgotPassword),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Reset Password',
          style: TextStyle(
            color: AppColors.deepSkyBlue,
            decoration: TextDecoration.underline,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.email != current.email,
      builder: (BuildContext context, LoginState state) {
        return CustomWidgets().buildConstrainedTextFormField(
          TextFormField(
            onChanged: (String email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: emailLabel,
              hintText: emailAddress,
            ),
            validator: Validators().emailValidator,
          ),
        );
      },
    );
  }

  Widget _buildPasswordTextField() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.password != current.password,
      builder: (BuildContext context, LoginState state) {
        return CustomWidgets().buildConstrainedTextFormField(
          TextFormField(
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (value) {
              context.read<LoginCubit>().logInWithCredentials();
            },
            validator: Validators().passwordValidator,
            obscureText: _obscureText,
            obscuringCharacter: obscureText,
            key: const Key(keyLoginForm),
            onChanged: (String password) =>
                context.read<LoginCubit>().passwordChanged(password),
            decoration: InputDecoration(
              labelText: enterPassword,
              hintText: passWord,
              suffixIcon: InkWell(
                onTap: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: svgToIcon(
                      appImagesName: _obscureText
                          ? AppImages.eyeIcon
                          : AppImages.eyeFilledIcon,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          context.read<AuthInfo>().login('token');
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (LoginState previous, LoginState current) =>
            previous.status != current.status,
        builder: (BuildContext context, LoginState state) {
          return ElevatedButton(
            key: const Key(keySubmitButton),
            onPressed: () async {
              if (!_loginFormKey.currentState!.validate()) {
                return;
              }
              await context.read<LoginCubit>().logInWithCredentials();
              //context.goNamed(Routes.welcome);
              // LoginCubit loginCubit = BlocProvider.of(context);
              // bool isUserLoggedIn =
              //     loginCubit.state.status == FormzStatus.submissionSuccess;
              // if (isUserLoggedIn) {
              //   // context.pushNamed(Routes.dashboard);
              //   Navigator.of(context).pushNamedAndRemoveUntil(
              //     Routes.dashboard,
              //     (Route<dynamic> route) => false,
              //   );
              // }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(padding: paddingSmall, child: Text("Submit")),
                if (state.status.isSubmissionInProgress)
                  SizedBox(
                    width: spacing24,
                    height: spacing24,
                    child: loadingWidget(color: AppColors.whiteColor),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
