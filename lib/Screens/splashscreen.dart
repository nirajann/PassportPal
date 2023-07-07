import 'package:flutter/material.dart';
import 'package:passportpal/responsive/webScreenLayout.dart';
import 'package:passportpal/utlis/colors.dart';

import '../responsive/mobileScreenLayout.dart';
import '../responsive/responsivelayoutscreen.dart';

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
            children: [
              ClipPath(
                clipper: BottomClipper(),
                child: Container(
                  color: navyBlue,
                  height: screenWidth * 1.5,
                  width: double.infinity,
                ),
              ),
              Image.asset(
                'assets/png/mainlogo.png',
                height: screenHeight * 0.9,
                width: screenWidth * 0.9,
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
                        valueColor: AlwaysStoppedAnimation<Color>(navyBlue),
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

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double radius = size.width * 0.3;
    final Path path = Path()
      ..lineTo(0, size.height - radius)
      ..quadraticBezierTo(0, size.height, radius, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
