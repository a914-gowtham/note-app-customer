import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget{

  @override
  _SplashState createState() => _SplashState();

}

class _SplashState extends State<Splash>{

  void onPressed(){
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  void initState() {
    Timer(Duration(seconds: 4),
            () =>
            Navigator.popAndPushNamed(context, '/home'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:  SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/lottie_tv.json',repeat: false)),
        ),
      ),
    );
  }

  void _onLoaded(LottieComposition p1) {
    Timer(p1.duration,
            () =>
            Navigator.popAndPushNamed(context, '/home'));
  }
}