import 'package:flutter/cupertino.dart';

import '../AUTH/Login.dart';
import '../AUTH/register.dart';
import '../screens/onboarding/onboarding_screen.dart';

class RoutesManager {
  static const String onboardingScreen = 'onboarding';
  static const String loginScreen = 'login';
  static const String registerScreen = 'register';

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardingScreen:
        return CupertinoPageRoute(builder: (_) => const OnBoardingScreen());
      case loginScreen:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());
      default:
        return null;
    }
  }
}
