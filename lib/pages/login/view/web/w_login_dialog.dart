// import 'package:flutter/material.dart';
// import 'package:formz/formz.dart';
// import 'package:gtm/pages/login/view/cubit/login_cubit.dart';

// import '../../../../_shared/shared.dart';

// class WLoginDialog extends StatefulWidget {
//   const WLoginDialog({Key? key}) : super(key: key);

//   @override
//   State<WLoginDialog> createState() => _WLoginDialogState();
// }

// class _WLoginDialogState extends State<WLoginDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           // height: 60.h,
//           // width: 30.w,
//           child: Stack(children: [
//             Positioned(
//                 right: spacing4,
//                 top: spacing4,
//                 child: InkWell(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: const Padding(
//                     padding: paddingMedium,
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 )),
//             Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Image.asset(assetUasLogo),
//                 SizedBox(
//                   width: spacing384,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: paddingMedium,
//                         child: Text(login,
//                             style: Theme.of(context).textTheme.headline5!.merge(
//                                   const TextStyle(
//                                       color: AppColors.defaultColor),
//                                 )),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(
//                           spacing20,
//                           spacing8,
//                           spacing20,
//                           spacing20,
//                         ),
//                         child: _buildEmailTextField(),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(
//                           spacing20,
//                           spacing8,
//                           spacing20,
//                           spacing20,
//                         ),
//                         child: _buildPasswordTextField(),
//                       ),
//                       _buildSubmitButton()
//                     ],
//                   ),
//                 ),
//               ],
//             )),
//           ]),
//           margin: const EdgeInsets.symmetric(horizontal: spacing4),
//           decoration: BoxDecoration(
//             color: AppColors.paleGrey,
//             borderRadius: BorderRadius.circular(spacing6),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmailTextField() {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (LoginState previous, LoginState current) =>
//           previous.email != current.email,
//       builder: (BuildContext context, LoginState state) {
//         return TextFormField(
//           // autofillHints: const [AutofillHints.email],
//           onChanged: (String email) =>
//               context.read<LoginCubit>().emailChanged(email),
//           decoration: InputDecoration(
//             enabledBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(spacing4)),
//               borderSide: BorderSide(
//                 color: AppColors.blueGrey,
//               ),
//             ),
//             // icon: Icon(
//             //   Icons.email,
//             //   size: MediaQuery.of(context).size.width * .012,
//             // ),
//             labelText: emailLabel,
//             hintText: emailAddress,
//             errorText: state.email.invalid ? invalidEmail : null,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPasswordTextField() {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (LoginState previous, LoginState current) =>
//           previous.password != current.password,
//       builder: (BuildContext context, LoginState state) {
//         return TextFormField(
//           textInputAction: TextInputAction.go,
//           onFieldSubmitted: (value) {
//             context.read<LoginCubit>().logInWithCredentials();
//           },
//           // autofillHints: const [AutofillHints.password],
//           obscureText: true,
//           obscuringCharacter: obscureText,
//           key: const Key(keyLoginForm),
//           onChanged: (String password) =>
//               context.read<LoginCubit>().passwordChanged(password),
//           decoration: InputDecoration(
//             // icon: Icon(
//             //   Icons.lock,
//             //   size: MediaQuery.of(context).size.width * .012,
//             // ),
//             labelText: enterPassword,
//             hintText: passWord,
//             errorText: state.password.invalid ? invalidPassword : null,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSubmitButton() {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (LoginState previous, LoginState current) =>
//           previous.status != current.status,
//       builder: (BuildContext context, LoginState state) {
//         return ElevatedButton(
//             style: ButtonStyle(
//               minimumSize: MaterialStateProperty.all<Size?>(
//                   const Size(spacing180, spacing40)),
//             ),
//             key: const Key(keySubmitButton),
//             onPressed: () {
//               context.read<LoginCubit>().logInWithCredentials();
//             },
//             child: Row(mainAxisSize: MainAxisSize.min, children: [
//               const Padding(
//                 padding: paddingSmall,
//                 child: Text(submit),
//               ),
//               state.status.isSubmissionInProgress
//                   ? const SizedBox(
//                       width: spacing24,
//                       height: spacing24,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: spacing4,
//                       ),
//                     )
//                   : const SizedBox(),
//             ]));
//       },
//     );
//   }
// }
