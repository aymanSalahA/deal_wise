import 'package:deal_wise/features/auth/data/api_service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService service;

  LoginCubit({required this.service}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final response = await service.login(email, password);

      // Check if the response contains accessToken which indicates success
      if (response.containsKey('accessToken')) {
        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', response['accessToken']);
        await prefs.setString('refreshToken', response['refreshToken'] ?? '');
        await prefs.setString('expiresAtUtc', response['expiresAtUtc'] ?? '');
        // Save user info if available
        final String userEmail = (response['email'] ?? email).toString();
        final String userFirstName = (response['firstName'] ?? '').toString();
        final String userLastName = (response['lastName'] ?? '').toString();
        await prefs.setString('userEmail', userEmail);
        await prefs.setString('userFirstName', userFirstName);
        await prefs.setString('userLastName', userLastName);
        
        emit(LoginSuccess(email));
      } else {
        emit(LoginFailure(response['message'] ?? 'Login failed'));
      }
    } catch (e) {
      emit(LoginFailure('An unexpected error occurred: ${e.toString()}'));
    }
  } //FIX
}
