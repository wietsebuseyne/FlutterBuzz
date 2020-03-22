
import 'package:flutter/foundation.dart';

@immutable
class Difficulty {

  final _code;
  const Difficulty._(this._code);

  static const EASY = Difficulty._("easy");
  static const MEDIUM = Difficulty._("medium");
  static const HARD = Difficulty._("hard");

  static List<Difficulty> get values => [EASY, MEDIUM, HARD];

  factory Difficulty.fromString(String input) {
    return values.firstWhere((v) => v._code == input, orElse: () => throw ArgumentError.value(input));
  }


  @override
  String toString() => _code;
}