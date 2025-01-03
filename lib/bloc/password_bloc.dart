import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/reset_password_repository.dart';
import 'password_event.dart';
import 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordResetRepository _resetRepository;

  PasswordBloc(this._resetRepository) : super(PasswordState()) {
    // Enregistrement des handlers d'événements
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
    on<SubmitResetPassword>(_onSubmitReset);
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<PasswordState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onToggleConfirmPasswordVisibility(
      ToggleConfirmPasswordVisibility event, Emitter<PasswordState> emit) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }


  void _onSubmitReset(
      SubmitResetPassword event, Emitter<PasswordState> emit) async {
    emit(state.copyWith(isLoading: true,errorMessage:null,errorMessages:{}));

    try {

      if (event.passwordResetData.newpassword != event.passwordResetData.confirmPassword) {
         emit(state.copyWith(errorMessage: 'Les mots de passe ne correspondent pas.', isLoading: false));
      } else if (event.passwordResetData.newpassword.isEmpty || event.passwordResetData.confirmPassword.isEmpty) {
         emit(state.copyWith(errorMessage: 'Veuillez entrer un mot de passe.',isLoading: false));
      }else {
        final result = await _resetRepository.reset(event.passwordResetData);
        emit(state.copyWith(errorMessage: null, errorMessages: {}));
        if (result['success']) {
          emit(state.copyWith(isLoading: false, isSuccess: true,errorMessage:"",errorMessages:{}));
        } else {
          emit(state.copyWith(
            isLoading: false,
            errorMessages: result['errors'] ?? {},
              errorMessage: result['errors']?? null
          ));
        }
      }
    } catch (e) {
      print("Erreur capturée lors de l'appel API : $e");

      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Une erreur s\'est produite. Veuillez réessayer.',
      ));
    }
  }
}
