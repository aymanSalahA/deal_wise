import 'package:deal_wise/features/auth/presentation/cubit/forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service/forgot_password_service.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordService _service;

  ForgotPasswordCubit(this._service) : super(ForgotPasswordInitial());

  Future<void> sendResetLink(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await _service.sendResetLink(email);
      emit(ForgotPasswordSuccess(email)); 
    } catch (e) {
      emit(ForgotPasswordFailure());
    }
  }
}
