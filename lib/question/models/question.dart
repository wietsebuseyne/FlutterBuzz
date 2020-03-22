import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_buzz/question/models/models.dart';

@immutable
class Question extends Equatable {

  final Type type;
  final Difficulty difficulty;
  final QuestionCategory category;
  final String question;

  final String correctAnswer;
  final String incorrectAnswer1;
  final String incorrectAnswer2;
  final String incorrectAnswer3;

  const Question({
    @required this.type,
    @required this.difficulty,
    @required this.category,
    @required this.question,
    @required this.correctAnswer,
    this.incorrectAnswer1,
    this.incorrectAnswer2,
    this.incorrectAnswer3
  });

  Question.fromList(List<dynamic> l):
      this.type = Type.fromString(l[0]),
      this.difficulty = Difficulty.fromString(l[1]),
      this.category = QuestionCategory.fromString(l[2]),
      this.question = l[3],
      this.correctAnswer = l[4],
      this.incorrectAnswer1 = l[5],
      this.incorrectAnswer2 = l[6],
      this.incorrectAnswer3 = l[7];

  @override
  List<Object> get props => [
    type,
    difficulty,
    category,
    question,
    correctAnswer,
    incorrectAnswer1,
    incorrectAnswer2,
    incorrectAnswer3
  ];

  String getAnswer(int index) {
    switch(index) {
      case 0: return correctAnswer;
      case 1: return incorrectAnswer1;
      case 2: return incorrectAnswer2;
      case 3: return incorrectAnswer3;
    }
    throw "IOOB $index";
  }

  bool matchesConstraints({
    Difficulty difficulty,
    Type type,
    QuestionCategory category
  }) {
    return (difficulty == null || difficulty == this.difficulty) &&
        (type == null || type == this.type) &&
        (category == null || category == this.category);
  }

  @override
  String toString() => "$question == $correctAnswer";

}

@immutable
class QuestionMapping {

  final List<int> _indices = List.generate(4, (i) => i, growable: false);

  QuestionMapping.random() {
    var random = new Random();
    for (var i = _indices.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = _indices[i];
      _indices[i] = _indices[n];
      _indices[n] = temp;
    }
  }

  List<String> getAnswers(Question question) {
    return [
      question.getAnswer(_indices[0]),
      question.getAnswer(_indices[1]),
      question.getAnswer(_indices[2]),
      question.getAnswer(_indices[3]),
    ];
  }

  AnswerColor get correctAnswerColor => AnswerColor.values[_indices.indexOf(0)];

}

class Questions {

  int _current = 0;
  final List<Question> questions;

  get currentQuestion => questions[_current];
  get nextQuestion => questions[++_current];
  get hasFinished => _current == questions.length-1;

  Questions(List<Question> questions):
        assert(questions != null && questions.isNotEmpty),
      this.questions = List.unmodifiable(questions) { }

}