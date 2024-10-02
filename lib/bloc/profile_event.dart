import 'package:equatable/equatable.dart';
import '../models/profile_model.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

// Événement pour récupérer le profil
class FetchProfile extends ProfileEvent {}

// Événement pour mettre à jour le profil
class UpdateProfile extends ProfileEvent {
  final ProfileData profileData;

  const UpdateProfile({required this.profileData});

  @override
  List<Object?> get props => [profileData];
}

class FetchPortfolio extends ProfileEvent {}
