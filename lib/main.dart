import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/image_manager/imagesManager.dart';
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.getRoute,
          home: SplashScreen(onboardingSeen: onboardingSeen),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  final bool onboardingSeen;
  const SplashScreen({required this.onboardingSeen, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  void _goNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (widget.onboardingSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          ImagesManager.MovieIcon,
          width: 150.w,
          height: 150.h,
        ),

      ),
    );
  }
}
