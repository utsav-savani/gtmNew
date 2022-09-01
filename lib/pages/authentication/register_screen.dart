import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/libraries/app_alert.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/_mobile/back_icon_section_widget.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/register/bloc/m_register_cubit.dart';
import 'package:gtm/responsive/screen_type_layout.dart';

final _registerFormKey = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
      body: BlocListener<MRegisterCubit, MRegiserState>(
        listener: (context, state) {
          if (state.status == RegisterFormStatus.failure) {
            AppHelper().showSnackBar(context, message: loginError);
          }
          if (state.status == RegisterFormStatus.success) {
            AppAlert.show(
              context,
              title: "Success",
              body: 'The account has been requested successfully',
              buttonTextCallback: () {
                Router.neglect(
                  context,
                  () {
                    context.go(Routes.welcome);
                  },
                );
              },
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
                    "Requesting an account",
                    textStyle: const TextStyle(
                      color: AppColors.brownGrey,
                      fontSize: 16,
                    ),
                  ),
                  height(24),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 1.94,
                    child: Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          _buildNameTextFiled(context),
                          height(16),
                          _buildCompanyNameTextFiled(context),
                          height(16),
                          _buildEmailTextFiled(context),
                          height(28),
                          _buildSubmitButton(context),
                          height(MediaQuery.of(context).size.height / 20),
                          _buildAlreadyHaveAccount(),
                          _buildLoginUnderlined(context),
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

  Widget _buildAlreadyHaveAccount() {
    return const Text(
      'Already have an account?',
      style: TextStyle(
        color: AppColors.lightBlueGrey,
        fontSize: 12,
      ),
    );
  }

  Widget _buildLoginUnderlined(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Routes.login),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "Login",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: AppColors.deepSkyBlue,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextFiled(BuildContext context) {
    return BlocBuilder<MRegisterCubit, MRegiserState>(
      buildWhen: (MRegiserState previous, MRegiserState current) =>
          previous.status != current.status,
      builder: (BuildContext context, MRegiserState state) {
        return CustomWidgets().buildConstrainedTextFormField(
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Email Id',
              labelText: 'Email Id',
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) {
              context.read<MRegisterCubit>().emailChanged(value);
            },
            validator: Validators().emailValidator,
          ),
        );
      },
    );
  }

  Widget _buildCompanyNameTextFiled(BuildContext context) {
    return BlocBuilder<MRegisterCubit, MRegiserState>(
      buildWhen: (MRegiserState previous, MRegiserState current) =>
          previous.status != current.status,
      builder: (BuildContext context, MRegiserState state) {
        return CustomWidgets().buildConstrainedTextFormField(
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Company Name',
              labelText: 'Company Name',
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (String value) {
              context.read<MRegisterCubit>().companyNameChanged(value);
            },
            validator: Validators().emptyTextValidator('Enter Company name'),
          ),
        );
      },
    );
  }

  Widget _buildNameTextFiled(BuildContext context) {
    return BlocBuilder<MRegisterCubit, MRegiserState>(
      buildWhen: (MRegiserState previous, MRegiserState current) =>
          previous.status != current.status,
      builder: (BuildContext context, MRegiserState state) {
        return CustomWidgets().buildConstrainedTextFormField(
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Name',
              labelText: 'Name',
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (String value) {
              context.read<MRegisterCubit>().nameChanged(value);
            },
            validator: Validators().emptyTextValidator('Enter name'),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<MRegisterCubit, MRegiserState>(
      buildWhen: (MRegiserState previous, MRegiserState current) =>
          previous.status != current.status,
      builder: (BuildContext context, MRegiserState state) {
        return ElevatedButton(
          onPressed: () async {
            if (!_registerFormKey.currentState!.validate()) {
              return;
            }
            await context.read<MRegisterCubit>().createAccount();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Request'),
              if (state.status == RegisterFormStatus.loading)
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
