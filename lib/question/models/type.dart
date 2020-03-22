import 'package:flutter/foundation.dart';

@immutable
class Type {

  final _code;

  const Type._(this._code);

  static const MULTIPLE = const Type._("multiple");
  static const TRUE_FALSE = const Type._("boolean");

  static List<Type> get values => [MULTIPLE, TRUE_FALSE];

  factory Type.fromString(String input) {
    return values.firstWhere((v) => v._code == input, orElse: () => throw ArgumentError.value(input));
  }

  @override
  String toString() => _code;
}