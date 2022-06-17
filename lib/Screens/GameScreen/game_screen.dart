import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeamole/Screens/GameScreen/game_dialog.dart';
import 'package:wakeamole/Screens/GameScreen/mole_widget.dart';

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
  late int nextPopDelay;
  late Color backgroundColor;
  late bool gameover;
  AudioPlayer player = AudioPlayer();
  AudioPlayer successtone = AudioPlayer();
  AudioPlayer marakha = AudioPlayer();
  bool isBannerLoaded = false;
  late BannerAd _bannerAd;
  late InterstitialAd _interstitialAd;

  @override
  void initState() {
    presentMoleIndex = Random().nextInt(9);
    life = 3;
    cancelTimer = false;
    TimerDuration = 1000;
    backgroundColor = Colors.white;
    gameover = false;
    nextPopDelay = 500;
    playAudio();
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-4210461214231566/5305217202',
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isBannerLoaded = true;
          });
        },
      ),
      request: AdRequest(),
    );
    _bannerAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Score: $score",
          style: TextStyle(color: Colors.black),
        ),
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
                  color: index <= life - 1 ? Colors.red : Colors.grey,
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
            SizedBox(
              height: 150,
              child: AdWidget(
                ad: _bannerAd,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30),
                itemBuilder: (_, index) {
                  return InkWell(
                    splashColor: Colors.lightGreenAccent,
                    onTap: () => newPosition(index),
                    child: Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.deepPurple,
                        child: MoleWidget(show: index == presentMoleIndex),
                      ),
                    ),
                  );
                },
                itemCount: 9,
              ),
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
    await Future.delayed(Duration(milliseconds: nextPopDelay));
    if (mounted) {
      setState(() {
        presentMoleIndex = Random().nextInt(9);
      });
    }
    if (TimerDuration > 100) {
      TimerDuration -= 100;
    }
    if (nextPopDelay > 100) {
      nextPopDelay -= 10;
    }
    StartTimer(presentMoleIndex, score);
  }

  StartTimer(int presentMoleIndex, int score) async {
    await Future.delayed(Duration(milliseconds: TimerDuration));
    if (presentMoleIndex == this.presentMoleIndex &&
        score == this.score &&
        !gameover) {
      if (mounted) {
        setState(() {
          decreaseLife();
          this.presentMoleIndex = Random().nextInt(9);
          StartTimer(this.presentMoleIndex, this.score);
        });
      }
    }
  }

  void decreaseLife() async {
    marakha.play();
    life--;
    if (mounted) {
      setState(() {
        backgroundColor = Colors.redAccent;
      });
    }
    if (life < 0) {
      int highScore = 0;
      highScore =
          (await SharedPreferences.getInstance()).getInt("highscore") ?? 0;
      if (score > highScore) {
        (await SharedPreferences.getInstance()).setInt("highscore", score);
      }
      gameover = true;
      var restartGame = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return GameDialog(score: score, highscore: highScore);
          });
      if (restartGame == true) {
        restart();
      } else if (restartGame == false) {
        life = 2;
        gameover = false;
      } else {
        Get.back();
      }
    }
    await Future.delayed(Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        backgroundColor = Colors.white;
      });
    }
    marakha = AudioPlayer();
    await marakha.setAsset('assets/marakha.mp3');
  }

  void increaseScore() async {
    successtone.play();
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
    successtone = AudioPlayer();
    await successtone.setAsset('assets/successtone.mp3');
  }

  void restart() async {
    presentMoleIndex = Random().nextInt(9);
    life = 3;
    cancelTimer = false;
    TimerDuration = 1000;
    backgroundColor = Colors.white;
    gameover = false;
    score = 0;
    setState(() {});
  }

  void playAudio() async {
    await player.setAsset('assets/music.mp3');
    await successtone.setAsset('assets/successtone.mp3');
    await marakha.setAsset('assets/marakha.mp3');
    player.play();
    successtone.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
        successtone.stop();
      }
    });
    marakha.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
        marakha.stop();
      }
    });
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }
}
