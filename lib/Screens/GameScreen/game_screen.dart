import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';


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
  final player = AudioPlayer();
  final successtone = AudioPlayer();
  final marakha = AudioPlayer();

  @override
  void initState() {
    presentMoleIndex = Random().nextInt(9);
    life = 3;
    cancelTimer = false;
    TimerDuration = 1000;
    playAudio();
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
      body: Column(
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
                onTap: () => newPosition(index),
                child: Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.redAccent,
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
    );
  }

  Future<void> newPosition(int index) async {
    if (presentMoleIndex == index) {
      successtone.play();
      score++;
    } else {
      life--;
      marakha.play();
      if (life < 0) {
        Get.back();
      }
    }
    setState(() {
      presentMoleIndex = 15;
    });
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      presentMoleIndex = Random().nextInt(9);
    });
    StartTimer(presentMoleIndex, score);

  }

  StartTimer(int presentMoleIndex, int score) async {
    await Future.delayed(Duration(milliseconds: TimerDuration));
    if (presentMoleIndex == this.presentMoleIndex && score == this.score) {
      marakha.play();
      if (mounted) {
        setState(() {
          this.life--;
          if (this.life < 0) {
            Get.back();
          }
          this.presentMoleIndex = Random().nextInt(9);
          StartTimer(this.presentMoleIndex, this.score);
        });
      }
    }
  }

  void playAudio()async {
    await player.setAsset('assets/music.mp3');
    await successtone.setAsset('assets/successtone.mp3');
    await marakha.setAsset('assets/marakha.mp3');
    player.play();
  }
  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }
}
