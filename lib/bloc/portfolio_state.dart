import 'package:equatable/equatable.dart';
import '../models/portfolio.dart'; // Import du modèle PortfolioData

 class PortfolioState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final Map<String, List<String>> errorMessages;

  const PortfolioState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.errorMessages = const {},
  }
      );

  PortfolioState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Map<String, List<String>>? errorMessages,
  }) {
    return PortfolioState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      errorMessages: errorMessages ?? this.errorMessages,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    errorMessage,
    errorMessages,
  ];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioCreated extends PortfolioState {
  final PortfolioData portfolioData;

  const PortfolioCreated({required this.portfolioData});

  @override
  List<Object> get props => [portfolioData];
}

class PortfoliosLoaded extends PortfolioState {
  final List<PortfolioData> portfolios;

  const PortfoliosLoaded({required this.portfolios});

  @override
  List<Object> get props => [portfolios];
}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object> get props => [message];
}
