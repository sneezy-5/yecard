import 'package:equatable/equatable.dart';

import '../models/password_reset.dart';

abstract class PasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Événement pour basculer la visibilité du mot de passe
class TogglePasswordVisibility extends PasswordEvent {}

// Événement pour basculer la visibilité de la confirmation du mot de passe
class ToggleConfirmPasswordVisibility extends PasswordEvent {}


class SubmitResetPassword extends PasswordEvent {
  final PasswordResetData passwordResetData;

  SubmitResetPassword(this.passwordResetData);

  @override
  List<Object> get props => [passwordResetData];
}