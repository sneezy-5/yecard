import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yecard/services/user_preference.dart';
import '../models/portfolio.dart';

class PortfolioService {
  final String _baseUrl = 'https://yecard.pro';
  // final String _baseUrl = 'http://192.168.153.199:8000';

  Future<Map<String, dynamic>> getPortfolio() async {
    try {
      String? token = await UserPreferences.getUserToken();
      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/portfolio/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print("Statut de la réponse GET portfolio : ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
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
        return _handleErrorResponse(response);
      }
    } catch (e) {
      print("Erreur lors de l'appel GET : $e");
      return {
        'success': false,
        'error': 'Erreur lors de l\'appel API : $e',
      };
    }
  }

  Future<Map<String, dynamic>> getPortfolioById(int id) async {
    try {
      String? token = await UserPreferences.getUserToken();
      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/portfolio/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print("Statut de la réponse GET portfolio : ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        print("datass : ${responseBody}");
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
        return _handleErrorResponse(response);
      }
    } catch (e) {
      print("Erreur lors de l'appel GET : $e");
      return {
        'success': false,
        'error': 'Erreur lors de l\'appel API : $e',
      };
    }
  }

  Future<Map<String, dynamic>> getContactPortfolio(int id) async {
    try {
      String? token = await UserPreferences.getUserToken();
      if (token == null) {
        throw Exception("Token non disponible");
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v0/portfolios/list/?p=$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print("Statut de la réponse GET portfolio : ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        return {
          'success': true,
          'data': responseBody,
        };
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'error': "Accès non autorisé. Veuillez vous reconnecter.",
        };
      }else if (response.statusCode == 413) {
        return {
          'success': false,
          'error': "Votre fichier est trop lourd.",
        };
      }
      else {
        return _handleErrorResponse(response);
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
      request.headers['Content-Type'] = 'multipart/form-data; charset=UTF-8';

      request.fields.addAll({
        'title': createData.title,
        'description': createData.description,
        'mot_de_fin': createData.mot_de_fin,
      });

      if (file1 != null) {
        request.files.add(await http.MultipartFile.fromPath('file_url1', file1.path));
      }
      if (file2 != null) {
        request.files.add(await http.MultipartFile.fromPath('file_url2', file2.path));
      }
      if (file3 != null) {
        request.files.add(await http.MultipartFile.fromPath('file_url3', file3.path));
      }

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        print("Portfolio créé avec succès");
        return {
          'success': true,
          'data': 'Portfolio créé avec succès',
          'message': 'Portfolio créé avec succès',
        };
      } else {
        return _handleResponseErrors(response.statusCode, responseBody);
      }
    } catch (e) {
      print("Erreur lors de l'appel POST : $e");
      return {
        'success': false,
        'error': 'Erreur lors de l\'appel API : $e',
      };
    }
  }

  Future<Map<String, dynamic>> updatePortfolio(PortfolioData updateData, int id, File? file1, File? file2, File? file3) async {
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
      request.headers['Content-Type'] = 'multipart/form-data; charset=UTF-8';

      request.fields.addAll({
        'title': updateData.title,
        'description': updateData.description,
        'mot_de_fin': updateData.mot_de_fin,
      });

      if (file1 != null) {
        request.files.add(await http.MultipartFile.fromPath('file_url1', file1.path));
      }
      if (file2 != null) {
        request.files.add(await http.MultipartFile.fromPath('file_url2', file2.path));
      }
      if (file3 != null) {
        request.files.add(await http.MultipartFile.fromPath('file_url3', file3.path));
      }

      print("FILE $file1");
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': 'Portfolio mis à jour avec succès',
          'message': 'Portfolio mis à jour avec succès',
        };
      } else {
        return _handleResponseErrors(response.statusCode, responseBody);
      }
    } catch (e) {
      print("Erreur lors de l'appel PATCH : $e");
      return {
        'success': false,
        'error': 'Erreur lors de l\'appel API : $e',
      };
    }
  }

  Future<Map<String, dynamic>> deletePortfolio(int id) async {
    try {
      String? token = await UserPreferences.getUserToken();
      if (token == null) {
        throw Exception("Token non disponible");
      }

      final url = Uri.parse('$_baseUrl/api/v0/portfolio/$id/');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        print("STATUS ${response.statusCode}");
        return {
          'success': true,
          'data': 'Portfolio supprimé avec succès',
          'message': 'Portfolio supprimé avec succès',
        };
      } else {
        print("STATUSERROR ${response.body}");
        return _handleResponseErrors(response.statusCode, response.body);
      }
    } catch (e) {
      print("Erreur lors de l'appel DELETE : $e");
      return {
        'success': false,
        'error': 'Erreur lors de l\'appel API : $e',
      };
    }
  }
  // Utility to handle error responses
  Map<String, dynamic> _handleErrorResponse(http.Response response) {
    try {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      return {
        'success': false,
        'errors': responseBody is Map
            ? responseBody.map((key, value) => MapEntry(key.toString(), List<String>.from(value)))
            : {'error': ['Erreur inconnue']},
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Erreur lors de l\'analyse de la réponse : $e',
      };
    }
  }

  // Utility to handle specific response codes
  Map<String, dynamic> _handleResponseErrors(int statusCode, String responseBody) {
    if (statusCode == 400) {
      print("Erreur 400 : $responseBody");
      return {
        'success': false,
        'errors': jsonDecode(utf8.decode(responseBody.codeUnits)),
      };
    } else if (statusCode == 403) {
      return {
        'success': false,
        'error': 'Le fichier est trop lourd ou accès interdit',
      };
    } else if (statusCode == 401) {
      return {
        'success': false,
        'error': "Accès non autorisé. Veuillez vous reconnecter.",
      };
    } else {
      return {
        'success': false,
        'error': 'Erreur inconnue. Statut: $statusCode',
      };
    }
  }
}
