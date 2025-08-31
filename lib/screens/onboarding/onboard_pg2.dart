import 'package:flutter/material.dart';
import 'package:moviesapproute/core/colorsManager.dart';
import 'package:moviesapproute/core/imagesManager.dart';
import 'package:moviesapproute/screens/onboarding/onboard_pg3.dart';


class OnBoardPage2 extends StatelessWidget {
  const OnBoardPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(color: Colors.black),

          // الصورة
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesManager.onboard2),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesManager.onboard2trans),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 70),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      const Text(
                        "Discover movies ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Explore a vast collection of movies in all\nqualities and genres. Find your next\nfavorite film with ease. ",
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
                                builder: (context) => const OnBoardPage3(),
                              ),
                            );
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
