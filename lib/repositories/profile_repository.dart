import 'dart:io';

import '../models/profile_model.dart';
import '../services/profile_service.dart';


class ProfileRepository {
  final ProfileService _profileService;

  ProfileRepository(this._profileService);

  Future<Map<String, dynamic>>profile () async {
    return await _profileService.getProfile();
  }

  Future<Map<String, dynamic>>contactProfile (String id) async {
    return await _profileService.getContactProfile(id);
  }
  Future<Map<String, dynamic>>updateProfile (ProfileData profileData, int id, File? picture, File? banier) async {
    return await _profileService.updateProfile(profileData, id, picture, banier);
  }
}
