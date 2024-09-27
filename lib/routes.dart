import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yecard/repositories/delivery_repository.dart';
import 'package:yecard/screens/app/home_screen.dart';
import 'package:yecard/screens/app/screens/add_portfolio.dart';
import 'package:yecard/screens/app/screens/card_order.dart';
import 'package:yecard/screens/app/screens/portfolio_details.dart';
import 'package:yecard/screens/app/screens/profile_screen.dart';
import 'package:yecard/screens/home_sccreen.dart';
import 'package:yecard/screens/login_screen.dart';
import 'package:yecard/screens/signup_create_password.dart';
import 'package:yecard/screens/signup_screen.dart';
import 'package:yecard/services/delivery_service.dart';
import 'bloc/delivery_bloc.dart';
import 'screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String createPassword = '/create_password';
  static const String appHome = '/app/home';
  static const String appProfile = '/app/profile';
  static const String appPortfolioDetail = '/app/portfolio_detail';
  static const String appAddPortfolio = '/app/add_portfolio';
  static const String appGetOrder = '/app/order';

  // Gestion des routes
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
      case createPassword:
        return MaterialPageRoute(builder: (_) =>CreatePasswordScreen());
      case appHome:
        return MaterialPageRoute(builder: (_) => HomePage());
      case appProfile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case appPortfolioDetail:
        return MaterialPageRoute(builder: (_) => PortfolioDetailScreen());
      case appAddPortfolio:
        return MaterialPageRoute(builder: (_) => PortfolioFormScreen());
      case appGetOrder:
        return MaterialPageRoute(
          builder: (_) {
            // Créez une instance de DeliveryRepository
            final deliveryRepository = DeliveryRepository(
              deliveryService: DeliveryService(),
            );

            // Injectez le repository dans le DeliveryBloc
            return BlocProvider(
              create: (_) => DeliveryBloc(deliveryRepository),
              child: DeliveryScreen(),
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  // Méthode pour naviguer sans revenir
  static void pushReplacement(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  // Méthode pour remplacer toutes les routes précédentes et éviter tout retour
  static void pushAndRemoveUntil(BuildContext context, String newRouteName) {
    Navigator.pushNamedAndRemoveUntil(context, newRouteName, (Route<dynamic> route) => false);
  }
}
