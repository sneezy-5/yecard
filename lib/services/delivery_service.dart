import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/delivery_zone.dart';

class DeliveryService {
  final String apiUrl = 'https://example.com/api/delivery/zones';

  Future<List<DeliveryZone>> fetchDeliveryZones() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((zone) => DeliveryZone.fromJson(zone)).toList();
    } else {
      throw Exception('Failed to load delivery zones');
    }
  }
}
