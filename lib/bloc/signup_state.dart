//
// // import 'package:equatable/equatable.dart';
// //
// // class SignupState extends Equatable {
// //   final int currentStep;
// //   final bool hasCard;
// //   final bool isLoading;
// //   final bool isSuccess;
// //   final String? errorMessage;
// //   final Map<String, List<String>> errorMessages;
// //
// //   const SignupState({
// //     this.currentStep = 1,
// //     this.hasCard = false,
// //     this.isLoading = false,
// //     this.isSuccess = false,
// //     this.errorMessage,
// //     this.errorMessages = const {},
// //
// //   });
// //
// //   SignupState copyWith({
// //     int? currentStep,
// //     bool? hasCard,
// //     bool? isLoading,
// //     bool? isSuccess,
// //     String? errorMessage,
// //     Map<String, List<String>>? errorMessages,
// //
// //   }) {
// //     return SignupState(
// //       currentStep: currentStep ?? this.currentStep,
// //       hasCard: hasCard ?? this.hasCard,
// //       isLoading: isLoading ?? this.isLoading,
// //       isSuccess: isSuccess ?? this.isSuccess,
// //       errorMessage: errorMessage ?? this.errorMessage,
// //     );
// //   }
// //
// //   @override
// //   List<Object> get props => [currentStep, hasCard, isLoading, isSuccess, errorMessage ?? ''];
// // }
// import 'package:equatable/equatable.dart';
//
// class SignupState extends Equatable {
//   final int currentStep;
//   final bool hasCard;
//   final bool isLoading;
//   final bool isSuccess;
//   final String? errorMessage;
//   final Map<String, List<String>> errorMessages;
//
//   const SignupState({
//     this.currentStep = 1,
//     this.hasCard = false,
//     this.isLoading = false,
//     this.isSuccess = false,
//     this.errorMessage,
//     this.errorMessages = const {},
//   });
//
//   SignupState copyWith({
//     int? currentStep,
//     bool? hasCard,
//     bool? isLoading,
//     bool? isSuccess,
//     String? errorMessage,
//     Map<String, List<String>>? errorMessages,
//   }) {
//     return SignupState(
//       currentStep: currentStep ?? this.currentStep,
//       hasCard: hasCard ?? this.hasCard,
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       errorMessage: errorMessage ?? this.errorMessage,
//       errorMessages: errorMessages ?? this.errorMessages, // Ensure error messages are copied
//     );
//   }
//
//   @override
//   List<Object> get props => [
//     currentStep,
//     hasCard,
//     isLoading,
//     isSuccess,
//     errorMessage ?? '',
//     errorMessages
//   ];
// }

import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final int currentStep;
  final bool hasCard;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final Map<String, List<String>> errorMessages;

  const SignupState({
    this.currentStep = 1,
    this.hasCard = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.errorMessages = const {},
  });

  SignupState copyWith({
    int? currentStep,
    bool? hasCard,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Map<String, List<String>>? errorMessages,
  }) {
    return SignupState(
      currentStep: currentStep ?? this.currentStep,
      hasCard: hasCard ?? this.hasCard,
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
    isLoading,
    isSuccess,
    errorMessage,
    errorMessages,
  ];
}

