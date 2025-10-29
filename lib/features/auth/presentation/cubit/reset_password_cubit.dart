// reset_password_cubit.dart
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service/reset_password_service.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordService _resetPasswordService;

  ResetPasswordCubit(this._resetPasswordService)
    : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());
    try {
      await _resetPasswordService.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      emit(ResetPasswordSuccess());
    } on DioException catch (e) {
      emit(ResetPasswordError('Network error: ${e.message}'));
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }

  // Add this helper method to avoid the warning
  void showValidationError(String message) {
    emit(ResetPasswordError(message));
  }
}

// States
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordError extends ResetPasswordState {
  final String message;
  ResetPasswordError(this.message);
}
