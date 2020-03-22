import 'package:flutter/cupertino.dart';
import 'package:flutter_buzz/Constants.dart';
import 'package:flutter_buzz/question/models/answer.dart';
import 'package:flutter_buzz/scoring/scoring.dart';
import 'package:flutter_buzz/scoring/ui/player_answer_box.dart';
import 'package:flutter_buzz/scoring/ui/score_box.dart';
import 'package:flutter_buzz/ui/VerticalPadding.dart';
import 'package:provider/provider.dart';

class ScoringUI extends StatelessWidget {

  final int startTime;
  final Answers answers;
  final AnswerColor correctAnswer;

  ScoringUI(this.answers, this.startTime, this.correctAnswer);

  @override
  Widget build(BuildContext context) {
    List<Score> scores = Provider.of<Scoring>(context).scores;
    bool allAnswered = answers.nb == scores.length;
    double height = MediaQuery.of(context).size.height*kQuestionHeightPercent;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
        scores.expand((score) {
          String name = score.name;
          return [
            Row(children: <Widget>[
              PlayerAnswerBox(
                height: height,
                width: height,
                correctAnswer: correctAnswer == answers.answer(name),
                questionStartTime: startTime,
                timeToAnswerMs: answers.timeToAnswerMs(name),
                hideAnswerColor: !allAnswered,
                playerAnswer: answers.answer(name),
              ),
              SizedBox(width: 12,),
              ScoreBox(
                  score,
                  answers.hasAnswered(name),
                  !allAnswered,
                  height
              )
            ]),
            VerticalPadding()
          ];
      }).toList()
    );
  }
  
}