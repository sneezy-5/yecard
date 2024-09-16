import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: AppRoutes.generateRoute,  // Utilisez les routes générées
      initialRoute: AppRoutes.splash,  // SplashScreen comme route initiale
    );
  }
}

