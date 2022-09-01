// import 'package:flutter/material.dart';
// import 'package:gtm/_shared/shared.dart';
// import 'package:gtm/_shared/widgets/_common/_mobile/back_icon_section_widget.dart';
// import 'package:gtm/_shared/widgets/_common/_mobile/gtm_square_log_section_widget.dart';
// import 'package:gtm/_shared/widgets/_common/_mobile/textfields/m_custom_password_text_form_field.dart';
// import 'package:gtm/_shared/widgets/_common/_mobile/uas_logo_section_widget.dart';
// import 'package:gtm/pages/authentication/login_screen.dart';
// import 'package:gtm/pages/reset_password/bloc/m_reset_password_cubit.dart';

// class MResetPasswordScreen extends StatefulWidget {
//   final String email;
//   final String token;
//   const MResetPasswordScreen(
//       {Key? key, required this.email, required this.token})
//       : super(key: key);

//   @override
//   State<MResetPasswordScreen> createState() => _MResetPasswordScreenState();
// }

// class _MResetPasswordScreenState extends State<MResetPasswordScreen> {
//   late String _token;

//   @override
//   void initState() {
//     _token = widget.token;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: OnTapHideKeyBoard(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 height(32),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: BackIconSectionWidget(),
//                 ),
//                 const GTMSquareLogoWidget(),
//                 height(12),
//                 appText(
//                   "Resetting password",
//                   textStyle: const TextStyle(
//                     color: AppColors.brownGrey,
//                     fontSize: 16,
//                   ),
//                 ),
//                 height(24),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 1.2,
//                   height: MediaQuery.of(context).size.height / 1.94,
//                   child: Column(
//                     children: [
//                       _buildPasswordButton(context),
//                       height(16),
//                       _buildConfirmPasswordButton(context),
//                       height(16),
//                       _buildSubmitButton(context),
//                     ],
//                   ),
//                 ),
//                 const UASLogoSectionWidget(),
//                 height(20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordButton(BuildContext context) {
//     return BlocBuilder<MResetPasswordCubit, MResetPasswordState>(
//       buildWhen: (MResetPasswordState previous, MResetPasswordState current) =>
//           previous.status != current.status,
//       builder: (BuildContext context, MResetPasswordState state) {
//         return MCustomPasswordTextFormField(
//           hintText: 'Enter Password',
//           labelText: 'Password',
//           // errorText: state.password.invalid ? 'Please enter password' : null,
//           onChanged: (String value) {
//             context.read<MResetPasswordCubit>().passwordChanged(value);
//           },
//           validator: Validators().passwordValidator,
//         );
//       },
//     );
//   }

//   Widget _buildConfirmPasswordButton(BuildContext context) {
//     return BlocBuilder<MResetPasswordCubit, MResetPasswordState>(
//       buildWhen: (MResetPasswordState previous, MResetPasswordState current) =>
//           previous.status != current.status,
//       builder: (BuildContext context, MResetPasswordState state) {
//         return MCustomPasswordTextFormField(
//           hintText: 'Re-type Password',
//           labelText: 'Re-type Password',
//           // errorText: state.password.invalid ? 'Please enter password' : null,
//           onChanged: (String value) {
//             context.read<MResetPasswordCubit>().passwordChanged(value);
//           },
//           validator: Validators().passwordValidator,
//         );
//       },
//     );
//   }

//   Widget _buildSubmitButton(BuildContext context) {
//     return BlocBuilder<MResetPasswordCubit, MResetPasswordState>(
//       buildWhen: (MResetPasswordState previous, MResetPasswordState current) =>
//           previous.status != current.status,
//       builder: (BuildContext context, MResetPasswordState state) {
//         return AppButton(
//           buttonText: 'Save',
//           textColor: AppColors.whiteColor,
//           onTap: () async {
//             await context
//                 .read<MResetPasswordCubit>()
//                 .updatePassword(token: _token);
//             print("success");
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const LoginScreen(),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
