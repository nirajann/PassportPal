import 'package:flutter/material.dart';
import 'package:passportpal/responsive/mobileScreenLayout.dart';
import 'package:passportpal/responsive/responsivelayoutscreen.dart';
import 'package:passportpal/responsive/webScreenLayout.dart';
import 'package:passportpal/utlis/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ));
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double screenHeight = constraints.maxHeight;
          final double screenWidth = constraints.maxWidth;

          return Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                child: SizedBox(
                  height: 25,
                  child: Image.asset(
                    'assets/png/Splashscreen.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Image.asset(
                'assets/png/mainlogo.png',
                height: screenHeight * 0.8,
                width: screenWidth * 0.8,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, screenHeight * 0.3, 0, 0),
                child: Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: [
                            for (var i = 0; i < 'PASSPORTPAL'.length; i++)
                              TextSpan(
                                text: 'PASSPORTPAL'[i],
                                style: const TextStyle(letterSpacing: 3.0),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, screenHeight * 0.8, 0, 0),
                child: Center(
                  child: Column(
                    children: const [
                      Text(
                        'Chase Your Dream',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 90,
                      ),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
