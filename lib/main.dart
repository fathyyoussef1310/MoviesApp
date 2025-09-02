
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes_manager/routesManager.dart';

void main() {
<<<<<<< HEAD
  runApp(MoviesApp());
  runApp(const MyApp());
=======
  runApp(const MoviesApp());
>>>>>>> aa138d70c475895db1122653cc9d8402b9ab08dd
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430,932),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.getRoute,
          initialRoute: RoutesManager.onboardingScreen,
        );
      },
    );
  }
}
