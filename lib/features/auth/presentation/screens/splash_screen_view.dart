import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_project/features/auth/presentation/screens/login_view.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      pageTransitionType: PageTransitionType.leftToRight,
      splashIconSize: 200,
      splashTransition: SplashTransition.scaleTransition,
      splash: Image.asset(AppImages.KLogo),
      nextScreen: const LoginView(),
    );
  }
}
