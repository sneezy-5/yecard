
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yecard/services/user_preference.dart';
import '../models/login_model.dart';

class LoginService {
  // final String _baseUrl = 'https://yecard.pro';
  final String _baseUrl = 'http://192.168.1.37:8000';

  Future<Map<String, dynamic>> login(LoginModelData loginData) async {
    print("DATA ${loginData.toJson()}");
    try {
      print("Appel de l'API : $_baseUrl/api/v0/auth/login/");

      final response = await http.post(
        Uri.parse('$_baseUrl/api/v0/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginData.toJson()),
      );

      // Log le statut de la réponse
      print("Statut de la réponse : ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Réponse réussie : ${response.body}");
        final responseBody = jsonDecode(response.body);
        // Sauvegarde le token
        await UserPreferences.saveUserToken(responseBody["access"]);
        return {
          'success': true,
          'message': "login sucess",
        };
      }
      if (response.statusCode == 401) {
        print("Réponse réussie : ${response.body}");
        return {
          'success': false,
          'error': "No active account found with the given credentials",
        };
      }else {
        print("Échec de login : ${response.body}");
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
