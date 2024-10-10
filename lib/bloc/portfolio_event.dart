import 'package:equatable/equatable.dart';
import 'dart:io';
import '../models/portfolio.dart';

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => [];
}

// Événement pour créer un portfolio
class CreatePortfolio extends PortfolioEvent {
  final PortfolioData portfolioData;
  final File? file1;
  final File? file2;
  final File? file3;

  const CreatePortfolio({
    required this.portfolioData,
    required this.file1,
    required this.file2,
    required this.file3,
  });

  @override
  List<Object?> get props => [portfolioData, file1, file2, file3];
}
