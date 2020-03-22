import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_buzz/player/models/models.dart';
import 'package:flutter_buzz/question/models/answer.dart';
import 'package:flutter_buzz/ui/ColorBorderedContainer.dart';
import 'package:provider/provider.dart';

import '../answer_bloc.dart';

class AnswerBox extends StatelessWidget {

  final AnswerColor button;
  final String answerText;

  const AnswerBox(this.button, this.answerText);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int time = DateTime.now().millisecondsSinceEpoch;
        String name = Provider.of<Players>(context).get(button.index);
//        BlocProvider.of<QuestionBloc>(context).add(AnswerEvent(name, button, time: time));
        BlocProvider.of<AnswerBloc>(context).add(AnswerColorEvent(name, button, time: time));
      },
      child: Container(
        decoration: new BoxDecoration (
            border: Border.all(color: Colors.black, width: 3.0),
//              border: RoundedRectangleBorder(side: BorderSide.none, borderRadius: 20),
            borderRadius: new BorderRadius.circular(21.5),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  offset: new Offset(1.0, 1.0))
            ],
            color: Colors.black
        ),
        child: ColorBorderedContainer(
          color: button.color,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(answerText, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline.apply(fontSizeDelta: 15.0)),
            ),
          ),
        ),
      ),
    );
  }
}