import 'package:equatable/equatable.dart';

class DeliveryState extends Equatable {
  final String selectedZone;
  final List<String> zones;
  final String cardNumber;
  final String phoneNumber;
  final bool isLoading;
  final String errorMessage;

  DeliveryState({
    this.selectedZone = '',
    this.zones = const [],
    this.cardNumber = '',
    this.phoneNumber = '',
    this.isLoading = false,
    this.errorMessage = '',
  });

  DeliveryState copyWith({
    String? selectedZone,
    List<String>? zones,
    String? cardNumber,
    String? phoneNumber,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DeliveryState(
      selectedZone: selectedZone ?? this.selectedZone,
      zones: zones ?? this.zones,
      cardNumber: cardNumber ?? this.cardNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [selectedZone, zones, cardNumber, phoneNumber, isLoading, errorMessage];
}
