import 'package:flutter_buzz/question/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  Question q1 = Question(
      type: Type.MULTIPLE,
      category: QuestionCategory.SPORT,
      difficulty: Difficulty.EASY,
      question: "Test?",
      correctAnswer: "answer!"
  );
  Question q1Clone = Question(
      type: Type.MULTIPLE,
      category: QuestionCategory.SPORT,
      difficulty: Difficulty.EASY,
      question: "Test?",
      correctAnswer: "answer!"
  );
  Question q2 = Question(
      type: Type.TRUE_FALSE,
      category: QuestionCategory.SCIENCE_AND_NATURE,
      difficulty: Difficulty.MEDIUM,
      question: "Test 2?",
      correctAnswer: "answer 2!"
  );
  Question q3 = Question(
      type: Type.MULTIPLE,
      category: QuestionCategory.SCIENCE_AND_NATURE,
      difficulty: Difficulty.HARD,
      question: "Test 3?",
      correctAnswer: "answer 3!"
  );

  test('equals', () async {
    expect(q1, equals(q1Clone));
    expect(q1, isNot(equals(q2)));
    expect(q1, isNot(equals(q3)));
  });

  group("enum tests", () {
    test("equality", () {
      expect(Type.MULTIPLE, equals(Type.MULTIPLE));
      expect(QuestionCategory.SCIENCE_AND_NATURE, equals(QuestionCategory.SCIENCE_AND_NATURE));
      expect(Difficulty.MEDIUM, equals(Difficulty.MEDIUM));
    });
    test("non equality", () {
      expect(Type.MULTIPLE, isNot(equals(Type.TRUE_FALSE)));
      expect(QuestionCategory.SPORT, isNot(equals(QuestionCategory.SCIENCE_AND_NATURE)));
      expect(Difficulty.EASY, isNot(equals(Difficulty.MEDIUM)));
    });
    test("fromString", () {
      expect(Type.fromString("multiple"), equals(Type.MULTIPLE));
      expect(QuestionCategory.fromString("Science & Nature"), equals(QuestionCategory.SCIENCE_AND_NATURE));
      expect(Difficulty.fromString("medium"), equals(Difficulty.MEDIUM));
    });
  });

  group("matchesConstraints", () {

    test('matchesConstraints true single value', () async {
      expect(q1.matchesConstraints(difficulty: q1.difficulty), isTrue);
      expect(q1.matchesConstraints(type: q1.type), isTrue);
      expect(q1.matchesConstraints(category: q1.category), isTrue);
    });
    test('matchesConstraints true multiple values', () async {
      expect(q1.matchesConstraints(difficulty: q1.difficulty, type: q1.type, category: q1.category), isTrue);
    });
    test('matchesConstraints false single value', () async {
      expect(q1.matchesConstraints(difficulty: Difficulty.HARD), isFalse);
      expect(q1.matchesConstraints(difficulty: Difficulty.MEDIUM), isFalse);
      expect(q1.matchesConstraints(type: Type.TRUE_FALSE), isFalse);
      expect(q1.matchesConstraints(category: QuestionCategory.SCIENCE_AND_NATURE), isFalse);
    });

  });

}
