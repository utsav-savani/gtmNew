// import 'package:flutter/material.dart';
// import 'package:gtm/_shared/shared.dart';
// import 'package:gtm/_shared/widgets/textfields/form_text_field_widget.dart';
// import 'package:gtm/pages/enter_otp/view/enter_otp_page.dart';
// import 'package:gtm/pages/forgot_password/bloc/forgot_password_bloc.dart';
// import 'package:gtm/pages/widgets/widgets.dart';

// class MForgotPasswordPage extends StatelessWidget {
//   const MForgotPasswordPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String headerName = 'Forgot Password?';
//     return IntroScreenSkeleton(
//         headerName: headerName,
//         widgetToDarw: const ForgotPasswordScreenComponent());
//   }
// }

// class ForgotPasswordScreenComponent extends StatelessWidget {
//   const ForgotPasswordScreenComponent({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String emailAddress;
//     return BlocListener(
//       listener: (BuildContext context, ForgotPasswordState state) {
//         if (state.status == ForgotPasswordStatus.success) {
//           emailAddress = '';
//           context
//               .read<ForgotPasswordBloc>()
//               .add(ResetForgotPasswordBloc(email: state.email));
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const EnterOtpPage()));
//         }
//       },
//       bloc: BlocProvider.of<ForgotPasswordBloc>(context),
//       child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
//         builder: (context, state) {
//           print(state.status);
//           if (state.status == ForgotPasswordStatus.inital ||
//               state.status == ForgotPasswordStatus.failure) {
//             emailAddress = '';
//             return Column(
//               children: [
//                 CustomFormTextFieldWidget(
//                   fieldText: 'Email Address',
//                   textInputType: TextInputType.emailAddress,
//                   onChanged: (String email) => {
//                     emailAddress = email,
//                   },
//                 ),
//                 height(20),
//                 Row(
//                   children: [
//                     LightButton(
//                         buttonText: 'Submit',
//                         buttonHeight: 42,
//                         buttonWidth: MediaQuery.of(context).size.width,
//                         isLight: false,
//                         onPressed: () {
//                           if (emailAddress.isEmpty ||
//                               !emailAddress.contains('@')) {
//                             scafoldErrorMessage(
//                               'Please enter a valid email address',
//                               context,
//                             );
//                           } else {
//                             context
//                                 .read<ForgotPasswordBloc>()
//                                 .add(SendOtpToEmail(email: emailAddress));
//                           }
//                         })
//                   ],
//                 ),
//                 height(20),
//                 InkWell(
//                     onTap: () => {
//                           Navigator.pop(context),
//                         },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.arrow_back,
//                           color: AppColors.primaryColor,
//                           size: 14,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 5),
//                           child: Text(
//                             'Go Back',
//                             style: TextStyle(
//                               color: AppColors.primaryColor,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )),
//               ],
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// // class MoveToOtpPage extends StatefulWidget {
// //   final String email;
// //   const MoveToOtpPage({required this.email, Key? key}) : super(key: key);

// //   @override
// //   State<MoveToOtpPage> createState() => _MoveToOtpPageState();
// // }

// // class _MoveToOtpPageState extends State<MoveToOtpPage> {
// //   @override
// //   void initState() {
// //     Timer(Duration(milliseconds: 200), () {
// //       Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //               builder: (BuildContext context) => const EnterOtpPage()));
// //       context
// //           .read<ForgotPasswordBloc>()
// //           .add(ResetForgotPasswordBloc(email: widget.email));
// //     });

// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }
