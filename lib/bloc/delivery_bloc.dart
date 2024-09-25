import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/delivery_repository.dart';
import 'delivery_event.dart';
import 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final DeliveryRepository deliveryRepository;

  DeliveryBloc(this.deliveryRepository) : super(DeliveryState()) {
    on<FetchZones>(_onFetchZones);
    on<ZoneChanged>(_onZoneChanged);
  }

  void _onFetchZones(FetchZones event, Emitter<DeliveryState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final zones = await deliveryRepository.getDeliveryZones();
      emit(state.copyWith(
        isLoading: false,
        zones: zones.map((zone) => zone.name).toList(),
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Failed to load zones'));
    }
  }

  void _onZoneChanged(ZoneChanged event, Emitter<DeliveryState> emit) {
    emit(state.copyWith(selectedZone: event.selectedZone));
  }
}
