import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/_mobile/back_icon_section_widget.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/reset_password/bloc/m_forgot_password_cubit.dart';
import 'package:gtm/responsive/screen_type_layout.dart';

final _forgotPasswordFormKey = GlobalKey<FormState>();

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _buildMobile(context),
        tablet: _buildMobile(context),
        desktop: _buildMobile(context));
  }

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      body: BlocListener<MForgotPasswordCubit, MForgotPasswordState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordStatus.failure) {
            AppHelper().showSnackBar(context, message: "${state.errorMessage}");
          } else if (state.status == ForgotPasswordStatus.success) {
            context.push(Routes.otpVerify, extra: state.email.value);
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
                  height(12),
                  appText(
                    "Resetting password",
                    textStyle: const TextStyle(
                      color: AppColors.charcoalGrey,
                      fontSize: 16,
                    ),
                  ),
                  height(4),
                  appText(
                    "Enter Email linked with your account",
                    textStyle: const TextStyle(
                      color: AppColors.brownGrey,
                      fontSize: 14,
                    ),
                  ),
                  height(16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Form(
                      key: _forgotPasswordFormKey,
                      child: Column(
                        children: [
                          _buildEmailTextFiled(context),
                          height(28),
                          _buildSubmitButton(context),
                          height(MediaQuery.of(context).size.height / 14),
                          _buildDoNotHaveAccount(),
                          _buildRequestAccount(context),
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
      ),
    );
  }

  Widget _buildDoNotHaveAccount() {
    return const Text(
      "Don't have an account?",
      style: TextStyle(
        color: AppColors.lightBlueGrey,
        fontSize: 12,
      ),
    );
  }

  Widget _buildRequestAccount(BuildContext context) {
    return InkWell(
      child: const Text(
        "Request Account",
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: AppColors.deepSkyBlue,
          fontSize: 14,
        ),
      ),
      onTap: () => context.pushNamed(Routes.register),
    );
  }

  Widget _buildEmailTextFiled(BuildContext context) {
    return BlocBuilder<MForgotPasswordCubit, MForgotPasswordState>(
      buildWhen:
          (MForgotPasswordState previous, MForgotPasswordState current) =>
              previous.status != current.status,
      builder: (BuildContext context, MForgotPasswordState state) {
        return CustomWidgets().buildConstrainedTextFormField(
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Email Id',
              labelText: 'Email Id',
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) {
              context.read<MForgotPasswordCubit>().emailChanged(value);
            },
            validator: Validators().emailValidator,
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<MForgotPasswordCubit, MForgotPasswordState>(
      buildWhen:
          (MForgotPasswordState previous, MForgotPasswordState current) =>
              previous.status != current.status,
      builder: (BuildContext context, MForgotPasswordState state) {
        return ElevatedButton(
          onPressed: () async {
            if (!_forgotPasswordFormKey.currentState!.validate()) {
              return;
            }
            await context.read<MForgotPasswordCubit>().sendOTP();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Submit'),
              if (state.status == ForgotPasswordStatus.loading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: spacing24,
                    height: spacing24,
                    child: loadingWidget(color: AppColors.whiteColor),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
