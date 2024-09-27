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
    print("Début de la soumission du formulaire");

    emit(state.copyWith(isLoading: true));

    try {

      if (event.passwordResetData.newpassword != event.passwordResetData.confirmPassword) {
         emit(state.copyWith(errorMessage: 'Les mots de passe ne correspondent pas.', isLoading: false));
      } else if (event.passwordResetData.newpassword.isEmpty || event.passwordResetData.confirmPassword.isEmpty) {
         emit(state.copyWith(errorMessage: 'Veuillez entrer un mot de passe.',isLoading: false));
      }else {
        final result = await _resetRepository.reset(event.passwordResetData);

        if (result['success']) {
          print("HERE.... ");
          emit(state.copyWith(isLoading: false, isSuccess: true,errorMessage:"",errorMessages:{}));
        } else {
          print("Réponse de l'API : $result");

          emit(state.copyWith(
            isLoading: false,
            errorMessages: result['errors'] ?? {},
              errorMessage: result['errors']
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
