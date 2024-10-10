import 'package:equatable/equatable.dart';

class LinkCardState extends Equatable {
  final String cardNumber;
  final bool isValid;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final Map<String, List<String>> errorMessages;

  const LinkCardState({
    this.cardNumber = '',
    this.isValid = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.errorMessages = const {},
  });

  // Méthode copyWith pour créer un nouvel état tout en modifiant seulement les champs souhaités
  LinkCardState copyWith({
    String? cardNumber,
    bool? isValid,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Map<String, List<String>>? errorMessages,
  }) {
    return LinkCardState(
      cardNumber: cardNumber ?? this.cardNumber,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      errorMessages: errorMessages ?? this.errorMessages,
    );
  }

  @override
  List<Object?> get props => [
    cardNumber,
    isValid,
    isLoading,
    isSuccess,
    errorMessage,
    errorMessages,
  ];
}
