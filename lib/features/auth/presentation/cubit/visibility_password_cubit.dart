import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit for New Password visibility
class NewPasswordVisibilityCubit extends Cubit<bool> {
  NewPasswordVisibilityCubit() : super(true); // true = obscured

  void toggleVisibility() {
    emit(!state);
  }
}

// Cubit for Confirm Password visibility
class ConfirmPasswordVisibilityCubit extends Cubit<bool> {
  ConfirmPasswordVisibilityCubit() : super(true); // true = obscured

  void toggleVisibility() {
    emit(!state);
  }
}
