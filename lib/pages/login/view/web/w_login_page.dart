// import 'package:flutter/material.dart';
// import 'package:formz/formz.dart';
// import 'package:gtm/_shared/shared.dart';
// import 'package:gtm/pages/login/login.dart';
// import 'package:gtm/pages/login/view/web/w_login_dialog.dart';

// /// Login Page for the user with Microsoft B2C too
// class WLoginPage extends StatelessWidget {
//   ///
//   /// pass key to test
//   ///
//   const WLoginPage({Key? key}) : super(key: key);

//   static Page page() => const MaterialPage<void>(child: WLoginPage());

//   static Route route() {
//     return MaterialPageRoute<void>(builder: (_) => const WLoginPage());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             top: spacing40,
//             left: spacing40,
//             child: Image.asset(assetGtmLogo),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 flex: 3,
//                 child: Image.asset(assetRoboHand),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         loginAppName,
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.headline2!,
//                       ),
//                       Column(
//                         children: [
//                           _buildLoginButton(context),
//                           const Padding(
//                             padding: paddingMedium,
//                             child: Text(welcomeBack,
//                                 style: TextStyle(
//                                   color: AppColors.defaultColor,
//                                 )),
//                           ),
//                         ],
//                       ),
//                       Flexible(
//                         child: Image.asset(
//                           assetUasLogo,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     ]),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         showLoginDialog(context);
//       },
//       child: const Text(login),
//     );
//   }
// }

// void showLoginDialog(BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierLabel: '',
//     barrierDismissible: true,
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (BuildContext dialogContext, __, ___) {
//       return BlocListener<LoginCubit, LoginState>(
//         listener: ((context, state) {
//           if (state.status == FormzStatus.submissionSuccess) {
//             Router.neglect(context, () {
//               context.push(Routes.dashboard);
//             });
//           }
//           if (state.status == FormzStatus.submissionFailure) {
//             ScaffoldMessenger.of(dialogContext)
//                 .showSnackBar(const SnackBar(content: Text(loginError)));
//           }
//         }),
//         child: const WLoginDialog(),
//       );
//     },
//     transitionBuilder: (_, anim, __, child) {
//       Tween<Offset> tween;
//       if (anim.status == AnimationStatus.reverse) {
//         tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
//       } else {
//         tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
//       }
//       return SlideTransition(
//         position: tween.animate(anim),
//         child: FadeTransition(
//           opacity: anim,
//           child: child,
//         ),
//       );
//     },
//   );
// }
