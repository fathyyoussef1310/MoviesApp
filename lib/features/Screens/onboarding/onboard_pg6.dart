import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/colors_manager/colorsManager.dart';
import '../../../core/image_manager/imagesManager.dart';
import '../../authentication/Login.dart';

class OnBoardPage6 extends StatelessWidget {
  const OnBoardPage6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.black),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesManager.onboard6),
                fit: BoxFit.contain,

              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesManager.onboard6trans),
                fit: BoxFit.contain,
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
                        "Start Watching Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                          onPressed: () async {

                            final prefs = await SharedPreferences.getInstance();

                            await prefs.setBool('onboarding_seen', true);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>  LoginScreen()),
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