import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yecard/models/profile_model.dart';
import 'package:yecard/services/user_preference.dart';

class ProfileService {
  // final String _baseUrl = 'https://yecard.pro';
  final String _baseUrl = 'http://192.168.1.18:8000';

  // Méthode pour récupérer le profil avec un appel GET
  Future<Map<String, dynamic>> getProfile() async {
    try {
      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/account/profile/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print("Statut de la réponse GET profile : ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes)); // Handle UTF-8 encoding
        print("data : ${responseBody["results"][0]}");
        return {
          'success': true,
          'data': responseBody["results"][0],
        };
      } else if (response.statusCode == 401) {
        await UserPreferences.clearUserToken();
        // Navigator.pushReplacementNamed(Router.navigatorKey.currentContext!, '/auth/login');

        return {
          'success': false,
          'error': "Accès non autorisé. Veuillez vous reconnecter.",
        };
      } else {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes)); // Handle UTF-8 encoding
        return {
          'success': false,
          'errors': (responseBody as Map<dynamic, dynamic>).map(
                (key, value) => MapEntry(
              key.toString(),
              List<String>.from(value),
            ),
          ),
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

  Future<Map<String, dynamic>> getContactProfile(String id) async {
    try {
      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/users/?p=${id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8', // Ensure UTF-8 encoding
          'Authorization': 'Bearer $token',
        },
      );

      print("Statut de la réponse GET contact Contact profile : ${_baseUrl}/api/v0/users/?p=${id}/");

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

  Future<Map<String, dynamic>> getContact(int id) async {
    try {
      String? token = await UserPreferences.getUserToken();

      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/users/${id}/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8', // Ensure UTF-8 encoding
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes)); // Handle UTF-8 encoding
        print("data : ${responseBody}");
        return {
          'success': true,
          'data': responseBody,
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

  // Méthode pour mettre à jour le profil avec un appel PATCH
  Future<Map<String, dynamic>> updateProfile(ProfileData updateData, int id, File? picture, File? banier) async {
    try {
      String? token = await UserPreferences.getUserToken();
      print('$_baseUrl/api/v0/users/$id/');

      if (token == null) {
        throw Exception("Token non disponible");
      }

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('$_baseUrl/api/v0/users/$id/'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data; charset=UTF-8';

      // Add form data fields
      request.fields['name'] = updateData.name ?? '';
      request.fields['fonction'] = updateData.fonction ?? '';
      request.fields['entreprise'] = updateData.entreprise ?? '';
      request.fields['phone'] = updateData.phone ?? '';
      request.fields['biographie'] = updateData.biographie ?? '';
      request.fields['email'] = updateData.email ?? '';
      request.fields['localisation'] = updateData.localisation ?? '';
      request.fields['site_url'] = updateData.site_url ?? '';
      request.fields['facebok'] = updateData.facebook ?? '';
      request.fields['whatsapp'] = updateData.whatsapp ?? '';
      request.fields['linkedin'] = updateData.linkedin ?? '';

      print(updateData);

      // Add profile picture
      if (picture != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'picture',
            picture.path,
          ),
        );
      }

      // Add banner image
      if (banier != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'b_picture',
            banier.path,
          ),
        );
      }
      print("PATCH sdfef");

      var response = await request.send();
      print("PATCH STATUS: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return {
          'success': true,
          'data': jsonDecode(utf8.decode(responseBody.runes.toList())), // Handle UTF-8 encoding
          'message': 'Profil mis à jour avec succès',
        };
      } else if (response.statusCode == 400) {
        final responseBody = await response.stream.bytesToString();
        final json = jsonDecode(utf8.decode(responseBody.runes.toList())); // Handle UTF-8 encoding
        print("Statut de la réponse PATCH : ${responseBody}");

        return {
          'success': false,
          'errors': (json as Map<dynamic, dynamic>).map(
                (key, value) => MapEntry(
              key.toString(),
              List<String>.from(value),
            ),
          ),
        };
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'error': "Accès non autorisé. Veuillez vous reconnecter.",
        };
      } else {
        print("Statut de la réponse PATCH : ${response.statusCode}");

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
