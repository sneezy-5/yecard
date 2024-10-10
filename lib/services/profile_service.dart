import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yecard/models/profile_model.dart';
import 'package:yecard/services/user_preference.dart';

class ProfileService {
  // final String _baseUrl = 'https://yecard.pro';
  final String _baseUrl = 'http://192.168.1.37:8000';

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
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Statut de la réponse GET profile : ${response.statusCode}");

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
  Future<Map<String, dynamic>> updateProfile(ProfileData updateData, int id, File? picture, File? banier) async {
    try {
      String? token = await UserPreferences.getUserToken();
      print('$_baseUrl/api/v0/users/${id}/');
      if (token == null) {
        throw Exception("Token non disponible");
      }
      print("DATA : ${updateData}");

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('$_baseUrl/api/v0/users/${id}/'),
      );

      request.headers['Authorization'] = 'Bearer $token';


      request.fields['name'] = updateData.name;
      request.fields['fonction'] = updateData.fonction;
      request.fields['entreprise'] = updateData.entreprise;
      request.fields['phone'] = updateData.phone;
      request.fields['biographie'] = updateData.biographie;
      request.fields['email'] = updateData.email;
      request.fields['localisation'] = updateData.localisation;



      if (picture != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'picture',
            picture.path,
          ),
        );
      }
      if (banier != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'b_picture',
            banier.path,
          ),
        );
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return {
          'success': true,
          'data': responseBody,
          'message': 'Profil mis à jour avec succès',
        };
      } else if (response.statusCode == 400) {
        final responseBody = await response.stream.bytesToString();
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
