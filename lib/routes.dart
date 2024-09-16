import 'package:flutter/material.dart';
import 'package:yecard/screens/home_sccreen.dart';
import 'package:yecard/screens/login_screen.dart';
import 'package:yecard/screens/signup_create_password.dart';
import 'package:yecard/screens/signup_screen.dart';
import 'screens/splash_screen.dart';


class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String create_password = '/create_password';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case create_password:
        return MaterialPageRoute(builder: (_) => CreatePasswordScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

