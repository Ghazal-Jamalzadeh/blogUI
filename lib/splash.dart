import 'package:blogui/home.dart';
import 'package:blogui/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'gen/assets.gen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (context) =>
      const OnBoardingScreen()
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* برای استفاده از متریال بهتر است روت صفحه ما اسکفلد باشد */
    return Scaffold(
      body: Stack(
        children: [
          /* fill = تمام صفحه را پوشش بده*/
          Positioned.fill(
            /* fit == scaleType */
              child: Assets.img.background.splash.image(fit: BoxFit.cover)),
          /* سنتر یک ویجت دیگه را وسط خودش قرار میده */
          Center(
            child: Assets.img.icons.logo.svg(width: 100),
          )
        ],
      ),
    );
  }
}
