import '../models/delivery_zone.dart';
import '../services/delivery_service.dart';

class DeliveryRepository {
  final DeliveryService _deliveryService;

  DeliveryRepository(this._deliveryService);

  Future<Map<String, dynamic>> addDelivery(DeliveryZone deliveryData) async {
    return await _deliveryService.addDelivery(deliveryData);
  }
}
