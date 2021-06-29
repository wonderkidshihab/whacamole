import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double height = 50;
  double width = 50;


  @override
  void initState() {
    nextScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          height: height,
          duration: Duration(seconds: 5),
          curve: Curves.bounceInOut,
          child: Image.asset("assets/logo.jpg"),
        ),
      ),
    );
  }

  void nextScreen() async{
    await Future.delayed(Duration(microseconds: 10));
    setState(() {
      height = 600;
    });
    await Future.delayed(Duration(milliseconds: 5100));
    //Next screen call
  }
}
