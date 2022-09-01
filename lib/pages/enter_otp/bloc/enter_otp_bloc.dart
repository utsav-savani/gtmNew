// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'enter_otp_event.dart';
// part 'enter_otp_state.dart';

// class EnterOtpBloc extends Bloc<EnterOtpEvent, EnterOtpState> {
//   final AuthenticationRepository _authenticationRepository;
//   EnterOtpBloc({required AuthenticationRepository authenticationRepository})
//       : _authenticationRepository = authenticationRepository,
//         super(const EnterOtpState(otp: '')) {
//     on<AddOtpDigit>(_addOtpDigit);
//     on<SubmitOtpForAuthentication>(_submitOtpForAuthentication);
//     on<ResetEnterOtpBloc>(_resetBloc);
//   }
//   _addOtpDigit(AddOtpDigit event, Emitter<EnterOtpState> emit) {
//     emit(state.copyWith(
//         status: EnterOptStatus.initial, otp: state.otp + event.otpDigit));
//   }

//   _submitOtpForAuthentication(
//       SubmitOtpForAuthentication event, Emitter<EnterOtpState> emit) async {
//     emit(state.copyWith(status: EnterOptStatus.loading, otp: state.otp));
//     try {
//       Map<String, dynamic> response =
//           await _authenticationRepository.verifyOTPToResetPassword(
//         _authenticationRepository.generateVerifyOTPToResetPasswordPayload(
//           email: event.email,
//           otp: event.otp,
//         ),
//       );
//       if (response['status'] == 'success') {
//         emit(
//           state.copyWith(
//               otp: event.otp,
//               status: EnterOptStatus.success,
//               token: response['token']),
//         );
//       } else {
//         emit(
//           state.copyWith(
//             otp: event.otp,
//             status: EnterOptStatus.failure,
//           ),
//         );
//       }
//       print('Line 31 token: ' + response['token']);
//     } catch (e) {
//       emit(state.copyWith(status: EnterOptStatus.failure, otp: state.otp));
//     }
//   }

//   _resetBloc(ResetEnterOtpBloc event, Emitter<EnterOtpState> emit) {
//     emit(state.copyWith(
//         status: EnterOptStatus.initial, otp: state.otp, token: state.token));
//   }
// }
