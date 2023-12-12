import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../shared/style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/main',
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie_logo.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            Text(
              'Restaurant App',
              style: blackTextStyle.copyWith(
                fontSize: 32,
                fontWeight: semiBold,
                letterSpacing: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
