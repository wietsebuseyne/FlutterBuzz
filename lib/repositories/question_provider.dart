import 'package:flutter/cupertino.dart';
import 'package:flutter_buzz/question/models/models.dart';

abstract class QuestionProvider {

  /// Return a random question with the specified constraints
  /// If no matching question is available, the constraints can be loosened
  /// When called multiple time, prefers to return a new question rather than the same question twice
  Future<Question> getQuestion({
    Difficulty difficulty,
    Type type,
    QuestionCategory category
  });

  Future<List<Question>> getQuestions({
    @required int amount,
    Difficulty difficulty,
    Type type,
    QuestionCategory category
  });

}