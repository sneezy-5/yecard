import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yecard/models/profile_model.dart';
import 'package:yecard/services/user_preference.dart';

class PortfolioService {
  final String _baseUrl = 'https://yecard.pro';

  // Méthode pour récupérer le profil avec un appel GET
  Future<Map<String, dynamic>> getPortfolio() async {
    try {
      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/portfolio/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Statut de la réponse GET : ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("data : ${responseBody["results"][0]}");
        return {
          'success': true,
          'data': responseBody["results"][0],
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

  // Méthode pour mettre à jour le profil avec un appel PATCH
  Future<Map<String, dynamic>> updatePortfolio(ProfileData updateData, int id) async {
    try {
      String? token = await UserPreferences.getUserToken();
      print('$_baseUrl/api/v0/portfolio/${id}/');
      if (token == null) {
        throw Exception("Token non disponible");
      }
      print("DATA : ${updateData}");
      final response = await http.patch(
        Uri.parse('$_baseUrl/api/v0/users/${id}/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updateData),
      );

      print("Statut de la réponse PATCH : ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseBody,
          'message': 'Profil mis à jour avec succès',
        };
      } else if (response.statusCode == 400) {
        final responseBody = jsonDecode(response.body);
        print("Statut de la réponse PATCH : ${responseBody}");
        return {
          'success': false,
          'errors': (responseBody as Map<dynamic, dynamic>)?.map(
                (key, value) => MapEntry(
              key.toString(),
              List<String>.from(value),
            ),
          ) ?? {'error': ['Erreur inconnue']},
        };
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'error': "Accès non autorisé. Veuillez vous reconnecter.",
        };
      } else {
        return {
          'success': false,
          'error': 'Erreur inconnue. Statut: ${response.statusCode}',
        };
      }
    } catch (e) {
      print("Erreur lors de l'appel PATCH : $e");
      return {
        'success': false,
        'error': 'Erreur lors de l\'appel API : $e',
      };
    }
  }
}