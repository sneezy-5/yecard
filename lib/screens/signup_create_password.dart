import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/password_bloc.dart';
import '../bloc/password_event.dart';
import '../bloc/password_state.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../routes.dart';
import '../widgets/popup_widgets.dart';

class CreatePasswordScreen extends StatefulWidget {
  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocProvider(
            create: (_) => PasswordBloc(),
            child: BlocConsumer<PasswordBloc, PasswordState>(
              listener: (context, state) {
                if (state.isPasswordCreated) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomPopup(
                        title: 'Succès',
                        content: "Votre carte numéroté 123 456 789 123 à été lier a votre compte avec succès vous pouvez bénéficier de tous les avantage de notre service.",
                        buttonText: 'ok',
                        onButtonPressed: () {
                          Navigator.of(context).pop();
                          AppRoutes.pushReplacement(context, AppRoutes.appHome);
                        },
                      );
                    },
                  );
                } else if (state.errorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Créer un mot de passe',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Champ de saisie du mot de passe
                    TextFormField(
                      controller: _passwordController,
                      obscureText: state.obscurePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Créer un mot de passe',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            context.read<PasswordBloc>().add(TogglePasswordVisibility());
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Champ de saisie pour la confirmation du mot de passe
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: state.obscureConfirmPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Confirmation du mot de passe',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            context.read<PasswordBloc>().add(ToggleConfirmPasswordVisibility());
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Bouton "Créer"
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            ),
                            child: Text('Retour', style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PasswordBloc>().add(
                              CreatePassword(
                                _passwordController.text,
                                _confirmPasswordController.text,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: Text(
                            'Créer',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                ]

                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
