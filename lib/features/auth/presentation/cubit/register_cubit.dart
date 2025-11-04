import 'package:deal_wise/features/auth/data/api_service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final bool hasToken;
  final String email;
  RegisterSuccess({required this.hasToken, required this.email});
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

class RegisterCubit extends Cubit<RegisterState> {
  final ApiService apiService;

  RegisterCubit(this.apiService) : super(RegisterInitial());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final response = await apiService.registerUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      bool hasToken = false;
      if (response.containsKey('accessToken')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', response['accessToken']);
        await prefs.setString('refreshToken', response['refreshToken'] ?? '');
        await prefs.setString('expiresAtUtc', response['expiresAtUtc'] ?? '');
        hasToken = true;
        // Save user info (from response if present, else from inputs)
        await prefs.setString('userEmail', (response['email'] ?? email).toString());
        await prefs.setString('userFirstName', (response['firstName'] ?? firstName).toString());
        await prefs.setString('userLastName', (response['lastName'] ?? lastName).toString());
      }

      // If no token yet, still persist provided registration details for UI personalization
      if (!hasToken) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', email);
        await prefs.setString('userFirstName', firstName);
        await prefs.setString('userLastName', lastName);
      }

      emit(RegisterSuccess(hasToken: hasToken, email: email));
    } catch (e) {
      emit(RegisterError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
