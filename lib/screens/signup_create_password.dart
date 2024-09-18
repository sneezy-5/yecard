import 'package:flutter/material.dart';

import '../widgets/popup_widgets.dart';

class CreatePasswordScreen extends StatefulWidget {
  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  // Fonction pour basculer la visibilité du mot de passe
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Fonction pour basculer la visibilité de la confirmation du mot de passe
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmText = !_obscureConfirmText;
    });
  }

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
                'Créer un mot de passe',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),

              // Champ d'entrée pour le mot de passe
              TextFormField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Créer un mot de passe',
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Champ d'entrée pour la confirmation du mot de passe
              TextFormField(
                obscureText: _obscureConfirmText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Confirmation de mot de passe',
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmText
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Bouton "Créer"
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomPopup(
                          title: 'Succès',
                          content: 'Votre mot de passe a été créé avec succès.',
                          buttonText: '',
                          onButtonPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('/app/home');
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'Créer',
                    style: TextStyle(fontSize: 12, color: Colors.white),
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
