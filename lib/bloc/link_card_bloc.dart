import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/card_model.dart';
import '../repositories/card_repository.dart';
import 'link_card_event.dart';
import 'link_card_state.dart';

class LinkCardBloc extends Bloc<LinkCardEvent, LinkCardState> {
  final CardRepository _cardRepository;

  LinkCardBloc(this._cardRepository) : super(const LinkCardState()) {
    on<SubmitCard>(_onSubmitCard);
    // on<SubmitCard>(_onFetchCard);
  }


  // Soumission du numéro de carte (avec gestion du chargement et des erreurs)
  Future<void> _onSubmitCard(SubmitCard event, Emitter<LinkCardState> emit) async {
    emit(state.copyWith(isLoading: true,errorMessage:null,errorMessages:{}));

    try {

      final result = await _cardRepository.addCard(event.cardData);

      if (result['success']) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        print(result['errors']["errors"]);
        emit(state.copyWith(
          isLoading: false,
          errorMessages: result['errors'] ?? {},
          errorMessage: result['error']?? "",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Une erreur s\'est produite. Veuillez réessayer.',
      ));
    }
  }
}
