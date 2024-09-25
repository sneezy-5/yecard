import 'package:equatable/equatable.dart';

abstract class DeliveryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// class ZoneChanged extends DeliveryEvent {
//   final String zone;
//
//   ZoneChanged(this.zone);
//
//   @override
//   List<Object?> get props => [zone];
// }
class ZoneChanged extends DeliveryEvent {
  final String selectedZone;
  ZoneChanged(this.selectedZone);
}


class ReferenceChanged extends DeliveryEvent {
  final String reference;

  ReferenceChanged(this.reference);

  @override
  List<Object?> get props => [reference];
}

class CardNumberChanged extends DeliveryEvent {
  final String cardNumber;

  CardNumberChanged(this.cardNumber);

  @override
  List<Object?> get props => [cardNumber];
}

class PhoneNumberChanged extends DeliveryEvent {
  final String phoneNumber;

  PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}
class FetchZones extends DeliveryEvent {}