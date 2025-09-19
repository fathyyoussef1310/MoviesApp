import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:moviesapproute/features/layout_screen.dart';
import 'package:moviesapproute/features/authentication/Login.dart';
import 'package:moviesapproute/features/Screens/onboarding/onboarding_screen.dart';
import 'core/routes_manager/routesManager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviesapproute/providers/movie_List_providers.dart'; // مثال على Provider عندك

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final bool onboardingSeen = prefs.getBool('onboarding_seen') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesListProvider()),
        // ممكن تضيف أي Provider آخر هنا
      ],
      child: MyApp(
        onboardingSeen: onboardingSeen,
        isLoggedIn: isLoggedIn,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboardingSeen;
  final bool isLoggedIn;

  const MyApp({
    required this.onboardingSeen,
    required this.isLoggedIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.getRoute,
          home: _getInitialScreen(),
        );
      },
    );
  }

  Widget _getInitialScreen() {
    if (!onboardingSeen) {
      return OnBoardingScreen();
    } else if (isLoggedIn) {
      return LayoutScreen();
    } else {
      return LoginScreen();
    }
  }
}
