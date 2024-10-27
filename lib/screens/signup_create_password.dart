import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/password_bloc.dart';
import '../bloc/password_event.dart';
import '../bloc/password_state.dart';
import '../models/password_reset.dart';
import '../repositories/reset_password_repository.dart';
import '../routes.dart';
import '../services/reset_password.dart';
import '../services/user_preference.dart';
import '../widgets/popup_widgets.dart';


class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  String? token;
  Map<String, String>? userInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    token = await UserPreferences.getUserToken();
    userInfo = await UserPreferences.getUserInfo();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final userId = int.tryParse(userInfo?['id'] ?? '');

    if (userId == null) {
      print(userInfo);
      return Scaffold(
        body: Center(
          child: Text("ID utilisateur invalide"),
        ),
      );
    }

    return BlocProvider(
      create: (context) => PasswordBloc(
        PasswordResetRepository(ResetService(), userId),
      ),
      child: CreatePasswordWiev(),
    );
  }
}

class CreatePasswordWiev extends StatelessWidget {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
            child: BlocConsumer<PasswordBloc, PasswordState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return CustomPopup(
                        title: 'Succès',
                        content: "Votre mot de passe a ete cree avec succes",
                        buttonText: 'ok',
                        onButtonPressed: () {
                          Navigator.of(context).pop();
                          AppRoutes.pushReplacement(context, AppRoutes.appHome);
                        },
                      );
                    },
                  );
                } else if (state.errorMessages.isNotEmpty) {
                  final errorMessage = state.errorMessages.entries
                      .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
                      .join('\n');
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
                          errorText: state.errorMessage,
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
                          errorText: state.errorMessage,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[

                            ElevatedButton(
                              onPressed: context.watch<PasswordBloc>().state.isLoading
                                  ? null
                                  : () {

                                final passwordData = PasswordResetData(
                                  newpassword: _passwordController.text,
                                  confirmPassword: _confirmPasswordController.text,

                                );

                                context.read<PasswordBloc>().add(
                                    SubmitResetPassword(passwordData)
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              ),
                              child:  context.watch<PasswordBloc>().state.isLoading
                                  ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                                  : Text('Creer', style: TextStyle(fontSize: 16, color: Colors.white)),
                            ),

                          ]

                      ),
                    ],
                  )
                );

              },
            ),
        ),
      ),
    );
  }
}
