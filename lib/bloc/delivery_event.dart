import 'package:equatable/equatable.dart';
import '../models/delivery_zone.dart';

abstract class DeliveryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeliveryZoneChanged extends DeliveryEvent {
  final DeliveryZone deliveryZone;

  DeliveryZoneChanged(this.deliveryZone);

  @override
  List<Object?> get props => [deliveryZone];
}



class FetchZones extends DeliveryEvent {}
