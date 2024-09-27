import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yecard/bloc/login_state.dart';
import 'package:yecard/bloc/login_event.dart';
import '../repositories/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginState()) {

    on<SubmitLogin>(_onSubmitLogin);
  }

  void _onSubmitLogin(SubmitLogin event, Emitter<LoginState> emit) async {
    print("Début de la soumission du formulaire");

    emit(state.copyWith(isLoading: true));

    try {
      final result = await _loginRepository.login(event.loginModelData);
      if (result['success']) {
        emit(state.copyWith(isLoading: false, isSuccess: true,errorMessage:"",errorMessages:{}));


      } else {
        print("Réponse de l'API : $result");

        emit(state.copyWith(
          isLoading: false,
          errorMessages: result['errors'] ?? {},
          errorMessage: result['error']?? "",
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
