import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginState()) {

    on<SubmitLogin>(_onSubmitLogin);
    on<ClearError>((event, emit) {
      emit(state.copyWith(errorMessage: null));
    });
  }

  void _onSubmitLogin(SubmitLogin event, Emitter<LoginState> emit) async {

    emit(state.copyWith(isLoading: true,errorMessage:null,errorMessages:{}));

    try {
      final result = await _loginRepository.login(event.loginModelData);
      if (result['success']) {
        emit(state.copyWith(isLoading: false, isSuccess: true,errorMessage:null,errorMessages:{}));


      } else {
        print("Réponse de l'API : $result");

        emit(state.copyWith(
          isLoading: false,
          errorMessages: result['errors'] ?? {},
          errorMessage: result['error']?? null,
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
