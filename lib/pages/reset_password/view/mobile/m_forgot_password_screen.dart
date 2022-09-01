// import 'package:flutter/material.dart';
// import 'package:gtm/_shared/shared.dart';
// import 'package:gtm/_shared/widgets/_common/_mobile/back_icon_section_widget.dart';
// import 'package:gtm/_shared/widgets/_common/_mobile/gtm_square_log_section_widget.dart';
// import 'package:gtm/_shared/widgets/_common/_mobile/uas_logo_section_widget.dart';
// import 'package:gtm/pages/authentication/otp_verfication.dart';
// import 'package:gtm/pages/authentication/register.dart';
// import 'package:gtm/pages/reset_password/bloc/m_forgot_password_cubit.dart';

// class MForgotPasswordScreen extends StatefulWidget {
//   const MForgotPasswordScreen({Key? key}) : super(key: key);

//   @override
//   State<MForgotPasswordScreen> createState() => _MForgotPasswordScreenState();
// }

// class _MForgotPasswordScreenState extends State<MForgotPasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return OnTapHideKeyBoard(
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               height(32),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: BackIconSectionWidget(),
//               ),
//               const GTMSquareLogoWidget(),
//               height(12),
//               appText(
//                 "Resetting password",
//                 textStyle: const TextStyle(
//                   color: AppColors.charcoalGrey,
//                   fontSize: 16,
//                 ),
//               ),
//               height(4),
//               appText(
//                 "Enter Email linked with your account",
//                 textStyle: const TextStyle(
//                   color: AppColors.brownGrey,
//                   fontSize: 14,
//                 ),
//               ),
//               height(16),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 height: MediaQuery.of(context).size.height / 2,
//                 child: Column(
//                   children: [
//                     _buildEmailTextFiled(context),
//                     height(28),
//                     _buildSubmitButton(context),
//                     height(MediaQuery.of(context).size.height / 14),
//                     appText(
//                       "Don’t have an account?",
//                       textStyle: const TextStyle(
//                         color: AppColors.lightBlueGrey,
//                         fontSize: 12,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const RegisterScreen(),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: underLineText(
//                           child: appText(
//                             "Request an account",
//                             textStyle: const TextStyle(
//                               color: AppColors.deepSkyBlue,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const UASLogoSectionWidget(),
//               height(20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmailTextFiled(BuildContext context) {
//     return BlocBuilder<MForgotPasswordCubit, MForgotPasswordState>(
//       buildWhen:
//           (MForgotPasswordState previous, MForgotPasswordState current) =>
//               previous.status != current.status,
//       builder: (BuildContext context, MForgotPasswordState state) {
//         return MCustomTextFormField(
//           hintText: 'Enter Email Id',
//           // errorText: state.email.invalid ? 'Please enter email' : null,
//           onChanged: (String value) {
//             context.read<MForgotPasswordCubit>().emailChanged(value);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildSubmitButton(BuildContext context) {
//     return BlocBuilder<MForgotPasswordCubit, MForgotPasswordState>(
//       buildWhen:
//           (MForgotPasswordState previous, MForgotPasswordState current) =>
//               previous.status != current.status,
//       builder: (BuildContext context, MForgotPasswordState state) {
//         return AppButton(
//           buttonText: 'Submit',
//           textColor: AppColors.whiteColor,
//           onTap: () async {
//             final String email = state.email.value;
//             print(email);
//             await context.read<MForgotPasswordCubit>().sendOTP();
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => OTPVerificationScreen(email: email),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
