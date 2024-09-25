// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../models/signup_model.dart';
//
// class SignupService {
//   final String _baseUrl = 'https://yecard.pro';
//
//   Future<Map<String, dynamic>> signup(SignupData signupData) async {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/api/v0/user/account/register/'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(signupData.toJson()),
//     );
//
//     if (response.statusCode == 200) {
//       // Si la réponse est un succès, on renvoie une map indiquant le succès
//       return {
//         'success': true,
//         'message': 'Inscription réussie',
//       };
//     } else {
//       // En cas d'erreurs, on extrait les messages d'erreur de la réponse
//       final responseBody = jsonDecode(response.body);
//       print("ERROR: ${responseBody}");
//       // On s'attend à ce que les erreurs soient sous forme de dictionnaire (par exemple : {'email': ['Email déjà utilisé']})
//       return {
//         'success': false,
//         'errors': responseBody['errors'] ?? {'error': ['Erreur inconnue']},
//       };
//     }
//   }
// }
//
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/signup_model.dart';

class SignupService {
  final String _baseUrl = 'https://yecard.pro';

  Future<Map<String, dynamic>> signup(SignupData signupData) async {
    try {
      print("Appel de l'API : $_baseUrl/api/v0/user/account/register/");

      final response = await http.post(
        Uri.parse('$_baseUrl/api/v0/user/account/register/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(signupData.toJson()),
      );

      // Log le statut de la réponse
      print("Statut de la réponse : ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Réponse réussie : ${response.body}");
        return {
          'success': true,
          'message': 'Inscription réussie',
        };
      } else {
        print("Échec de l'inscription : ${response.body}");
        final responseBody = jsonDecode(response.body);
        return {
          'success': false,
          'errors': responseBody['errors'] ?? {'error': ['Erreur inconnue']},
        };
      }
    } catch (e) {
      // Log l'erreur en cas d'échec de l'appel API
      print("Erreur lors de l'appel API : $e");
      throw Exception('Erreur lors de l\'appel API');
    }
  }
}
