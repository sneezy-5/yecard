import 'package:Yecard/bloc/signup_event.dart';
import 'package:Yecard/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/signup_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository _signupRepository;

  SignupBloc(this._signupRepository) : super(SignupState()) {
    on<NextStep>(_onNextStep);
    on<BackStep>(_onBackStep);
    on<HaveCardChanged>(_onHaveCardChanged);
    on<HaveConditionChanged>(_hveConditionChanged);
    on<SubmitSignup>(_onSubmitSignup);
  }

  void _onNextStep(NextStep event, Emitter<SignupState> emit) {
    if (state.currentStep < 3) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onBackStep(BackStep event, Emitter<SignupState> emit) {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _onHaveCardChanged(HaveCardChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(hasCard: event.hasCard));
  }

  void _hveConditionChanged(HaveConditionChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(condition: event.condition));
  }
  void _onSubmitSignup(SubmitSignup event, Emitter<SignupState> emit) async {
    emit(state.copyWith(isLoading: true,errorMessage:null,errorMessages:{}));

    try {
      final result = await _signupRepository.signup(event.signupData);
      if (result['success']) {
        emit(state.copyWith(isLoading: false, isSuccess: true,errorMessage:null,errorMessages:{}));
      } else {
        print("Réponse de l'API : $result");

        emit(state.copyWith(
          isLoading: false,
          errorMessages: result['errors'] ?? {},
          errorMessage: null
        ));

      }
    } catch (e) {
      print("Erreur capturée lors de l'appel API : $e");

      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Une erreur s\'est produite. Veuillez réessayer.',
      ));
    }
  }
}
