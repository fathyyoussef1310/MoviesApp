import 'package:flutter/material.dart';

import 'onboard_pg1.dart';
import 'onboard_pg2.dart';
import 'onboard_pg3.dart';
import 'onboard_pg4.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          OnBoardPage1(),
          OnBoardPage2(),
          OnBoardPage3(),
          OnBoardPage4(),
        ],
      ),
    );
  }
}