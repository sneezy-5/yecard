import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final int currentStep;
  final bool hasCard;
  final bool condition;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final Map<String, List<String>> errorMessages;

  const SignupState({
    this.currentStep = 1,
    this.hasCard = false,
    this.condition = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.errorMessages = const {},
  });

  SignupState copyWith({
    int? currentStep,
    bool? hasCard,
    bool? condition,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Map<String, List<String>>? errorMessages,
  }) {
    return SignupState(
      currentStep: currentStep ?? this.currentStep,
      hasCard: hasCard ?? this.hasCard,
      condition: condition ?? this.condition,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      errorMessages: errorMessages ?? this.errorMessages,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    hasCard,
    condition,
    isLoading,
    isSuccess,
    errorMessage,
    errorMessages,
  ];
}

