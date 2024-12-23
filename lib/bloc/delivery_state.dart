import 'package:equatable/equatable.dart';

class DeliveryState extends Equatable {
  final String selectedZone;
  final List<String> zones;
  final String cardNumber;
  final String phoneNumber;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final Map<String, List<String>> errorMessages;

  DeliveryState({
    this.selectedZone = '',
    this.zones = const [],
    this.cardNumber = '',
    this.phoneNumber = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.errorMessages = const {},
  });

  DeliveryState copyWith({
    String? selectedZone,
    List<String>? zones,
    String? cardNumber,
    String? phoneNumber,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Map<String, List<String>>? errorMessages,
  }) {
    return DeliveryState(
      selectedZone: selectedZone ?? this.selectedZone,
      zones: zones ?? this.zones,
      cardNumber: cardNumber ?? this.cardNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      errorMessages: errorMessages ?? this.errorMessages,
    );
  }

  @override
  List<Object?> get props => [selectedZone, zones, cardNumber, phoneNumber, isLoading, errorMessage, errorMessages, isSuccess];
}
