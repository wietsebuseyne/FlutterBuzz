import 'package:flutter/cupertino.dart';
import 'package:flutter_buzz/player/models/models.dart';

@immutable
class Score {

  final String name;
  final int score;

  Score(this.name, this.score);
}

@immutable
class Scoring {

  final Players players;
  final Map<String, int> _scores;

  Scoring.start(this.players): _scores = {} {
    players.all.forEach((name) =>_scores[name] = 0);
  }

  Scoring._(this.players, this._scores);

  List<Score> get scores => players.all.map(score).toList();

  Score score(String name) {
    if (_scores[name] == null) {
      throw "'$name' is not a valid player";
    }
    return Score(name, _scores[name]);
  }

  Scoring addScores(Map<String, int> addScores) {
    Map<String, int> newScores = {};
    addScores.forEach((key, value) => newScores[key] = _scores[key] + addScores[key]);
    return Scoring._(players, newScores);
  }

}