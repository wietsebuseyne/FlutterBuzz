import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_buzz/player/models/models.dart';
import 'package:flutter_buzz/question/answer_bloc.dart';
import 'package:flutter_buzz/question/question_bloc.dart';
import 'package:flutter_buzz/question/ui/question_page.dart';
import 'package:flutter_buzz/scoring/scoring.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//      Image.asset("images/question.png", fit: BoxFit.fill,);
    Players players = Players.empty().add("Speler 1").add("Speler 2").add("LANGE PIET").add("Dikke Tieten");
    QuestionBloc questionBloc = QuestionBloc();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark
      ),
      home: MultiProvider(
        providers: [
          Provider<Players>.value(value: players),
          Provider<Scoring>(create: (BuildContext context) => Scoring.start(players))
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<QuestionBloc>(create: (BuildContext context) => questionBloc,),
            BlocProvider<AnswerBloc>(create: (BuildContext context) => AnswerBloc(players, questionBloc),),
          ],
          child: QuestionPage()
        ),
      ),
    );
  }
}