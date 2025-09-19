import 'package:flutter/cupertino.dart';
import 'package:moviesapproute/features/home/home_screen.dart';
import 'package:moviesapproute/features/layout_screen.dart';
import '../../features/Screens/forrget_pass.dart';
import '../../features/Screens/onboarding/onboarding_screen.dart';
import '../../features/Screens/update_profile.dart';
import '../../features/authentication/Login.dart';
import '../../features/authentication/register.dart';
import '../../features/profile/profile_screen.dart';

class RoutesManager {
  static const String onboardingScreen = 'onboarding';
  static const String loginScreen = 'login';
  static const String registerScreen = 'register';
  static const String updateProfileUi = 'updateProfile';
  static const String forgetPass = 'forgetPass';
  static const String Profile = 'profile';
  static const String Layout = 'layout';
  static const String home = '/home';

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardingScreen:
        return CupertinoPageRoute(builder: (_) => const OnBoardingScreen());
      case loginScreen:
        return CupertinoPageRoute(builder: (_) =>  LoginScreen());
      case registerScreen:
        return CupertinoPageRoute(builder: (_) =>  RegisterScreen());
      case updateProfileUi:
        return CupertinoPageRoute(builder: (_) => const UpdateProfile());
      case forgetPass:
        return CupertinoPageRoute(builder: (_) => const ForrgetPass());
      case Profile:
        return CupertinoPageRoute(builder: (_) => ProfileScreen());
      case Layout:
        return CupertinoPageRoute(builder: (_) => const LayoutScreen());
      case home:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      default:
        return null;
    }
  }
}
