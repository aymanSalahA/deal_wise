import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service/reset_password_service.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordService _service;

  ResetPasswordCubit(this._service) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    log('🔹 resetPassword() called');
    emit(ResetPasswordLoading());
    log('🔹 State: ResetPasswordLoading');

    try {
      await _service.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      log('✅ API success');
      emit(ResetPasswordSuccess());
      log('🔹 State: ResetPasswordSuccess');
    } on DioException catch (e) {
      final message =
          e.response?.data?.toString() ?? e.message ?? 'Unknown Dio error';
      log('❌ DioException: $message');
      emit(ResetPasswordFailure(message));
      log('🔹 State: ResetPasswordFailure');
    } catch (e) {
      log('❌ General Exception: $e');
      emit(ResetPasswordFailure(e.toString()));
      log('🔹 State: ResetPasswordFailure (general)');
    }
  }

  void setError(String message) {
    log('⚠️ Validation Error: $message');
    emit(ResetPasswordFailure(message));
  }
}

// States
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordFailure extends ResetPasswordState {
  final String error;
  ResetPasswordFailure(this.error);
}
