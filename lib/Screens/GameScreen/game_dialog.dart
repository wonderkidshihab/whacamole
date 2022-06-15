import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameDialog extends StatefulWidget {
  final int score;
  final int highscore;
  const GameDialog({Key? key, required this.score, required this.highscore})
      : super(key: key);

  @override
  _GameDialogState createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetAnimationCurve: Curves.easeIn,
      child: Container(
        height: 450,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        width: Get.width - 40,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Score: ${widget.score}",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.redAccent)),
            SizedBox(
              height: 20,
            ),
            Image.asset("assets/mole win.png"),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Get.back(result: true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RESTART",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Highscore: ${widget.score > widget.highscore ? widget.score : widget.highscore}",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
