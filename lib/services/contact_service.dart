import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yecard/services/user_preference.dart';

import '../models/contact_model.dart';

class ContactService {
  final String _baseUrl = 'https://yecard.pro';
  // final String _baseUrl = 'http://192.168.153.199:8000';

  Future<Map<String, dynamic>> getContactProfile(String id, String page) async {
    try {
      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/contact/?p=${id}offset=${page}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );


      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes)); // Handle UTF-8 encoding
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
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes)); // Handle UTF-8 encoding
        return {
          'success': false,
          'errors': "User dose not exist"
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

  Future<Map<String, dynamic>> getContacts({int page = 0, String? query}) async {
    try {
      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      // Build the URL with optional pagination and search query
      final uri = Uri.parse('$_baseUrl/api/v0/contacts/').replace(
        queryParameters: {
          'offset': page.toString(),
          if (query != null && query.isNotEmpty) 'search': query,
        },
      );
print("URI $uri");
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        print("Data: ${responseBody}");
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
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        return {
          'success': false,
          'error': responseBody["message"] ?? "Une erreur est survenue",
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
  Future<Map<String, dynamic>> addContact(ContactData contactData) async {
    print("DATA ${contactData.toJson()}");
    try {
      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/api/v0/contacts/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(contactData.toJson()),
      );

      // Log le statut de la réponse
      print("Statut de la réponse : ${response.statusCode}");

      if (response.statusCode == 201) {
        print("Réponse réussie : ${response.body}");
        final responseBody = jsonDecode(response.body);

        return {
          'success': true,
          'message': 'Ajout réussie',
        };
      } else {
        print("Échec de l'enregistrement : ${response.body}");
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
