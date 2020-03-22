import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buzz/Constants.dart';
import 'package:flutter_buzz/scoring/scoring.dart';

class ScoreBox extends StatelessWidget {

  final String player;
  final int score;
  final bool hasAnswered;
  final bool hideAnswerColor;
  final double height;

  ScoreBox(Score score, this.hasAnswered, this.hideAnswerColor, this.height):
        this.player = score.name,
        this.score = score.score;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: <Widget>[
          TotalScoreWidget(height: height, score: score, player: player),
        ],
      ),
    );
  }

}

class TotalScoreWidget extends StatelessWidget {
  const TotalScoreWidget({
    Key key,
    @required this.height,
    @required this.score,
    @required this.player,
  }) : super(key: key);

  final double height;
  final int score;
  final String player;

  @override
  Widget build(BuildContext context) {
    var halfHeight = (height-2) / 2;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: new BoxDecoration (
            borderRadius: new BorderRadius.circular(21.5),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  offset: new Offset(1.0, 1.0))
            ],
            color: const Color.fromARGB(255, 28, 39, 63)
        ),
        width: min(MediaQuery.of(context).size.width*kQuestionWidthPercent/2, 250),
        height: height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: halfHeight,
              child: Center(
                child: AutoSizeText(
                  "$score",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.title.apply(fontSizeFactor: 2.0, fontWeightDelta: 2),
                ),
              )),
            Divider(height: 2,),
            SizedBox(
                height: halfHeight,
                child: Center(
                  child: AutoSizeText(
                    player,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.title.apply(fontSizeFactor: 2.0),
                  ),
                )),

          ],
        )
    );
  }
}