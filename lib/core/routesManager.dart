import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AUTH/Login.dart';
import '../AUTH/register.dart';
class RoutesManager {
  static const String loginScreen = 'login';
  static const String registerScreen = 'register';
  static const String forgetPass = 'forgetPass';
  static const String updateUi = 'updateUi';
  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return CupertinoPageRoute(builder: (_) => LoginScreen());
    }
    switch (settings.name)
    {
      case registerScreen:
        return CupertinoPageRoute(builder: (_) => RegisterScreen());
    }
  }
}
