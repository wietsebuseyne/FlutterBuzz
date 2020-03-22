import 'package:flutter_buzz/question/models/models.dart';
import 'package:flutter_buzz/repositories/csv_question_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  String inputCsv;
  Question q1, q2, q3;
  CsvQuestionProvider questionProvider;

  setUp(() {
    var q1Csv = 'multiple,easy,Science & Nature,Tot welke soort behoort de dolfijn?,Zoogdieren,Vissen,Amfibieën,Insecten';
    var q2Csv = 'multiple,hard,Science & Nature,Which is the chemical name of H2O?,Dihydrogen Monoxide,Ammonium chloride,Anhydrous Sodium Carbonate,Manganese dioxide';
    var q3Csv = 'multiple,easy,Science & Nature,How many planets are in our Solar System?,Eight,Seven,Nine,Ten';
    inputCsv = "$q1Csv\r\n$q2Csv\r\n$q3Csv";

    q1 = Question.fromList(q1Csv.split(","));
    q2 = Question.fromList(q2Csv.split(","));
    q3 = Question.fromList(q3Csv.split(","));

    questionProvider = CsvQuestionProvider.withInput(
      inputCsv
    );
  });

  group("getQuestion", () {
    test('getQuestion returns a random question from the CSV', () async {
      var r1 = await questionProvider.getQuestion();
      var r2 = await questionProvider.getQuestion();
      var r3 = await questionProvider.getQuestion();
      expect(r1, isNotNull);
      expect(r2, isNotNull);
      expect(r3, isNotNull);
      expect(r1, anyOf(equals(q1), equals(q2), equals(q3)));
      expect(r2, anyOf(equals(q1), equals(q2), equals(q3)));
      expect(r3, anyOf(equals(q1), equals(q2), equals(q3)));
    });
    test('getQuestion with difficulty respects constraints', () async {
      var r = await questionProvider.getQuestion(difficulty: Difficulty.HARD);
      expect(r, equals(q2));
    });

  });

}
