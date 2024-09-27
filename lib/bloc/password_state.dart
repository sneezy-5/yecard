import 'package:equatable/equatable.dart';

class PasswordState extends Equatable {
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? errorMessage;
  final bool isLoading;
  final bool isSuccess;
  final Map<String, List<String>> errorMessages;

  const PasswordState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.errorMessages = const {},

  });

  PasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? errorMessage,
    Map<String, List<String>>? errorMessages,

  }) {
    return PasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      errorMessages: errorMessages ?? this.errorMessages,

    );
  }

  @override
  List<Object?> get props => [obscurePassword, obscureConfirmPassword,isSuccess,isLoading, errorMessage, errorMessages];
}
