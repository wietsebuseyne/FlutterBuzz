import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_buzz/player/models/models.dart';

class AnswerColor {

  static const AnswerColor BLUE = const AnswerColor._("blue", const Color.fromARGB(255, 95, 115, 245));
  static const AnswerColor ORANGE = const AnswerColor._("orange", const Color.fromARGB(255, 245, 188, 73));
  static const AnswerColor GREEN = const AnswerColor._("green", const Color.fromARGB(255, 71, 225, 61));
  static const AnswerColor YELLOW = const AnswerColor._("yellow", const Color.fromARGB(255, 255, 255, 54));

  static const values = [BLUE, ORANGE, GREEN, YELLOW];

  final Color color;
  final String name;

  const AnswerColor._(this.name, this.color);

  int get index => values.indexOf(this);

  @override
  String toString() => name;

}

@immutable
class Answers {

  final Map<String, int> _ms;
  final Map<String, AnswerColor> _answers; //Kan later eventueel lijst van antwoorden worden

  const Answers.none(): _ms = const {}, _answers = const {};

  Answers.add(Answers answers, String name, AnswerColor answer, int ms):
        _ms = Map.from(answers._ms),
        _answers = Map.from(answers._answers)
  {
    _ms[name] = ms;
    _answers[name] = answer;
  }

  Answers._add(this._ms, this._answers, String name, AnswerColor answer, int ms) {
    _ms[name] = ms;
    _answers[name] = answer;
  }

  /// Returns a list of all the names of players with the provided answer color
  /// The list is sorted by fastest answer time
  List<String> getPlayersWithAnswer(Players players, AnswerColor answerColor) {
    return players.all
        .where((p) => _answers[p] == answerColor)
        .toList()
        ..sort((p1, p2) => _ms[p1] - _ms[p2]);
  }

  int get nb => _answers.length;

  bool hasAnswered(String name) => _answers[name] != null;

  int timeToAnswerMs(String name) => _ms[name];

  AnswerColor answer(String name) => _answers[name];

  Answers addAnswer(String name, AnswerColor answer, int ms) => Answers._add(Map.from(_ms), Map.from(_answers), name, answer, ms);

}