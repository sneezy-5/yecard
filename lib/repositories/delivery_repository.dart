import '../models/delivery_zone.dart';
import '../services/delivery_service.dart';

class DeliveryRepository {
  final DeliveryService deliveryService;

  DeliveryRepository({required this.deliveryService});

  Future<List<DeliveryZone>> getDeliveryZones() {
    return deliveryService.fetchDeliveryZones();
  }
}
