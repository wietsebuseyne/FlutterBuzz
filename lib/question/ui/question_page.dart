import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_buzz/Constants.dart';
import 'package:flutter_buzz/question/question_bloc.dart';
import 'package:flutter_buzz/question/ui/question_box.dart';
import 'package:flutter_buzz/scoring/ui/scoring_ui.dart';
import 'package:flutter_buzz/ui/VerticalPadding.dart';

import '../models/answer.dart';
import 'answer_box.dart';

class QuestionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: buildBackground()),
        buildUI(),
      ],
    );
  }

  Widget buildUI() {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (BuildContext context, QuestionState state) {
        if (state is AskQuestion) {
          return buildQuestionUI(context, state);
        }
        return Text("TODO unimplemented state");
      },
    );
  }

  double getPadding(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    if (size < 500) return 16.0;
    if (size < 1024) return 24.0;
    return 48.0;
  }

  Widget buildQuestionUI(BuildContext context, AskQuestion state) {
    var answers = state.answerTexts;
    return Container(
        padding: EdgeInsets.all(getPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: QuestionBox(state.question.question),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedAnswerBox(AnswerColor.BLUE, answers[0]),
                    VerticalPadding(),
                    SizedAnswerBox(AnswerColor.ORANGE, answers[1]),
                    VerticalPadding(),
                    SizedAnswerBox(AnswerColor.GREEN, answers[2]),
                    VerticalPadding(),
                    SizedAnswerBox(AnswerColor.YELLOW, answers[3]),
                  ],
                ),
                ScoringUI(
                    state.answers,
                    state.time,
                    state.mapping.correctAnswerColor
                )
              ],
            ),
          ],
        )
    );
  }

  buildBackground() {
    return Container(color: Colors.blue,);
  }

}

class SizedAnswerBox extends StatelessWidget {

  final AnswerColor _answer;
  final String _answerText;

  const SizedAnswerBox(this._answer, this._answerText, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height*kQuestionHeightPercent,
        width: min(450, MediaQuery.of(context).size.width*kQuestionWidthPercent),
        child: AnswerBox(_answer, _answerText)
    );
  }

}