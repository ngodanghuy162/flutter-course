import 'package:flutter/material.dart';
import '/views/allviews.dart';

class AppRoute {
  static Route onGenerateRoutes(RouteSettings settings) {
    print('This is route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return LoginView.route();
      case LoginView.routeName:
        return LoginView.route();
      case NotesView.routeName:
        return NotesView.route();
      case RegisterView.routeName:
        return RegisterView.route();
      case VerifyView.routeName:
        return VerifyView.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (_) => Scaffold(appBar: AppBar(title: Text('error'))));
  }
}
