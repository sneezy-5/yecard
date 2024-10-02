import 'package:equatable/equatable.dart';
import '../models/portfolio.dart';
import '../models/profile_model.dart';

class ProfileState extends Equatable {
  final ProfileData? profileData;
  final bool isLoading;
  final bool isSuccess;
  final String error;

  const ProfileState({
    this.profileData,
    this.isLoading = false,
    this.isSuccess = false,
    this.error = '',
  });

  ProfileState copyWith({
    ProfileData? profileData,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ProfileState(
      profileData: profileData ?? this.profileData,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [profileData, isLoading, isSuccess, error];
}


class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileData profileData;

  const ProfileLoaded({required this.profileData});

  @override
  List<Object> get props => [profileData];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

class PortfolioLoaded extends ProfileState {
  final PortfolioData portfolioData;

  const PortfolioLoaded({required this.portfolioData});

  @override
  List<Object> get props => [portfolioData];
}

class PortfolioError extends ProfileState {
  final String message;

  const PortfolioError({required this.message});

  @override
  List<Object> get props => [message];
}