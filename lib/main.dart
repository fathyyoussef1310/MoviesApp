import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:moviesapproute/data/api_service/api_service.dart';
import 'package:moviesapproute/main_layout/MoviesDetailsScreen.dart';
import 'package:moviesapproute/repositiory/movie_repository.dart';
import 'package:provider/provider.dart';
import 'package:moviesapproute/main_layout/layout_screen.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import 'package:moviesapproute/features/Screens/onboarding/onboarding_screen.dart';
import 'package:moviesapproute/features/authentication/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviesapproute/providers/movie_details_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final bool? onboardingSeen = prefs.getBool('onboarding_seen');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieDetailsProvider(
            MovieRepository(ApiService()),
          ),
        ),
      ],
      child: MyApp(
        onboardingSeen: onboardingSeen ?? false,
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
          home: onboardingSeen ? (isLoggedIn ? LayoutScreen() : LoginScreen()) : OnBoardingScreen(),
          // home: MovieDetailsScreen(movieId: 3),
        );
      },
    );
  }
}
