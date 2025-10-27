import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service/reset_password_service.dart';

class NewPasswordVisibilityCubit extends Cubit<bool> {
  NewPasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}

class ConfirmPasswordVisibilityCubit extends Cubit<bool> {
  ConfirmPasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordService _service;

  ResetPasswordCubit(this._service) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());
    try {
      await _service.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordFailure extends ResetPasswordState {
  final String error;
  ResetPasswordFailure(this.error);
}
