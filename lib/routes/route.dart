import 'package:assignment_2/pages/loading_page.dart';
import 'package:assignment_2/pages/register_page.dart';
import 'package:assignment_2/pages/units_page.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class Routing {
  static const LoadingPage = '/';
  static const LoginPage = '/login';
  static const RegisterPage = '/register';
  static const UnitPage = '/unit';

  static Route<dynamic> createRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoadingPage:
        return MaterialPageRoute(
          builder: (context) => Loader(),
        );

      case LoginPage:
        return MaterialPageRoute(
          builder: (context) => Login(),
        );
      case RegisterPage:
        return MaterialPageRoute(
          builder: (context) => Register(),
        );
      case UnitPage:
        return MaterialPageRoute(
          builder: (context) => Unit(),
        );

      default:
        throw FormatException('ERROR: Route not found!');
    }
  }
}
