
import '../models/password_reset.dart';
import '../services/reset_password.dart';


class PasswordResetRepository {
  final ResetService _passwordresetnService;
  final int id;
  PasswordResetRepository(this._passwordresetnService, this.id);

  Future<Map<String, dynamic>> reset(PasswordResetData passwordData) async {
    return await _passwordresetnService.reset(passwordData, id);
  }
}
