import 'package:flutter/material.dart';

class MoleWidget extends StatefulWidget {
  bool show;
  MoleWidget({Key? key, required this.show}) : super(key: key);

  @override
  _MoleWidgetState createState() => _MoleWidgetState();
}

class _MoleWidgetState extends State<MoleWidget> {
  double height = 0;
  double width = 0;
  @override
  void initState() {
    Future.delayed(Duration(microseconds: 100), () {
      setState(() {
        height = 100;
        width = 100;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            height: height,
            width: width,
            child: Image.asset(
              "assets/mole.png",
              fit: BoxFit.fitHeight,
            ),
          )
        : Container();
  }
}
