import 'package:deal_wise/features/auth/data/api_service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService service;

  LoginCubit({required this.service}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final response = await service.login(email, password);

      if (response['success'] == true || response['status'] == 'success') {
        emit(LoginSuccess(email));
      } else {
        emit(LoginFailure(response['message'] ?? 'Login failed'));
      }
    } catch (e) {
      emit(LoginFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
