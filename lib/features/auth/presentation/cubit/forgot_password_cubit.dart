import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service/forgot_password_service.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordService _service;

  ForgotPasswordCubit(this._service) : super(ForgotPasswordInitial());

  Future<void> sendResetLink(String email) async {
    emit(ForgotPasswordLoading());
    await _service.sendResetLink(email);
    emit(ForgotPasswordSuccess());
  }
}

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {}
