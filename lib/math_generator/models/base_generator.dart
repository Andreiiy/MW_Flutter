

import 'dart:math';

import 'question.dart';
import 'test.dart';

abstract class BaseGenerator{

  abstract  int maxNumberForClass;
  abstract int maxNumberForInsertQuestion;
  abstract int differenceAnswers;

  Test generateTest(int amountExercises);

  List<Question> createExercises(int numberExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != numberExercises) {
      var question = getExercise(null);
      question.type = TYPE_EXERCISE;
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

      int operand1 = rnd.nextInt(maxNumberForClass) + 1;
      int operand2 = rnd.nextInt(operand1) + 1;

      question.exercise =
      "${operand1.toString()} $functionOperator ${operand2.toString()}";
      int answer;
      if (functionOperator == "+")
        answer = add(operand1, operand2);
      else
        answer = sub(operand1, operand2);

      if (answer >= 0 && answer <= maxNumberForClass) {
        question.answer = answer.toString();
        exerciseCreated = true;
      }
    }

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
          ? add(int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 0)
          : sub(int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 0);

      if (result != int.parse(question.answer!) && result >= 0 && result <= (maxNumberForClass * 2)) {
        question.answerNotCorrect1 = result.toString();
        answerNotCorrect1Created = true;
      }
    }
    bool answerNotCorrect2Created = false;
    while (!answerNotCorrect2Created) {
      now = new DateTime.now();
      rnd = new Random(now.microsecondsSinceEpoch);
      int result = getRandomPlusMinusOperator() == "+"
          ? add(int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 1)
          : sub(int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 1);

      if (result != int.parse(question.answer!) &&
          result >= 0 &&
          result <= maxNumberForClass &&
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
          ? add(int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 1)
          : sub(int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 1);

      if (result != int.parse(question.answer!) &&
          result >= 0 &&
          result <= maxNumberForClass &&
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
      question.type = TYPE_INSERT_NUMBERS;
      listExercises.add(question);
    }
    return listExercises;
  }

  Question getInsertNumbersExercise() {
    Question question = new Question();
    var now = new DateTime.now();
    Random rnd = new Random(now.microsecondsSinceEpoch);
    question.answersInsertNumbersExercises = [];
    int tempNumber = 0 ;
    if(maxNumberForInsertQuestion == 100){
      tempNumber = (rnd.nextInt(5) + 2) * 10;
    }
    var list = new List<int?>.generate(maxNumberForInsertQuestion, (i) => i + tempNumber + 1);
    Set<String> listAnswers = {};
    while (listAnswers.length != 5) {
      int insertNumber = rnd.nextInt(50);
      list[insertNumber] = null;
      listAnswers.add(insertNumber.toString());
    }
    question.answersInsertNumbersExercises = listAnswers.toList();
    question.insertNumbersExercise = list;

    return question;
  }

  List<Question>? createComparisonNumbersExercises(int amountExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != amountExercises) {
      var question = getComparisonNumbersExercise();
      question.type = TYPE_COMPARISON_NUMBERS;
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

    int operand1 = rnd.nextInt(maxNumberForClass);
    int operand2 = rnd.nextInt(maxNumberForClass);

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