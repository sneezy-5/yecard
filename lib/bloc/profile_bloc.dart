import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yecard/repositories/profile_repository.dart';
import '../models/portfolio.dart';
import '../repositories/portfolio_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../models/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  final PortfolioRepository _portfolioRepository;

  ProfileBloc( this._profileRepository, this._portfolioRepository) : super(const ProfileState()) {
    on<FetchProfile>(_onFetchProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<FetchPortfolio>(_onFetchPortfolio);
  }

  // Gestion de l'événement FetchProfile
  Future<void> _onFetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    emit(ProfileLoading());
    try {
      final response = await _profileRepository.profile();
      if (response['success']) {
        print(response['data']);
        final profileData = ProfileData.fromJson(response['data']);
        emit(state.copyWith(isLoading: false, profileData: profileData));
        emit(ProfileLoaded(profileData: profileData));
      } else {
        emit(state.copyWith(isLoading: false, error: response['error']));
        emit(ProfileError(message: "Failed to load profile"));

      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Erreur lors du chargement du profil'));
    }
  }


  Future<void> _onFetchPortfolio(FetchPortfolio event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final response = await _portfolioRepository.portfolio();
      if (response['success']) {
        print(response['data']);
        final portfolioData = PortfolioData.fromJson(response['data']);
        emit(PortfolioLoaded(portfolioData: portfolioData));
      } else {
        emit(state.copyWith(isLoading: false, error: response['error']));
        emit(ProfileError(message: "Failed to load profile"));

      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Erreur lors du chargement du profil'));
    }
  }

  // Gestion de l'événement UpdateProfile
  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _profileRepository.updateProfile(event.profileData, event.profileData.id);
      if (response['success']) {
        emit(state.copyWith(isLoading: false, isSuccess: true, profileData: event.profileData));
      } else {
        emit(state.copyWith(isLoading: false, error: response['error']));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Erreur lors de la mise à jour du profil'));
    }
  }
}
