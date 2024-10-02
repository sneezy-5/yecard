import '../models/profile_model.dart';
import '../services/portfolio_service.dart';


class PortfolioRepository {
  final PortfolioService _portfolioService;

  PortfolioRepository(this._portfolioService);

  Future<Map<String, dynamic>>portfolio () async {
    return await _portfolioService.getPortfolio();
  }

  Future<Map<String, dynamic>>updateProfile (ProfileData profileData, int id) async {
    return await _portfolioService.updatePortfolio(profileData, id);
  }
}
