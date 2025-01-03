import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/delivery_repository.dart';
import 'delivery_event.dart';
import 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final DeliveryRepository _deliveryRepository;

  DeliveryBloc(this._deliveryRepository) : super(DeliveryState()) {
    on<DeliveryZoneChanged>(_onSubmitSignup);
  }

  void _onSubmitSignup(DeliveryZoneChanged event, Emitter<DeliveryState> emit) async {
    print("Début de la soumission du formulaire");

    emit(state.copyWith(isLoading: true,errorMessage:null,errorMessages:{}));

    try {
      final result = await _deliveryRepository.addDelivery(event.deliveryZone);
      if (result['success']) {
        emit(state.copyWith(isLoading: false, isSuccess: true,errorMessage:"",errorMessages:{}));
      } else {
        print("Réponse de l'API : $result");

        emit(state.copyWith(
          isLoading: false,
          errorMessages: result['errors'] ?? {},
        ));
      }
    } catch (e) {
      print("Erreur capturée lors de l'appel API : $e");

      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Une erreur s\'est produite. Veuillez réessayer.',
      ));
    }
  }


}
