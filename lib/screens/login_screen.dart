import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../models/login_model.dart';
import '../repositories/login_repository.dart';
import '../routes.dart';
import '../services/login_service.dart';


class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginRepository(LoginService())),
      child: LoginScreenWiev(),
    );
  }
}


class LoginScreenWiev extends StatelessWidget  {
  final _passwordController = TextEditingController();
  final _identifierController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isSuccess) {
                AppRoutes.pushReplacement(context, AppRoutes.appHome);
              } else if (state.errorMessage.isNotEmpty && !state.isSuccess) {
                final errorMessage = state.errorMessage;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMessage)),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Connectez-vous à votre compte',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),


                    TextField(
                      controller: _identifierController,
                      decoration: InputDecoration(
                        errorText: state.errorMessages['email']?.join(', '),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Identifiant',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/person.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: state.errorMessages['password']?.join(', '),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Mot de passe',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.lock),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Row avec la checkbox et les textes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (bool? value) {
                                // setState(() {
                                //   _rememberMe = value ?? false;
                                // });
                              },
                            ),
                            const Text("Se souvenir de moi"),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: const Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        "Vous n'avez pas de compte?",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          AppRoutes.pushReplacement(context, AppRoutes.signup);
                        },
                        child: const Text(
                          "Créer un compte",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Bouton "Se connecter"
                    Center(
                      child: ElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () {
                          final loginData = LoginModelData(
                            email: _identifierController.text,
                            password: _passwordController.text,
                          );

                          context
                              .read<LoginBloc>()
                              .add(SubmitLogin(loginData));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : const Text(
                          'Se connecter',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
