import 'package:flutter/material.dart';
import 'package:moviesapproute/core/imagesManager.dart';
import 'package:moviesapproute/features/Screens/onboarding/onboard_pg5.dart';
import '../../../core/colors_manager/colorsManager.dart';

class OnBoardPage4 extends StatelessWidget {
  const OnBoardPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(color: Colors.black),


          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesManager.onboard4),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesManager.onboard4trans),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                color: Colors.black,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Create Watchlists",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Save movies to your watchlist to keep\n track of what you want to watch next.\n Enjoy films in various qualities and \ngenres.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),


                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.yellow,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnBoardPage5(),
                              ),
                            );
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),


                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: ColorsManager.yellow, width: 2),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: ColorsManager.yellow),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}