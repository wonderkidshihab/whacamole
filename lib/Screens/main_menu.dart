import 'package:flutter/material.dart';
import 'package:wakeamole/Utils/AppColors.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FractionallySizedBox(
            heightFactor: 0.3,
            widthFactor: 0.75,
            alignment: Alignment.center,
            child: Image.asset("assets/logo.jpg"),
          ),
          TextButton(
            onPressed: () {},
            child: Text("START"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.MAIN),
            ),
          )
        ],
      ),
    );
  }
}
