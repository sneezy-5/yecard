import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Texte principal
              Text(
                'Connectez-vous à votre compte',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),

              // Champ d'entrée pour l'identifiant
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
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
              SizedBox(height: 20),

              // Champ d'entrée pour le mot de passe
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Mot de passe',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/icons/lock.png',  // Remplacez par votre icône de mot de passe
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Row avec la checkbox et les textes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,  // État de la checkbox
                        onChanged: (bool? value) {  // Gérer l'état de la checkbox
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text("Se souvenir de moi"),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Action à définir pour le mot de passe oublié
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
                child:
                Text(
                  "Vous n'avez pas de compte?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child:

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: const Text(
                    "Créer un compte",
                    style: TextStyle(
                      color: Colors.green,
                      // fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Bouton "Se connecter"
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Action de connexion
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text('Se connecter',style: TextStyle(
                    fontSize: 12,
                    color: Colors.white
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
