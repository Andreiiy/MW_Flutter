import 'package:flutter/material.dart';
import 'package:math_world/math_generator/models/class_settings.dart';
import 'package:math_world/pages/class_selection_page.dart';
import 'package:math_world/pages/login_page.dart';
import 'package:math_world/pages/registration/registration_page.dart';
import 'package:math_world/pages/start_page.dart';
import 'package:math_world/pages/test_history_paga.dart';
import 'package:math_world/pages/test_page.dart';
import 'package:math_world/pages/class_selection_page.dart';
import 'package:math_world/pages/test_settings_page.dart';
import 'package:math_world/router/route_constants.dart';

class MathAppRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case startPage:
        return MaterialPageRoute(builder: (_) => StartPage());
      case testPage:
        return MaterialPageRoute(
            builder: (_) => TestPage(
                  classSettings: (settings.arguments as ClassSettings),
                ));
      case testSettingsPage:
        return MaterialPageRoute(
            builder: (_) => TestSettingsPage(
                  classSettings: (settings.arguments as ClassSettings),
                ));
      case classSelectionPage:
        return MaterialPageRoute(builder: (_) => ClassSelectionPage());
        case registrationPage:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
        case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
        case testHistoryPage:
        return MaterialPageRoute(builder: (_) => TestHistoryPage());
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
