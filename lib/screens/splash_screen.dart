import 'dart:async';
import 'package:flutter/material.dart';
import '../services/user_preference.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;
  Map<String, String>? userInfo;

  @override
  void initState() {
    super.initState();
    _loadUserInfoAndNavigate();
  }

  Future<void> _loadUserInfoAndNavigate() async {
    // Charger le token
    token = await UserPreferences.getUserToken();
    userInfo = await UserPreferences.getUserInfo();
    // Attendre 5 secondes avant de naviguer
    await Future.delayed(Duration(seconds: 5));

    // Naviguer en fonction de la présence du token
    if (token != null) {
      Navigator.of(context).pushReplacementNamed('/app/home');
    } else if (userInfo != null){
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/logo.png', width: 150),
            SizedBox(height: 30),
            Image.asset('assets/logos/splash_screen.png', width: 250),
          ],
        ),
      ),
    );
  }
}
