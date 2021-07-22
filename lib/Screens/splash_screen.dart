import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeamole/Screens/Controllers/SettingsController.dart';
import 'package:wakeamole/Screens/main_menu.dart';

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
          curve: Curves.bounceIn,
          child: Hero(tag: 'app-logo',
          child: Image.asset("assets/logo.png")),
        ),
      ),
    );
  }

  void nextScreen() async{
    Get.put(SettingsController());
    await Future.delayed(Duration(microseconds: 10));
    setState(() {
      height = 600;
    });
    await Future.delayed(Duration(milliseconds: 5100));
    Get.off(()=>MainMenu());
  }
}
