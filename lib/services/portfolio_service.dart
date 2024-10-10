import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yecard/models/profile_model.dart';
import 'package:yecard/services/user_preference.dart';

import '../models/portfolio.dart';

class PortfolioService {
  // final String _baseUrl = 'https://yecard.pro';
  final String _baseUrl = 'http://192.168.1.37:8000';


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

      print("Statut de la réponse GET portfolio : ${response.body}");

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


  Future<Map<String, dynamic>> createPortfolio(PortfolioData createData, File? file1, File? file2, File? file3) async {
    try {
      String? token = await UserPreferences.getUserToken();
      if (token == null) {
        throw Exception("Token non disponible");
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/api/v0/portfolio/'),
      );

      request.headers['Authorization'] = 'Bearer $token';


      request.fields['title'] = createData.title;
      request.fields['description'] = createData.description;
      request.fields['mot_de_fin'] = createData.mot_de_fin;
      print(file1?.path);

      if (file1 != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file_url1',
            file1.path,
          ),
        );
      }
      if (file2 != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file_url2',
            file2.path,
          ),
        );
      }
      if (file3 != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file_url3',
            file3.path,
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        print("Statut de la réponse post portfolio SCSA}");
        final responseBody = await response.stream.bytesToString();
        return {
          'success': true,
          'data': jsonDecode(responseBody),
          'message': 'Portfolio créé avec succès',
        };
      } else if (response.statusCode == 400) {


        final responseBody = await response.stream.bytesToString();
        print("Statut de la réponse post portfolio : FEFEF FEW ${responseBody}");
        return {
          'success': false,
          'errors': jsonDecode(responseBody),
        };
      }else if (response.statusCode == 403) {


        final responseBody = await response.stream.bytesToString();
        print("Statut de la réponse post portfolio : fwef${responseBody}");
        return {
          'success': false,
          'errors': 'le fichier est trop lourd',
        };
      }else if (response.statusCode == 400) {


        final responseBody = await response.stream.bytesToString();
        print("Statut de la réponse post portfolio : FEFEF FEW ${responseBody}");
        return {
          'success': false,
          'errors': jsonDecode(responseBody),
        };
      }
      else if (response.statusCode == 401) {
        return {
          'success': false,
          'error': "Accès non autorisé. Veuillez vous reconnecter.",
        };
      } else {
        final responseBody = await response.stream.bytesToString();

        print("Statut de la réponse post portfolio : FEFEF FEW ${responseBody}}");

        return {
          'success': false,
          'error': 'Erreur inconnue. Statut: ${response.statusCode}',
        };
      }
    } catch (e) {
      print("Erreur lors de l'appel POST : $e");
      return {
        'success': false,
        'error': 'Erreur lors de l\'appel API : $e',
      };
    }
  }


  Future<Map<String, dynamic>> updatePortfolio(PortfolioData updateData, int id, File? imageFile) async {
    try {
      String? token = await UserPreferences.getUserToken();
      if (token == null) {
        throw Exception("Token non disponible");
      }

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('$_baseUrl/api/v0/portfolio/$id/'),
      );

      request.headers['Authorization'] = 'Bearer $token';


      request.fields['title'] = updateData.title;
      request.fields['description'] = updateData.description;
      request.fields['mot_de_fin'] = updateData.mot_de_fin;


      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file_url1',
            imageFile.path,
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return {
          'success': true,
          'data': jsonDecode(responseBody),
          'message': 'Portfolio mis à jour avec succès',
        };
      } else if (response.statusCode == 400) {
        final responseBody = await response.stream.bytesToString();
        return {
          'success': false,
          'errors': jsonDecode(responseBody),
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
