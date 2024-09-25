import 'package:equatable/equatable.dart';

class PasswordState extends Equatable {
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool isPasswordCreated;
  final String errorMessage;

  const PasswordState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.isPasswordCreated = false,
    this.errorMessage = '',
  });

  PasswordState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? isPasswordCreated,
    String? errorMessage,
  }) {
    return PasswordState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      isPasswordCreated: isPasswordCreated ?? this.isPasswordCreated,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [obscurePassword, obscureConfirmPassword, isPasswordCreated, errorMessage];
}
