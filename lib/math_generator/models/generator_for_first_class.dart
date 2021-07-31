import 'dart:math';

import 'package:math_world/math_generator/models/question.dart';
import 'package:math_world/math_generator/models/test.dart';

class GeneratorForFirstClass {
  int _maxNumber = 10;

  Test generateTest(int amountExercises) {
    Test test = new Test();
    test.numberClass = 1;
    test.exercises = createExercises(amountExercises);
    test.insertNumbersExercises = createInsertNumbersExercises(amountExercises);
    test.comparisonNumbersExercises =
        createComparisonNumbersExercises(amountExercises);
    return test;
  }

  List<Question> createExercises(int numberExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != numberExercises) {
      var question = getExercise(null);
      question.type = 1;
      try {
        listExercises
            .firstWhere((element) => element.exercise == question.exercise);
      } catch (Exeption) {
        listExercises.add(question);
      }
    }
    return listExercises;
  }

  Question getExercise(String? operator) {
    Question question = new Question();

    var now = new DateTime.now();
    Random rnd = new Random(now.millisecondsSinceEpoch);
    bool exerciseCreated = false;
    while (!exerciseCreated) {
      String functionOperator = operator ?? getRandomPlusMinusOperator();

      int operand1 = rnd.nextInt(_maxNumber) + 1;
      int operand2 = rnd.nextInt(operand1) + 1;

      question.exercise =
          "${operand1.toString()} $functionOperator ${operand2.toString()}";
      int answer;
      if (functionOperator == "+")
        answer = add(operand1, operand2);
      else
        answer = sub(operand1, operand2);

      if (answer >= 0 && answer <= 20) {
        question.answer = answer.toString();
        exerciseCreated = true;
      }
    }
    // ignore: unnecessary_null_comparison
    createAnswersNotCorrect(question);
    question.saveListAnswers();
    return question;
  }

  createAnswersNotCorrect(Question question) {
    var now = new DateTime.now();
    Random rnd = new Random(now.microsecondsSinceEpoch);
    bool answerNotCorrect1Created = false;
    while (!answerNotCorrect1Created) {
      now = new DateTime.now();
      rnd = new Random(now.microsecondsSinceEpoch);
      int result = getRandomPlusMinusOperator() == "+"
          ? add(int.parse(question.answer!), rnd.nextInt(5) + 0)
          : sub(int.parse(question.answer!), rnd.nextInt(5) + 0);

      if (result != int.parse(question.answer!) && result >= 0 && result <= 20) {
        question.answerNotCorrect1 = result.toString();
        answerNotCorrect1Created = true;
      }
    }
    bool answerNotCorrect2Created = false;
    while (!answerNotCorrect2Created) {
      now = new DateTime.now();
      rnd = new Random(now.microsecondsSinceEpoch);
      int result = getRandomPlusMinusOperator() == "+"
          ? add(int.parse(question.answer!), rnd.nextInt(5) + 1)
          : sub(int.parse(question.answer!), rnd.nextInt(5) + 1);

      if (result != int.parse(question.answer!) &&
          result >= 0 &&
          result <= 20 &&
          result.toString() != question.answerNotCorrect1) {
        question.answerNotCorrect2 = result.toString();
        answerNotCorrect2Created = true;
      }
    }
    bool answerNotCorrect3Created = false;
    while (!answerNotCorrect3Created) {
      now = new DateTime.now();
      rnd = new Random(now.microsecondsSinceEpoch);
      int result = getRandomPlusMinusOperator() == "+"
          ? add(int.parse(question.answer!), rnd.nextInt(5) + 1)
          : sub(int.parse(question.answer!), rnd.nextInt(5) + 1);

      if (result != int.parse(question.answer!) &&
          result >= 0 &&
          result <= 20 &&
          result.toString() != question.answerNotCorrect1 &&
          result.toString() != question.answerNotCorrect2) {
        question.answerNotCorrect3 = result.toString();
        answerNotCorrect3Created = true;
      }
    }
  }

  add(int operand1, int operand2) {
    return operand1 + operand2;
  }

  sub(int operand1, int operand2) {
    return operand1 - operand2;
  }

  getRandomPlusMinusOperator() {
    var now = new DateTime.now();
    Random rnd = new Random(now.microsecondsSinceEpoch);
    return [
      "+",
      "-",
      "+",
      "-",
      "+",
      "-",
      "+",
      "-",
      "+",
      "-"
    ][rnd.nextInt(10) + 0];
  }

  List<Question>? createInsertNumbersExercises(int amountExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != amountExercises) {
      var question = getInsertNumbersExercise();
      question.type = 2;
      listExercises.add(question);
     }
    return listExercises;
  }

  Question getInsertNumbersExercise() {
    Question question = new Question();
    var now = new DateTime.now();
    Random rnd = new Random(now.microsecondsSinceEpoch);
    question.answersInsertNumbersExercises = [];
    var list = new List<int?>.generate(50, (i) => i + 1);
    Set<String> listAnswers = {};
    while (listAnswers.length != 5) {
      int insertNumber = rnd.nextInt(50);
      list[insertNumber] = null;
      listAnswers.add(insertNumber.toString());
    }
    question.answersInsertNumbersExercises = listAnswers.toList();
    question.insertNumbersExercise = list.cast<String?>();

    return question;
  }

  List<Question>? createComparisonNumbersExercises(int amountExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != amountExercises) {
      var question = getComparisonNumbersExercise();
      question.type = 3;
      try {
        listExercises
            .firstWhere((element) => element.exercise == question.exercise);
      } catch (Exeption) {
        listExercises.add(question);
      }
    }
    return listExercises;
  }

  Question getComparisonNumbersExercise() {
    Question question = new Question();
    List<String> listComparison = ["<", ">", "="];
    var now = new DateTime.now();
    Random rnd = new Random(now.microsecondsSinceEpoch);

    int operand1 = rnd.nextInt(_maxNumber);
    int operand2 = rnd.nextInt(_maxNumber);

    question.exercise = "${operand1.toString()} _ ${operand2.toString()}";

    if (operand1 > operand2)
      question.answer = ">";
    else if (operand1 < operand2)
      question.answer = "<";
    else
      question.answer = "=";
    listComparison.remove(question.answer);
    question.answerNotCorrect1 = listComparison[0];
    question.answerNotCorrect2 = listComparison[1];
    question.saveListAnswers();
    return question;
  }
}
