import 'package:deal_wise/features/auth/data/api_service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

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
      await apiService.registerUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
