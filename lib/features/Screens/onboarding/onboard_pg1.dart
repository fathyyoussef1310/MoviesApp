import 'package:flutter/material.dart';

import '../../../core/colors_manager/colorsManager.dart';
import '../../../core/image_manager/imagesManager.dart';
import 'onboard_pg2.dart';
class OnBoardPage1 extends StatelessWidget {
  const OnBoardPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Stack(
          children: [
            Container(
              color: Colors.black,
            ),
        
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagesManager.onboard1),
                  fit: BoxFit.cover,
                ),
              ),
            ),
        
        
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Find Your Next\nFavorite Movie Here",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Get access to a huge library of movies \nto suit all tastes. You will surely like it.",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  ColorsManager.yellow,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OnBoardPage2()),
                          );
        
                        },
                        child: const Text(
                          "Explore Now",
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}
