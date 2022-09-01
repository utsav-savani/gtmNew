import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/_mobile/back_icon_section_widget.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/authentication/reset_password.dart';
import 'package:gtm/pages/reset_password/bloc/m_forgot_password_cubit.dart';
import 'package:gtm/pages/reset_password/bloc/m_forgot_password_otp_cubit.dart';
import 'package:gtm/responsive/screen_type_layout.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  late String _email;

  @override
  void initState() {
    _email = widget.email;
    _handleResendButton();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _buildMobile(context),
        tablet: _buildMobile(context),
        desktop: _buildMobile(context));
  }

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      body: BlocListener<MForgotPasswordOtpCubit, MForgotPasswordOtpState>(
        listener: (context, state) {
          if (state.status == EnterOptStatus.failure) {
            AppHelper().showSnackBar(context, message: "${state.errorMessage}");
          } else if (state.status == EnterOptStatus.success) {
            context.push(
              Routes.resetPassword,
              extra: ResetPasswordScreenParams(_email, state.token),
            );
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
                      color: AppColors.brownGrey,
                      fontSize: 16,
                    ),
                  ),
                  height(24),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 1.94,
                    child: Column(
                      children: [
                        underLineText(
                          color: AppColors.charcoalGrey,
                          child: appText(
                            "OTP was sent to",
                            textStyle: const TextStyle(
                              color: AppColors.charcoalGrey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        height(2),
                        underLineText(
                          color: AppColors.blueGrey,
                          child: Text(
                            _email,
                            style: const TextStyle(
                              color: AppColors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        height(20),
                        appText(
                          "Type code",
                          textStyle: const TextStyle(
                            color: AppColors.blueGrey,
                            fontSize: 16,
                          ),
                        ),
                        height(22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _textFieldOTP(first: true, last: false, index: 1),
                            _textFieldOTP(first: false, last: false, index: 2),
                            _textFieldOTP(first: false, last: false, index: 3),
                            _textFieldOTP(first: false, last: true, index: 4),
                          ],
                        ),
                        if (secondsRemaining > 0)
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: appText(
                              "Resend in $secondsRemaining seconds",
                              textStyle: const TextStyle(
                                color: AppColors.brownGrey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (secondsRemaining == 0) _resendOTP(context),
                        height(24),
                        _buildSubmitButton(context),
                      ],
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

  void _handleResendButton() {
    secondsRemaining = 60;
    setState(() {});
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining--;
        setState(() {});
      } else {
        enableResend = true;
        setState(() {});
      }
    });
  }

  Widget _textFieldOTP({required int index, required bool first, last}) {
    return BlocBuilder<MForgotPasswordOtpCubit, MForgotPasswordOtpState>(
      buildWhen:
          (MForgotPasswordOtpState previous, MForgotPasswordOtpState current) =>
              previous.status != current.status,
      builder: (BuildContext context, MForgotPasswordOtpState state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 85,
            width: 50,
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                if (index == 1) {
                  context.read<MForgotPasswordOtpCubit>().otp1Changed(value);
                }
                if (index == 2) {
                  context.read<MForgotPasswordOtpCubit>().otp2Changed(value);
                }
                if (index == 3) {
                  context.read<MForgotPasswordOtpCubit>().otp3Changed(value);
                }
                if (index == 4) {
                  context.read<MForgotPasswordOtpCubit>().otp4Changed(value);
                }
                if (value.length == 1 && last == false) {
                  FocusScope.of(context).nextFocus();
                }
                if (value.isEmpty && first == false) {
                  FocusScope.of(context).previousFocus();
                }
              },
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.blueGrey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: AppColors.lightBlueGrey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<MForgotPasswordOtpCubit, MForgotPasswordOtpState>(
      buildWhen:
          (MForgotPasswordOtpState previous, MForgotPasswordOtpState current) =>
              previous.status != current.status,
      builder: (BuildContext context, MForgotPasswordOtpState state) {
        return ElevatedButton(
            onPressed: () async {
              MForgotPasswordOtpCubit mForgotPasswordOtpCubit =
                  BlocProvider.of(context);
              if (mForgotPasswordOtpCubit.state.otp1.value == '' ||
                  mForgotPasswordOtpCubit.state.otp2.value == '' ||
                  mForgotPasswordOtpCubit.state.otp3.value == '' ||
                  mForgotPasswordOtpCubit.state.otp4.value == '') {
                AppHelper().showSnackBar(context, message: 'Enter OTP');
                return;
              }
              await context
                  .read<MForgotPasswordOtpCubit>()
                  .verifyOTP(email: _email);
              print("====");
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Verify'),
                if (state.status == EnterOptStatus.loading)
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

  Widget _resendOTP(BuildContext context) {
    return BlocBuilder<MForgotPasswordCubit, MForgotPasswordState>(
      buildWhen:
          (MForgotPasswordState previous, MForgotPasswordState current) =>
              previous.status != current.status,
      builder: (BuildContext context, MForgotPasswordState state) {
        return InkWell(
          onTap: () async {
            _handleResendButton();
            await context.read<MForgotPasswordCubit>().sendOTP();
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.status == ForgotPasswordStatus.success)
                  appText(
                    "Resend",
                    textStyle: const TextStyle(
                      color: AppColors.deepSkyBlue,
                      fontSize: 12,
                    ),
                  ),
                if (state.status == ForgotPasswordStatus.loading)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: spacing24,
                      height: spacing24,
                      child: loadingWidget(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
