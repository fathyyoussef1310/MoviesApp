import 'package:flutter/material.dart';
import 'package:moviesapproute/screens/onboarding/onboard_pg1.dart';
import 'package:moviesapproute/screens/onboarding/onboarding_screen.dart';
import 'MoviesApp_main.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(),
    );
  }
}

