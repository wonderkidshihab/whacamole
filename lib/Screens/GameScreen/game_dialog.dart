import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
        height: 500,
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
              onPressed: () async {
                await RewardedAd.load(
                  adUnitId: 'ca-app-pub-4210461214231566/8338574654',
                  request: AdRequest(),
                  rewardedAdLoadCallback:
                      RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) async {
                    await ad.show(
                      onUserEarnedReward:
                          (AdWithoutView ad, RewardItem reward) {
                        Get.back(result: false);
                      },
                    );
                    // Keep a reference to the ad so you can show it later.
                  }, onAdFailedToLoad: (LoadAdError error) {
                    print('RewardedAd failed to load: $error');
                  }),
                );
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
                    "Get two more ",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white, fontFamily: "Roboto"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                await InterstitialAd.load(
                    adUnitId: 'ca-app-pub-4210461214231566/4131473001',
                    request: AdRequest(),
                    adLoadCallback: InterstitialAdLoadCallback(
                      onAdLoaded: (InterstitialAd ad) async {
                        // Keep a reference to the ad so you can show it later.
                        await ad.show();
                        Get.back(result: true);
                      },
                      onAdFailedToLoad: (LoadAdError error) {
                        print('InterstitialAd failed to load: $error');
                      },
                    ));
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
                    "Restart",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white, fontFamily: "Roboto"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 20,
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
