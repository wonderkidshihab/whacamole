import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score = 0;
  late int presentMoleIndex;
  late int life;
  late bool cancelTimer;
  late int TimerDuration;
  late Color backgroundColor;
  late bool gameover;

  @override
  void initState() {
    presentMoleIndex = Random().nextInt(9);
    life = 3;
    cancelTimer = false;
    TimerDuration = 1000;
    backgroundColor = Colors.white;
    gameover = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Score: $score", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          ListView.separated(
              padding: EdgeInsets.only(right: 20),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Icon(
                  Icons.favorite,
                  color: index <= life-1 ? Colors.red : Colors.grey,
                );
              },
              separatorBuilder: (_, index) {
                return SizedBox(
                  width: 5,
                );
              },
              itemCount: 3),
        ],
      ),
      backgroundColor: Colors.white,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 30, crossAxisSpacing: 30),
              itemBuilder: (_, index) {
                return InkWell(
                  splashColor: Colors.lightGreenAccent,
                  onTap: () => newPosition(index),
                  child: Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.deepPurple,
                      child: presentMoleIndex == index
                          ? Image.asset(
                              "assets/mole.png",
                              fit: BoxFit.fitHeight,
                            )
                          : null,
                    ),
                  ),
                );
              },
              itemCount: 9,
            )
          ],
        ),
      ),
    );
  }

  Future<void> newPosition(int index) async {
    if (presentMoleIndex == index) {
      increaseScore();
    } else {
      decreaseLife();
    }
    if (mounted) {
      setState(() {
        presentMoleIndex = 15;
      });
    }
    await Future.delayed(Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        presentMoleIndex = Random().nextInt(9);
      });
    }
    StartTimer(presentMoleIndex, score);

  }

  StartTimer(int presentMoleIndex, int score) async {
    await Future.delayed(Duration(milliseconds: TimerDuration));
    if (presentMoleIndex == this.presentMoleIndex && score == this.score && !gameover) {
      if (mounted) {
        setState(() {
          decreaseLife();
          this.presentMoleIndex = Random().nextInt(9);
          StartTimer(this.presentMoleIndex, this.score);
        });
      }
    }
  }

  void decreaseLife() async{
    life--;
    if (mounted) {
      setState(() {
        backgroundColor = Colors.redAccent;
      });
    }
    if (life < 0) {
      int highScore = 0;
      highScore = (await SharedPreferences.getInstance()).getInt("highscore") ?? 0;
      if (score > highScore) {
        (await SharedPreferences.getInstance()).setInt("highscore", score);
      }
      gameover = true;
      var restartGame = await showDialog( context: context, builder: (BuildContext context) {
        return Dialog(
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
                Text("Your Score: $score",style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.redAccent)),
                SizedBox(
                  height: 20,
                ),
                Image.asset("assets/mole win.png"),
                SizedBox(
                  height: 20,
                ),

                TextButton(onPressed: (){Get.back(result: true);}, child: Text("RESTART",style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.lightBlue)),),

                SizedBox(
                  height: 30,
                ),
                Text("Your Highscore: ${score > highScore ? score : highScore}",style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.redAccent)),
              ],
            ),
          ),
        );
      });
      if (restartGame == true) {
        restart();
      }  else{
        Get.back();
      }
    }
    await Future.delayed(Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        backgroundColor = Colors.white;
      });
    }
  }

  void increaseScore()async {
    score++;
    if (mounted) {
      setState(() {
        backgroundColor = Colors.lightGreenAccent;
      });
    }
    await Future.delayed(Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        backgroundColor = Colors.white;
      });
    }
  }

  void restart(){
    presentMoleIndex = Random().nextInt(9);
    life = 3;
    cancelTimer = false;
    TimerDuration = 1000;
    backgroundColor = Colors.white;
    gameover = false;
    score = 0;
    setState(() {

    });
  }
}
