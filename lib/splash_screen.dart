import 'dart:async';

import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/features/auth/screens/login_screen.dart';
import 'package:job_journey/home_screen.dart';
import 'package:show_up_animation/show_up_animation.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';

  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      if (context.firebaseUser != null) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    });
    return Scaffold(
      backgroundColor: background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .3,
          ),
          ShowUpAnimation(
              delayStart: const Duration(milliseconds: 50),
              animationDuration: const Duration(seconds: 1),
              curve: Curves.bounceInOut,
              direction: Direction.vertical,
              offset: 0.5,
              child: Column(
                children: [
                  // SvgPicture.asset(
                  //   'assets/images/logo.svg',
                  //   height: MediaQuery.sizeOf(context).height * 0.70,
                  // ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.sizeOf(context).height * 0.25,
                  ),
                  sizedBoxSmall,

                  const SizedBox(
                    height: 20,
                  ),
                  const CircularProgressIndicator(color: blue),
                 
                ],
              )),
          const Spacer(),
          const Text(
            'Connecting Talent With Opportunity',
            style: TextStyle(fontSize: 14, color: gray),
          ),
          sizedBoxLarge,
        ],
      )),
    );
  }
}
