import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeamole/Screens/splash_screen.dart';
main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      navigatorObservers: [
      FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}