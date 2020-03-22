import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buzz/question/models/answer.dart';
import 'package:flutter_buzz/ui/ColorBorderedContainer.dart';

class PlayerAnswerBox extends StatelessWidget {

  final int questionStartTime;
  final int timeToAnswerMs;
  final AnswerColor playerAnswer;
  final bool correctAnswer;
  final bool hideAnswerColor;
  final double height;
  final double width;

  const PlayerAnswerBox({
    Key key,
    @required this.questionStartTime,
    @required this.playerAnswer,
    @required this.hideAnswerColor,
    @required this.correctAnswer,
    @required this.timeToAnswerMs,
    this.height,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorBorderedContainer(
      height: height,
      width: width,
      color: hideAnswerColor ? Colors.grey : playerAnswer.color,
      child: Center(
        child: createChild(context),
      )
    );
  }

  Widget createChild(BuildContext context) {
    if (playerAnswer != null) {
      if (hideAnswerColor) {
        return AutoSizeText(
            (timeToAnswerMs / 1000).toStringAsFixed(3),
          style: Theme.of(context).textTheme.title.apply(fontSizeFactor: 1.2),
          textAlign: TextAlign.center,
        );
      }
      if (correctAnswer) {
        return Icon(
            Icons.check,
            color: Colors.green,
            size: min(height, width) / 2,
        );
      } else {
        return Icon(
            Icons.clear,
            color: Colors.red,
            size: min(height, width) / 2,
        );
      }
    }
    return TimeShower(startTime: questionStartTime,);
  }

}

class TimeShower extends StatefulWidget {

  final int startTime;

  TimeShower({Key key, @required this.startTime}) : super(key: key);

  @override
  _TimeShowerState createState() => _TimeShowerState();

}

class _TimeShowerState extends State<TimeShower> {

  Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      ((DateTime.now().millisecondsSinceEpoch - widget.startTime ?? 0) / 1000).toStringAsFixed(3),
        style: Theme.of(context).textTheme.title.apply(fontSizeFactor: 1.2),
        textAlign: TextAlign.center,
    );
  }

  void startTimer() {
    _timer = new Timer.periodic(
      const Duration(milliseconds: 16),
          (Timer timer) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}