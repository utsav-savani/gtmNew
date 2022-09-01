// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gtm/_shared/helpers/helpers.dart';
// import 'package:gtm/_shared/widgets/textfields/password_text_field_widget.dart';
// import 'package:gtm/pages/enter_otp/bloc/enter_otp_bloc.dart';
// import 'package:gtm/pages/reset_password/bloc/reset_password_bloc.dart';
// import 'package:gtm/pages/widgets/intro_screen_skeleton.dart';
// import 'package:gtm/pages/widgets/light_button.dart';
// import 'package:gtm/pages/widgets/scafold_error_message.dart';

// class MResetPasswordPage extends StatelessWidget {
//   const MResetPasswordPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String headerName = 'Reset Password';
//     return IntroScreenSkeleton(
//         headerName: headerName,
//         widgetToDarw: const ResetPasswordScreenComponent());
//   }
// }

// class ResetPasswordScreenComponent extends StatelessWidget {
//   const ResetPasswordScreenComponent({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String confirmPass = '';
//     String newPass = '';
//     return Column(
//       children: [
//         PasswordTextField(
//           fieldText: 'New Password',
//           onChanged: (String newPassword) => {newPass = newPassword},
//         ),
//         height(20),
//         PasswordTextField(
//           fieldText: 'Confirm new Password',
//           onChanged: (String confirmNewPassword) =>
//               {confirmPass = confirmNewPassword},
//         ),
//         height(20),
//         Row(
//           children: [
//             BlocListener<ResetPasswordBloc, ResetPasswordState>(
//               listener: (context, state) {
//                 if (state.status == ResetPasswordStatus.success) {
//                   Navigator.popUntil(
//                       context, (Route<dynamic> route) => route.isFirst);
//                 }
//               },
//               child: BlocBuilder<EnterOtpBloc, EnterOtpState>(
//                 builder: (context, state) {
//                   return LightButton(
//                       buttonText: 'Submit',
//                       buttonHeight: 42,
//                       buttonWidth: MediaQuery.of(context).size.width,
//                       isLight: false,
//                       onPressed: () {
//                         if ((newPass.isEmpty) ||
//                             (newPass.compareTo(confirmPass) != 0)) {
//                           print(state.token);
//                           scafoldErrorMessage(
//                               'New password and Confirm password is not equal',
//                               context);
//                         } else {
//                           print(state.token);
//                           context.read<ResetPasswordBloc>().add(
//                               SaveResetPassword(
//                                   newPassword: newPass,
//                                   confirmPassword: confirmPass,
//                                   token: state.token!));
//                         }
//                       });
//                 },
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
