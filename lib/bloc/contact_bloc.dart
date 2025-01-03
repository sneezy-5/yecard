import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/portfolio_repository.dart';
import '../repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../models/profile_model.dart';

class ContactBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  final PortfolioRepository _portfolioRepository;

  ContactBloc( this._profileRepository, this._portfolioRepository) : super(const ProfileState()) {
    on<FetchProfile>(_onFetchProfile);
    // on<FetchPortfolio>(_onFetchPortfolio);
    on<UpdateProfile>(_onUpdateProfile);
  }

  // Gestion de l'événement FetchProfile
  Future<void> _onFetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    // emit(state.copyWith(isLoading: true));
    emit(ProfileLoading());
    try {
      final response = await _profileRepository.profile();
      if (response['success']) {
        print("PROFILE ${response['data']}");
        final profileData = ProfileData.fromJson(response['data']);
        emit(state.copyWith(isLoading: false, profileData: profileData, isSuccess: true));
        emit(ProfileLoaded(profileData: profileData));
      } else {
        emit(state.copyWith(isLoading: false, error: response['error']));
        emit(ProfileError(message: "Failed to load profile"));

      }

    } catch (e) {
      print("PROFILE ${e}");
      emit(state.copyWith(isLoading: false, error: 'Erreur lors du chargement du profil'));
    }
  }

  // Gestion de l'événement UpdateProfile
  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _profileRepository.updateProfile(event.profileData, event.profileData.id, event.picture, event.banier);
      if (response['success']) {
        emit(state.copyWith(isLoading: false, isSuccess: true, profileData: event.profileData, message: response["message"], error: ''));
      } else {
        emit(state.copyWith(isLoading: false, error: response['error']));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Erreur lors de la mise à jour du profil'));
    }
  }
}
