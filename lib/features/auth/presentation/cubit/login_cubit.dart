import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deal_wise/features/auth/data/models/auth_view_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthViewModel authVM;

  LoginCubit({required this.authVM}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final bool success = await authVM.login(email, password);

      if (success) {
        emit(LoginSuccess(email));
      } else {
        emit(
          LoginFailure(
            authVM.errorMessage ?? 'Login failed. Check server connection.',
          ),
        );
      }
    } catch (e) {
      emit(LoginFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
