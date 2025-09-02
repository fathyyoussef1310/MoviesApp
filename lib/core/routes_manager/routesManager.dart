import 'package:flutter/cupertino.dart';
import '../../features/Screens/forrget_pass.dart';
import '../../features/Screens/onboarding/onboarding_screen.dart';
import '../../features/Screens/update_profile.dart';
import '../../features/authentication/Login.dart';
import '../../features/authentication/register.dart';

class RoutesManager {
  static const String onboardingScreen = 'onboarding';
  static const String loginScreen = 'login';
  static const String registerScreen = 'register';
  static const String updateProfileUi = 'updateProfile';
  static const String forgetPass = 'forgetPass';

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardingScreen:
        return CupertinoPageRoute(builder: (_) => const OnBoardingScreen());
      case loginScreen:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());
      case updateProfileUi:
        return CupertinoPageRoute(builder: (_) => const UpdateProfile());
      case forgetPass:
        return CupertinoPageRoute(builder: (_) => const ForrgetPass());
      default:
        return null;
    }
  }
}
