import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Événement pour basculer la visibilité du mot de passe
class TogglePasswordVisibility extends PasswordEvent {}

// Événement pour basculer la visibilité de la confirmation du mot de passe
class ToggleConfirmPasswordVisibility extends PasswordEvent {}

// Événement pour valider et créer le mot de passe
class CreatePassword extends PasswordEvent {
  final String password;
  final String confirmPassword;

  CreatePassword(this.password, this.confirmPassword);

  @override
  List<Object> get props => [password, confirmPassword];
}
