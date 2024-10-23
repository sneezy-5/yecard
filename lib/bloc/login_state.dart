

import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final Map<String, List<String>> errorMessages;

  const LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = "",
    this.errorMessages = const {},
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Map<String, List<String>>? errorMessages,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      errorMessages: errorMessages ?? this.errorMessages,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    errorMessage,
    errorMessages,
  ];
}

