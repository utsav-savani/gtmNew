// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:gtm/_shared/shared.dart';
// import 'package:gtm/pages/enter_otp/bloc/enter_otp_bloc.dart';
// import 'package:gtm/pages/forgot_password/bloc/forgot_password_bloc.dart';
// import 'package:gtm/pages/reset_password/reset_password.dart';
// import 'package:gtm/pages/widgets/widgets.dart';

// class MEnterOtpPage extends StatelessWidget {
//   const MEnterOtpPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String headerName = 'Enter Otp';
//     String emailAddress = '';
//     return BlocListener<EnterOtpBloc, EnterOtpState>(
//       listener: (context, state) {
//         // TODO: implement listener
//         if (state.status == EnterOptStatus.success) {
//           context.read<EnterOtpBloc>().add(ResetEnterOtpBloc());
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const ResetPasswordPage()));
//         }
//       },
//       child: IntroScreenSkeleton(
//           headerName: headerName,
//           widgetToDarw: Column(
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: const Text(
//                   'A 4 digit code has been sent to your email',
//                 ),
//               ),
//               height(5),
//               BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
//                 builder: (context, state) {
//                   emailAddress = state.email;
//                   return Container(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       '"${state.email}"',
//                     ),
//                   );
//                 },
//               ),
//               height(40),
//               Wrap(
//                 alignment: WrapAlignment.start,
//                 spacing: 8,
//                 direction: Axis.horizontal,
//                 runSpacing: 10,
//                 children: [
//                   _otpTextField(context, true, 0),
//                   _otpTextField(context, false, 1),
//                   _otpTextField(context, false, 2),
//                   _otpTextField(context, false, 3),
//                 ],
//               ),
//               height(40),
//               Row(
//                 children: [
//                   BlocBuilder<EnterOtpBloc, EnterOtpState>(
//                     builder: (context, state) {
//                       return LightButton(
//                           buttonText: 'Confirm',
//                           buttonHeight: 42,
//                           buttonWidth: MediaQuery.of(context).size.width,
//                           isLight: false,
//                           onPressed: () {
//                             context.read<EnterOtpBloc>().add(
//                                 SubmitOtpForAuthentication(
//                                     otp: state.otp, email: emailAddress));
//                           });
//                     },
//                   ),
//                 ],
//               ),
//               height(20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Didn\'t received OTP yet? ',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText2
//                         ?.copyWith(color: Colors.black.withOpacity(0.6)),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       print(emailAddress);
//                       AuthenticationRepository().sendOTPToResetPassword(
//                         AuthenticationRepository()
//                             .generateSendOTPToResetPasswordPayload(
//                                 email: emailAddress),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5),
//                       child: Text(
//                         'Resend OTP',
//                         style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                             color: AppColors.primaryColor,
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               height(20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                       child: Divider(
//                     indent: MediaQuery.of(context).size.width * 0.2,
//                     thickness: 2,
//                   )),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8),
//                     child: Text('OR'),
//                   ),
//                   Expanded(
//                       child: Divider(
//                     thickness: 2,
//                     endIndent: MediaQuery.of(context).size.width * 0.2,
//                   ))
//                 ],
//               ),
//               height(20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Want to change Email Id? ',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText2
//                         ?.copyWith(color: Colors.black.withOpacity(0.6)),
//                   ),
//                   InkWell(
//                     onTap: () => Navigator.pop(context),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5),
//                       child: Text(
//                         'Click here',
//                         style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                             color: AppColors.primaryColor,
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           )),
//     );
//   }
// }

// Widget _otpTextField(BuildContext context, bool autoFocus, int index) {
//   return BlocBuilder<EnterOtpBloc, EnterOtpState>(
//     builder: (context, state) {
//       return Container(
//         height: MediaQuery.of(context).size.shortestSide * 0.13,
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.primaryColor),
//           borderRadius: BorderRadius.circular(5),
//           color: Colors.white,
//           shape: BoxShape.rectangle,
//         ),
//         child: AspectRatio(
//           aspectRatio: 1,
//           child: TextField(
//             autofocus: autoFocus,
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//             ),
//             textAlign: TextAlign.center,
//             keyboardType: TextInputType.number,
//             maxLines: 1,
//             onChanged: (value) {
//               if (value.length == 1) {
//                 context
//                     .read<EnterOtpBloc>()
//                     .add(AddOtpDigit(otpDigit: value, index: index));
//                 if (index != 3) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               }
//             },
//           ),
//         ),
//       );
//     },
//   );
// }
