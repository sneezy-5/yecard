import 'dart:io';

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
  final File? picture;
  final File? banier;

  const UpdateProfile({required this.profileData, this.picture, this.banier});

  @override
  List<Object?> get props => [profileData];
}

class FetchPortfolio extends ProfileEvent {}
