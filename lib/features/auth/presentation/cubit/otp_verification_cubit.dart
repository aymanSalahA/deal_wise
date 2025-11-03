import 'dart:async';
import 'package:deal_wise/features/auth/data/api_service/otp_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_verification_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final String email;
  final String otp;
  final OtpService service;
  final String verificationTarget;


  Timer? _timer;

  OtpVerificationCubit({
  required this.email,
  required this.otp,
  required this.verificationTarget,  
  required this.service,
}) : super(const OtpInitial()) {
  startTimer();
}


  void startTimer() {
    _timer?.cancel();
    emit(const OtpInitial(timer: 60, canResend: false));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = state;
      if (currentState is OtpInitial) {
        if (currentState.timer == 0) {
          emit(currentState.copyWith(canResend: true));
          timer.cancel();
        } else {
          emit(currentState.copyWith(timer: currentState.timer - 1));
        }
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp(String enteredOtp) async {
    if (enteredOtp.length != 6) {
      emit(const OtpVerificationFailure('Please enter the full 6-digit code.'));
      return;
    }

    emit(OtpVerificationLoading(timer: state.timer, canResend: state.canResend));

    try {
      final bool isRegistrationFlow = verificationTarget == 'register';
      final response = isRegistrationFlow
          ? await service.verifyEmail(email, enteredOtp)
          : await service.validateOtp(email, enteredOtp);

      // If tokens are returned as part of OTP validation, persist them
      if (response.containsKey('accessToken')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', response['accessToken']);
        await prefs.setString('refreshToken', response['refreshToken'] ?? '');
        await prefs.setString('expiresAtUtc', response['expiresAtUtc'] ?? '');
      }

      final bool success = response['success'] == true || response.containsKey('accessToken');
      if (success) {
        _timer?.cancel();
        emit(const OtpVerificationSuccess());
      } else {
        emit(const OtpVerificationFailure('Invalid OTP.'));
      }
    } catch (e) {
      emit(OtpVerificationFailure(e.toString()));
    }
  }

  Future<void> resendCode() async {
    if (!state.canResend) return;

    emit(OtpVerificationLoading(timer: 0, canResend: true));

    try {
      final success = await service.resendOtp(email);
      if (success) {
        startTimer();
      } else {
        emit(const OtpVerificationFailure('Failed to resend code.'));
      }
    } catch (e) {
      emit(OtpVerificationFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
