import 'package:flutter/foundation.dart';

@immutable
class QuestionCategory {

  final _name;

  const QuestionCategory._(this._name);

  static const SCIENCE_AND_NATURE = const QuestionCategory._("Science & Nature");
  static const SPORT = const QuestionCategory._("Sport");

  static List<QuestionCategory> get values => [SCIENCE_AND_NATURE, SPORT];

  factory QuestionCategory.fromString(String input) {
    return values.firstWhere((v) => v._name == input, orElse: () => throw ArgumentError.value(input));
  }

  @override
  String toString() => _name;

}