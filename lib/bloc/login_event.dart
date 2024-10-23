import 'package:equatable/equatable.dart';
import 'package:yecard/models/login_model.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitLogin extends LoginEvent {
  final LoginModelData loginModelData;

  SubmitLogin(this.loginModelData);

  @override
  List<Object> get props => [loginModelData];
}

class ClearError extends LoginEvent {}