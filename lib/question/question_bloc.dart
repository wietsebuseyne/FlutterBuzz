import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_buzz/question/models/question.dart';

import 'models/answer.dart';

/// 1. AskQuestion: show question on screen and afterwards the answers
/// 2. CollectAnswers: accepts answers for the given amount of time
/// 3. ShowAnswer: question has finished, show the correct answer
/// 4. Finished: all questions are asked, trigger next round
///
class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {

  Questions _questions = Questions(List());

  QuestionBloc();

  @override
  QuestionState get initialState => AskQuestion(_questions.questions.first);

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if (event is AnswerEvent) {
      if (state is AskQuestion &&
          !(state as AskQuestion).answers.hasAnswered(event.name)) {
        var newState = AskQuestion.withAnswer(state, event.name, event.answer, event.time);

        //All players have answered
        /*if (newState.answers.nbAnswers == _players.nb) {
          Future.delayed(Duration(seconds: 2), () {
            add(_ShowScoresEvent());
          });
        }*/
        yield newState;
      }
    }

    if (event is NextQuestionEvent) {
//      yield AskQuestion.withAnswer(state, name, answer, time)
    }

    if (event is _ShowScoresEvent) {
    }
  }

}

abstract class QuestionState { }

@immutable
class AskQuestion extends QuestionState {

  final int time;
  final Question question;
  final QuestionMapping mapping;
  final Answers answers;

  AskQuestion(this.question):
      mapping = QuestionMapping.random(),
      time = DateTime.now().millisecondsSinceEpoch,
      answers = Answers.none();

  AskQuestion.withAnswer(AskQuestion a, String name, AnswerColor answer, int time):
      this.question = a.question,
      this.mapping = a.mapping,
      time = a.time,
      this.answers = a.answers.addAnswer(name, answer, time-a.time);

  List<String> get answerTexts => mapping.getAnswers(question);

}

class ShowAnswerState extends QuestionState {}

class ScoreOverview extends QuestionState {}

///**************************************************************************///

abstract class QuestionEvent { }

class AnswerEvent extends QuestionEvent {
  final String name;
  final AnswerColor answer;
  final int time;

  AnswerEvent(this.name, this.answer, {int time}):
    this.time = time ?? DateTime.now().millisecondsSinceEpoch;
}

class NextQuestionEvent extends QuestionEvent {

}

class _ShowScoresEvent extends QuestionEvent {}