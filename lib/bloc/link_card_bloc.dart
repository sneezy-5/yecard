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

  // Future<void> _onFetchCard(FetchCard event, Emitter<LinkCardState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   emit(CardLoading());
  //   try {
  //     final response = await _cardRepository.getCard();
  //     if (response['success']) {
  //       print("PROFILE ${response['data']}");
  //       final cardData = CardData.fromJson(response['data']);
  //       emit(state.copyWith(isLoading: false,));
  //       emit(CardLoaded(cardData: cardData));
  //     } else {
  //       emit(state.copyWith(isLoading: false, error: response['error']));
  //       // emit(ProfileError(message: "Failed to load profile"));
  //
  //     }
  //   } catch (e) {
  //     print("PROFILE ${e}");
  //     emit(state.copyWith(isLoading: false, error: 'Erreur lors du chargement du profil'));
  //   }
  // }

  // Soumission du numéro de carte (avec gestion du chargement et des erreurs)
  Future<void> _onSubmitCard(SubmitCard event, Emitter<LinkCardState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

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
