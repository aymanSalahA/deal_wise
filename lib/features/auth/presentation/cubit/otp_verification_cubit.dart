import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_verification_state.dart';
import 'package:deal_wise/features/auth/data/models/auth_view_model.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final String email;  
  final String otp;   
  final AuthViewModel authVM;

  Timer? _timer;

  OtpVerificationCubit({
    required this.email,
    required this.otp,
    required this.authVM,
  }) : super(const OtpInitial()) {
    startTimer();
  }

  void startTimer() {
    
    _timer?.cancel();

    emit(const OtpInitial(timer: 60, canResend: false));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state is! OtpInitial) {
        timer.cancel();
        return;
      }

      final currentState = state as OtpInitial;

      if (currentState.timer == 0) {
        emit(currentState.copyWith(canResend: true));
        timer.cancel();
      } else {
        emit(currentState.copyWith(timer: currentState.timer - 1));
      }
    });
  }

  Future<void> verifyOtp(String enteredOtp) async {
    if (enteredOtp.length != 6) {
      emit(const OtpVerificationFailure('Please enter the full 6-digit code.'));
      emit((state as OtpInitial).copyWith());
      return;
    }

    emit(OtpVerificationLoading(timer: state.timer, canResend: state.canResend));

    try {
      bool success = await authVM.validateOtp(email, enteredOtp);

      if (success) {
        _timer?.cancel();
        emit(const OtpVerificationSuccess());
      } else {
        emit(
          OtpVerificationFailure(
            authVM.errorMessage ?? 'Invalid OTP',
            timer: state.timer,
            canResend: state.canResend,
          ),
        );
      }
    } catch (e) {
      emit(
        OtpVerificationFailure(
          e.toString(),
          timer: state.timer,
          canResend: state.canResend,
        ),
      );
    }
  }

  Future<void> resendCode() async {
    if (state is! OtpInitial) return;
    final currentState = state as OtpInitial;
    if (!currentState.canResend) return;

    emit(OtpVerificationLoading(timer: 0, canResend: true));

    bool success = await authVM.resendOtp(email);

    if (success) {
      startTimer();
    } else {
      emit(
        OtpVerificationFailure(
          authVM.errorMessage ?? 'Failed to resend code',
          timer: 0,
          canResend: true,
        ),
      );
      emit(const OtpInitial(timer: 0, canResend: true));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
