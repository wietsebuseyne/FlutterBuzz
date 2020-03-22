import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_buzz/question/models/models.dart';
import 'package:flutter_buzz/repositories/question_provider.dart';

///Split into ListQuestionProvider && Csv
class CsvQuestionProvider implements QuestionProvider {

  final String file;
  List<Question> _questions;
  Set<Question> _picked = Set();
  Future<void> _initFuture;

  CsvQuestionProvider(this.file): assert(file != null) {
    _initFuture = _init();
  }

  CsvQuestionProvider.withInput(String csv): file = null, assert(csv != null) {
    _questions = CsvToListConverter(csvSettingsDetector: FirstOccurrenceSettingsDetector())
        .convert(csv)
        .map((q) => Question.fromList(q))
        .toList()
        ..shuffle();
  }

  _init() async {
    _questions = CsvToListConverter(csvSettingsDetector: FirstOccurrenceSettingsDetector())
        .convert(await rootBundle.loadString(file))
        .map((q) => Question.fromList(q))
        .toList()
        ..shuffle();
  }

  @override
  Future<Question> getQuestion({Difficulty difficulty, Type type, QuestionCategory category}) async {
    await _initFuture;
    var qs = _questions
        .where((q) => q.matchesConstraints(difficulty: difficulty, type: type, category: category));
    //Fallback on first item if non
    var q = qs
        .firstWhere((q) => !_picked.contains(q), orElse: () => qs.first);
    _picked.add(q);
    return q;
  }

  @override
  Future<List<Question>> getQuestions({int amount = 10, Difficulty difficulty, Type type, QuestionCategory category}) async {
    assert(amount != null && amount > 0);
    assert(amount < _questions.length);
    await _initFuture;
    var qs = _questions
        .where((q) => !_picked.contains(q) && q.matchesConstraints(difficulty: difficulty, type: type, category: category))
        .take(amount)
        .toList();
    _picked.addAll(qs);
    return qs;
  }

}