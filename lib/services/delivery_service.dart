import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yecard/services/user_preference.dart';

import '../models/delivery_zone.dart';

class DeliveryService {
  // final String _baseUrl = 'https://yecard.pro';
  final String _baseUrl = 'http://192.168.1.37:8000';

  Future<Map<String, dynamic>> addDelivery(DeliveryZone deliveryData) async {
    print("DATA ${deliveryData.toJson()}");
    try {
      print("Appel de l'API : $_baseUrl/api/v0/order/");

      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }
      final response = await http.post(
        Uri.parse('$_baseUrl/api/v0/order/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(deliveryData.toJson()),
      );

      // Log le statut de la réponse
      print("Statut de la réponse : ${response.statusCode}");

      if (response.statusCode == 201) {
        print("Réponse réussie : ${response.body}");
        final responseBody = jsonDecode(response.body);

        return {
          'success': true,
          'message': 'Commande effectué',
        };
      } else  {
        print("Échec  : ${response.body}");
        final responseBody = jsonDecode(response.body);

        // return {
        //   'success': false,
        //   'errors': responseBody?? {'error': ['Erreur inconnue']},
        // };

        return {
          'success': false,
          'errors': (responseBody as Map<dynamic, dynamic>)?.map(
                (key, value) => MapEntry(
              key.toString(),
              List<String>.from(value),
            ),
          ) ?? {'error': ['Erreur inconnue']},
        };
      }
    } catch (e) {
      // Log l'erreur en cas d'échec de l'appel API
      print("Erreur lors de l'appel API : $e");
      throw Exception('Erreur lors de l\'appel API');
    }
  }

}
