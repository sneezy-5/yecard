import 'package:equatable/equatable.dart';
import '../models/portfolio.dart';
import '../models/profile_model.dart';

class ProfileState extends Equatable {
  final ProfileData? profileData;
  final PortfolioData? portfolioData;
  final bool isLoading;
  final bool isSuccess;
  final String error;
  final String message;

  const ProfileState({
    this.profileData,
    this.portfolioData,
    this.isLoading = false,
    this.isSuccess = false,
    this.message='',
    this.error = '',
  });

  ProfileState copyWith({
    ProfileData? profileData,
    PortfolioData? portfolioData,
    bool? isLoading,
    bool? isSuccess,
    String? message,
    String? error,
  }) {
    return ProfileState(
      profileData: profileData ?? this.profileData,
      portfolioData: portfolioData ?? this.portfolioData,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: error ?? this.message,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [profileData,portfolioData, isLoading, isSuccess, error, message];
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