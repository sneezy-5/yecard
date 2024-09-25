import 'package:flutter_bloc/flutter_bloc.dart';
import 'password_event.dart';
import 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordState());

  @override
  Stream<PasswordState> mapEventToState(PasswordEvent event) async* {
    if (event is TogglePasswordVisibility) {
      yield state.copyWith(obscurePassword: !state.obscurePassword);
    } else if (event is ToggleConfirmPasswordVisibility) {
      yield state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);
    } else if (event is CreatePassword) {
      if (event.password != event.confirmPassword) {
        yield state.copyWith(errorMessage: 'Les mots de passe ne correspondent pas.');
      } else if (event.password.isEmpty || event.confirmPassword.isEmpty) {
        yield state.copyWith(errorMessage: 'Veuillez entrer un mot de passe.');
      } else {
        yield state.copyWith(isPasswordCreated: true, errorMessage: '');
      }
    }
  }
}
