import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wakeamole/Screens/splash_screen.dart';
import 'package:wakeamole/Utils/game_theme.dart';
import 'package:wakeamole/firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  final TrackingStatus status =
  await AppTrackingTransparency.requestTrackingAuthorization();
  runApp(MyApp(status: status,));
}

class MyApp extends StatelessWidget {
  final TrackingStatus status;

  MyApp({required this.status});

  @override
  Widget build(BuildContext context) {
    String statusText;

    switch (status) {
      case TrackingStatus.authorized:
        statusText = 'Tracking Status Authorized';
        break;
      case TrackingStatus.denied:
        statusText = 'Tracking Status Denied';
        break;
      case TrackingStatus.notDetermined:
        statusText = 'Tracking Status Not Determined';
        break;
      case TrackingStatus.notSupported:
        statusText = 'Tracking Status Not Supported';
        break;
      case TrackingStatus.restricted:
        statusText = 'Tracking Status Restricted';
        break;
      default:
        statusText = 'You should not see this...';
        break;
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      navigatorObservers: [],
      theme: GameTheme.theme(),
    );
  }
}
