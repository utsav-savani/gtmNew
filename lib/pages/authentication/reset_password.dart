import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/libraries/app_alert.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/_mobile/back_icon_section_widget.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/login/models/models.dart';
import 'package:gtm/pages/reset_password/bloc/m_reset_password_cubit.dart';
import 'package:gtm/responsive/screen_type_layout.dart';

class ResetPasswordScreenParams {
  String email;
  String token;

  ResetPasswordScreenParams(this.email, this.token);
}

final _resetPasswordFormKey = GlobalKey<FormState>();

class ResetPasswordScreen extends StatefulWidget {
  final ResetPasswordScreenParams params;

  const ResetPasswordScreen({Key? key, required this.params}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureText = true;
  bool _obscureText2 = true;
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
      body: OnTapHideKeyBoard(
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
                CustomWidgets().buildGTMWelcomeLogoSvg(width: 180, height: 180),
                height(12),
                _buildResettingPassword(),
                height(24),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 1.94,
                  child: Form(
                    key: _resetPasswordFormKey,
                    child: Column(
                      children: [
                        _buildPasswordField(context),
                        height(16),
                        _buildConfirmPasswordField(context),
                        height(16),
                        _buildSaveButton(context),
                      ],
                    ),
                  ),
                ),
                CustomWidgets().buildUASLogo(),
                height(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResettingPassword() {
    return const Text(
      'Resetting password',
      style: TextStyle(
        color: AppColors.brownGrey,
        fontSize: 16,
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocBuilder<MResetPasswordCubit, MResetPasswordState>(
      buildWhen: (MResetPasswordState previous, MResetPasswordState current) =>
          previous.status != current.status,
      builder: (BuildContext context, MResetPasswordState state) {
        return CustomWidgets().buildConstrainedTextFormField(TextFormField(
          obscureText: _obscureText,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Enter New Password',
            labelText: 'New Password',
            suffixIcon: InkWell(
              onTap: () {
                _obscureText = !_obscureText;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  _obscureText
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye_rounded,
                ),
              ),
            ),
          ),
          onChanged: (String value) {
            context.read<MResetPasswordCubit>().passwordChanged(value);
          },
          validator: Validators().emptyTextValidator('Enter password'),
        ));
      },
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return BlocBuilder<MResetPasswordCubit, MResetPasswordState>(
      buildWhen: (MResetPasswordState previous, MResetPasswordState current) =>
          previous.status != current.status,
      builder: (BuildContext context, MResetPasswordState state) {
        return CustomWidgets().buildConstrainedTextFormField(TextFormField(
          obscureText: _obscureText2,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Enter Re-type New Password',
            labelText: 'Re-type New Password',
            suffixIcon: InkWell(
              onTap: () {
                _obscureText2 = !_obscureText2;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  _obscureText2
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye_rounded,
                ),
              ),
            ),
          ),
          onChanged: (String value) {
            context.read<MResetPasswordCubit>().confirmPasswordChanged(value);
          },
          validator: Validators().emptyTextValidator('Re-enter password'),
        ));
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BlocBuilder<MResetPasswordCubit, MResetPasswordState>(
      buildWhen: (MResetPasswordState previous, MResetPasswordState current) =>
          previous.status != current.status,
      builder: (BuildContext context, MResetPasswordState state) {
        return ElevatedButton(
            onPressed: () async {
              if (!_resetPasswordFormKey.currentState!.validate()) {
                return;
              }

              MResetPasswordCubit mResetPasswordCubit =
                  BlocProvider.of(context);

              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
              if (!regex.hasMatch(mResetPasswordCubit.state.password.value)) {
                return AppHelper().showSnackBar(
                  context,
                  message:
                      'Please enter atleast 6 characters in length with one uppercase, lowercase, number and symbol',
                );
              }
              if (mResetPasswordCubit.state.password !=
                  mResetPasswordCubit.state.cpassword) {
                AppHelper()
                    .showSnackBar(context, message: 'Passwords does not match');
                return;
              }

              await context.read<MResetPasswordCubit>().updatePassword(
                    token: widget.params.token,
                  );

              AppHelper().showSnackBar(context,
                  message: 'Password reset successfully!');
              AppAlert.show(
                context,
                title: "Success",
                body: 'Password reset successfully!',
                buttonTextCallback: () {
                  Router.neglect(
                    context,
                    () {
                      context.go(Routes.welcome);
                    },
                  );
                },
              );

              // Router.neglect(context, () {
              //   context.push(Routes.login);
              // });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Save'),
                if (state.status.isSubmissionInProgress)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: spacing24,
                      height: spacing24,
                      child: loadingWidget(color: AppColors.whiteColor),
                    ),
                  ),
              ],
            ));
      },
    );
  }
}
