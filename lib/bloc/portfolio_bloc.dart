import 'package:bloc/bloc.dart';
import '../repositories/portfolio_repository.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final PortfolioRepository portfolioRepository;

  PortfolioBloc(this.portfolioRepository) : super(PortfolioInitial()) {
    on<CreatePortfolio>(_onCreatePortfolio);
  }

  Future<void> _onCreatePortfolio(
      CreatePortfolio event, Emitter<PortfolioState> emit) async {
    // emit(PortfolioLoading());
    print("Début de la soumission du formulaire");

    emit(state.copyWith(isLoading: true));
    try {

      final result = await portfolioRepository.createPortfolio(
        event.portfolioData,
        event.file1,
         event.file2,
         event.file3);

      if (result['success']) {
        // emit(PortfolioCreated(portfolioData: portfolio));
        emit(state.copyWith(isLoading: false, isSuccess: true,errorMessage:"",errorMessages:{}));

      } else {
        print("Réponse de l'API : $result");

        emit(state.copyWith(
          isLoading: false,
          errorMessages: result['errors'] ?? {},
        ));
      }
    } catch (e) {
      emit(PortfolioError('Erreur: $e'));
    }
  }

}
