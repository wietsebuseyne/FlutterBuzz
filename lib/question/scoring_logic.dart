import 'dart:math';

import 'package:flutter_buzz/player/models/models.dart';
import 'package:flutter_buzz/question/models/answer.dart';

abstract class ScoringLogic {

  Map<String, int> calculateScores(Players players, Answers answers, AnswerColor correctAnswer);

}

class TimedScoring implements ScoringLogic {

  static const scoring = [400, 300, 200, 100, 50];

  @override
  Map<String, int> calculateScores(Players players, Answers answers, AnswerColor correctAnswer) {
    var scores = Map<String, int>();

    List<String> correct = answers.getPlayersWithAnswer(players, correctAnswer);
    for (var i = 0; i < correct.length; i++) {
      scores[correct[i]] = scoring[min(i, scoring.length)];
    }
    players.all.forEach((p) {
      if (scores[p] == null) {
        scores[p] = 0;
      }
    });

    return scores;
  }

}

class UntimedScoring implements ScoringLogic {

  final int score;

  UntimedScoring({this.score = 200});

  @override
  Map<String, int> calculateScores(Players players, Answers answers, AnswerColor correctAnswer) {
    var scores = Map<String, int>();

    players.all.forEach((p) {
      if (answers.answer(p) == correctAnswer) {
        scores[p] = score;
      } else {
        scores[p] = 0;
      }
    });

    return scores;
  }

}