import '../models/signup_model.dart';
import '../services/signup_service.dart';

class SignupRepository {
  final SignupService _signupService;

  SignupRepository(this._signupService);

  Future<Map<String, dynamic>> signup(SignupData signupData) async {
    return await _signupService.signup(signupData);
  }
}
