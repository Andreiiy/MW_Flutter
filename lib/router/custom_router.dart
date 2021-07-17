
import 'package:flutter/material.dart';
import 'package:math_world/pages/start_page.dart';
import 'package:math_world/router/route_constants.dart';

class MathAppRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case startPage:
        return MaterialPageRoute(builder: (_) => StartPage());
      // case registrationRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => RegistrationPage(settings.arguments != null
      //           ? (settings.arguments as String)
      //           : null));

      default:
        return MaterialPageRoute(builder: (_) => StartPage());
    }
  }
}
