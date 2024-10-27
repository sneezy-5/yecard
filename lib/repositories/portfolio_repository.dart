import 'dart:io';

import '../models/portfolio.dart';
import '../services/portfolio_service.dart';


class PortfolioRepository {
  final PortfolioService _portfolioService;

  PortfolioRepository(this._portfolioService);

  Future<Map<String, dynamic>>portfolio () async {
    return await _portfolioService.getPortfolio();
  }
  Future<Map<String, dynamic>>getContactPortfolio (int id) async {
    return await _portfolioService.getContactPortfolio(id);
  }
  Future<Map<String, dynamic>>createPortfolio (PortfolioData createData, File? file1, File? file2, File? file3) async {
    return await _portfolioService.createPortfolio(createData, file1, file2, file3 );
  }
  Future<Map<String, dynamic>>updatePortfolio (PortfolioData portfolioData, int id,File? file1, File? file2, File? file3) async {
    return await _portfolioService.updatePortfolio(portfolioData, id, file1, file2, file3);
  }
}
