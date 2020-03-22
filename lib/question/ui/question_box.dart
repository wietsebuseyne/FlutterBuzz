import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buzz/Constants.dart';

class QuestionBox extends StatelessWidget {

  final String question;

  QuestionBox(this.question);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: min(MediaQuery.of(context).size.height*kQuestionBoxHeightPercent, kQuestionBoxHeightMax),
        alignment: AlignmentDirectional.centerStart,
        decoration: new BoxDecoration (
            borderRadius: new BorderRadius.circular(21.5),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  offset: new Offset(1.0, 1.0))
            ],
            color: const Color.fromARGB(255, 28, 39, 63)
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 21.5, left: 21.5, top: 21.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    question,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.title.apply(fontSizeFactor: 2.5),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                height: 6.5,
                child: LinearProgressIndicator(value: 0.7),
              )
            ],
          ),
        ));
  }

}