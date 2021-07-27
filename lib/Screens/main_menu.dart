import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakeamole/Screens/Controllers/SettingsController.dart';
import 'package:wakeamole/Screens/GameScreen/game_screen.dart';
import 'package:wakeamole/Screens/Rankings.dart';
import 'package:wakeamole/Utils/AppColors.dart';
import 'package:wakeamole/Utils/widgets/app_main_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            transformAlignment: Alignment.center,
            height: Get.height * 0.3,
            alignment: Alignment.center,
            child: Hero(tag: 'app-logo', child: Image.asset("assets/logo.png")),
          ),
          AppMainButton(ontap: () {
            Get.to(()=>GameScreen());
          }, title: "START"),
          SizedBox(
            height: 15,
          ),
          AppMainButton(
              ontap: () {
                Get.dialog(Dialog(
                  backgroundColor: Colors.transparent,
                  insetAnimationCurve: Curves.easeIn,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    width: Get.width - 40,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        Obx(
                          () => CheckboxListTile(
                            value: SettingsController.to.musicEnabled(),
                            onChanged: (v) =>
                                SettingsController.to.musicEnabled(v),
                            title: Text(
                              'Music',
                              style: TextStyle(
                                  color: AppColors.MAIN,
                                  fontWeight: FontWeight.bold),
                            ),
                            activeColor: AppColors.MAIN,
                          ),
                        ),
                        Obx(
                          () => CheckboxListTile(
                            value: SettingsController.to.sfxEnabled(),
                            onChanged: (v) =>
                                SettingsController.to.sfxEnabled(v),
                            title: Text(
                              'Sound Effects',
                              style: TextStyle(
                                  color: AppColors.MAIN,
                                  fontWeight: FontWeight.bold),
                            ),
                            activeColor: AppColors.MAIN,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        /*Obx(() => AppMainButton(
                              ontap: ()async {
                                 var result = await _googleSignIn.signIn();
                                 if (result != null) {
                                   SettingsController.to.signedIn(true);
                                 }  else{
                                   SettingsController.to.signedIn(false);
                                 }
                                },
                              title: SettingsController.to.signedIn()
                                  ? "Sign In"
                                  : "Sign Out",
                              backgroundColor: SettingsController.to.signedIn()
                                  ? Colors.green
                                  : AppColors.MAIN,
                            )),*/
                      ],
                    ),
                  ),
                ));
              },
              title: "SETTINGS"),
          SizedBox(
            height: 15,
          ),
          AppMainButton(
              ontap: () {
                Get.to(() => RankingScreen());
              },
              title: "RANKINGS"),
        ],
      ),
    );
  }
}
