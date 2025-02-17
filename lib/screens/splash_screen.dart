import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'config_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      // Wrap the splash content in a container with a gradient background
      splash: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5880A2), Color(0xFF83A3BE), Color(0xFFAFC6D9)
              ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SPARRING TIMER',
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                     
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                      color: Colors.black38,
                    ),
                  ],
                  letterSpacing: 2.0,
                ),
              ),
            ),
            SizedBox(height: 10),
            LottieBuilder.asset(
              "assets/animation/boxing.json",
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      nextScreen: ConfigScreen(),
      // Set splashIconSize to double.infinity to let our container control the size
      splashIconSize: double.infinity,
      centered: true,
      // Set backgroundColor to transparent since our container provides the background
      backgroundColor: Colors.transparent,
      // splashTransition: SplashTransition.slideTransition,
      duration: 900,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}
