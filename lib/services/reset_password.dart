
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/password_reset.dart';

class ResetService {
  final String _baseUrl = 'https://yecard.pro';
  // final String _baseUrl = 'http://192.168.1.37:8000';

  Future<Map<String, dynamic>> reset(PasswordResetData passwordResetData, int id) async {
    print("DATA ${passwordResetData.toJson()}");
    try {
      print("Appel de l'API : $_baseUrl/api/v0/change-password/");

      final response = await http.put(
        Uri.parse('$_baseUrl/api/v0/change-password/${id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(passwordResetData.toJson()),
      );

      // Log le statut de la réponse
      print("Statut de la réponse : ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Réponse réussie : ${response.body}");
        final responseBody = jsonDecode(response.body);

        return {
          'success': true,
          'message': "reset sucess",
        };
      } else {
        print("Échec de reset : ${response.body}");
        final responseBody = jsonDecode(response.body);

        return {
          'success': false,
          'errors': (responseBody['data'] as Map<dynamic, dynamic>)?.map(
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
