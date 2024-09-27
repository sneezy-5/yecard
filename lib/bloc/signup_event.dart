import 'package:equatable/equatable.dart';

import '../models/signup_model.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NextStep extends SignupEvent {}

class BackStep extends SignupEvent {}

class HaveCardChanged extends SignupEvent {
  final bool hasCard;

  HaveCardChanged(this.hasCard);

  @override
  List<Object> get props => [hasCard];
}

class HaveConditionChanged extends SignupEvent {
  final bool condition;

  HaveConditionChanged(this.condition);

  @override
  List<Object> get props => [condition];
}
class SubmitSignup extends SignupEvent {
  final SignupData signupData;

  SubmitSignup(this.signupData);

  @override
  List<Object> get props => [signupData];
}
