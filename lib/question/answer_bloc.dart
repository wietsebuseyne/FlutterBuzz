
import 'package:bloc/bloc.dart';
import 'package:flutter_buzz/player/models/models.dart';
import 'package:flutter_buzz/question/models/answer.dart';
import 'package:flutter_buzz/question/question_bloc.dart';
import 'package:flutter_buzz/question/scoring_logic.dart';

//TODO listen to IdleState and fire next question
class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {

  final Players players;
  AnswerColor _correct;
  Answers _answers; //Move to answering logic (can be different between rounds)
  ScoringLogic _scoringLogic = TimedScoring();
  QuestionBloc questionBloc;

  AnswerBloc(this.players, this.questionBloc);

  @override
  AnswerState get initialState => IdleState();

  @override
  Stream<AnswerState> mapEventToState(AnswerEvent event) async* {

    if (event is NextAnswerEvent) {
      _correct = event.correct;
      _answers = Answers.none();
      yield AnsweringState(_answers);
    }

    if (event is _IdleEvent) {
      yield IdleState();
      questionBloc.add(NextQuestionEvent());
    }

    if (event is _ShowScoresEvent) {
      yield ScoringState(
          _answers,
          _scoringLogic.calculateScores(players, _answers, _correct)
      );
      //After one second, back to idle state
      Future.delayed(new Duration(seconds: 2), () {
        add(_IdleEvent());
      });

    }

    if (event is AnswerColorEvent) {
      _answers = Answers.add(_answers, event.name, event.answer, event.time);

      if (_answers.nb == players.nb) {
        yield AnsweringState(_answers, answeringEnded: true);
        //After two seconds, show the scores
        Future.delayed(new Duration(seconds: 2), () {
          add(_ShowScoresEvent());
        });
      } else {
        yield AnsweringState(_answers);
      }
    }

  }

}

abstract class AnswerEvent {}

class _ShowScoresEvent extends AnswerEvent {}

class _IdleEvent extends AnswerEvent {}

class NextAnswerEvent extends AnswerEvent {

  //TODO this should set the answering logic
  AnswerColor correct;

  NextAnswerEvent(this.correct);

}

class AnswerColorEvent extends AnswerEvent {
  final String name;
  final AnswerColor answer;
  final int time;

  AnswerColorEvent(this.name, this.answer, {int time}):
        this.time = time ?? DateTime.now().millisecondsSinceEpoch;
}

abstract class AnswerState { }

class IdleState extends AnswerState {}

class AnsweringState extends AnswerState {

  Answers answers;
  bool answeringEnded;

  AnsweringState(this.answers, {this.answeringEnded = false});

  int timeToAnswerMs(String name) => answers.timeToAnswerMs(name);

  bool hasAnswered(String name) => answers.hasAnswered(name);

  AnswerColor answerColor(String name) => answers.answer(name);

}

class ScoringState extends AnswerState {

  Answers answers;
  final Map<String, int> _scores;

  ScoringState(this.answers, this._scores);

  int getScore(String name) => _scores[name];

}