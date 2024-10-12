import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yecard/services/user_preference.dart';

import '../models/card_model.dart';

class CardService {
  final String _baseUrl = 'https://yecard.pro';
  // final String _baseUrl = 'http://192.168.152.200:8000';

  Future<Map<String, dynamic>> getCard() async {
    try {
      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/card/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Statut de la réponse GET card : ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("data : ${responseBody["results"]}");
        return {
          'success': true,
          'data': responseBody["results"],
        };
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'error': "Accès non autorisé. Veuillez vous reconnecter.",
        };
      } else {
        final responseBody = jsonDecode(response.body);
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
      print("Erreur lors de l'appel GET : $e");
      return {
        'success': false,
        'error': 'Erreur lors de l\'appel API : $e',
      };
    }
  }

  Future<Map<String, dynamic>> addCard(CardData cardData) async {
    print("DATA ${cardData.toJson()}");
    try {
      print("Appel de l'API : $_baseUrl/api/v0/card/");

      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/api/v0/card/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(cardData.toJson()),
      );

      // Log le statut de la réponse
      print("Statut de la réponse : ${response.statusCode}");

      if (response.statusCode == 201) {
        print("Réponse réussie : ${response.body}");
        final responseBody = jsonDecode(response.body);

        return {
          'success': true,
          'message': 'Enregistrer avec success',
        };
      } else  {
        print("Échec  : ${response.body}");
        final responseBody = jsonDecode(response.body);

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
