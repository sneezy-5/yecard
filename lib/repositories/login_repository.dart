
import '../models/login_model.dart';
import '../services/login_service.dart';

class LoginRepository {
  final LoginService _loginService;

  LoginRepository(this._loginService);

  Future<Map<String, dynamic>> login(LoginModelData loginData) async {
    return await _loginService.login(loginData);
  }
}
