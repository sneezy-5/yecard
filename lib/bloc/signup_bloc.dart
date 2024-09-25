import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yecard/bloc/signup_event.dart';
import 'package:yecard/bloc/signup_state.dart';
import '../repositories/signup_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository _signupRepository;

  SignupBloc(this._signupRepository) : super(SignupState()) {
    on<NextStep>(_onNextStep);
    on<BackStep>(_onBackStep);
    on<HaveCardChanged>(_onHaveCardChanged);
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

  void _onSubmitSignup(SubmitSignup event, Emitter<SignupState> emit) async {
    print("Début de la soumission du formulaire");

    emit(state.copyWith(isLoading: true));

    try {
      final result = await _signupRepository.signup(event.signupData);
      if (result['success']) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        print("Réponse de l'API : $result");

        emit(state.copyWith(
          isLoading: false,
          errorMessages: result['errors'] ?? {},
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
