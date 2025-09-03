import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:moviesapproute/features/authentication/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes_manager/routesManager.dart';
import 'features/Screens/onboarding/onboarding_screen.dart';
import 'features/authentication/Login.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool? onboardingSeen = prefs.getBool('onboarding_seen');
  runApp(MyApp(onboardingSeen: onboardingSeen ?? false));
}

class MyApp extends StatelessWidget {
  final bool onboardingSeen;
  const MyApp({required this.onboardingSeen, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (context, child) {
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.getRoute,
          home: onboardingSeen ? LoginScreen() : OnBoardingScreen(),
        );
      },
    );
  }
}
