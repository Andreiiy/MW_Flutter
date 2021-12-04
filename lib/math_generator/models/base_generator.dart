import 'dart:math';

import 'package:math_world/math_generator/models/fraction.dart';

import 'class_settings.dart';
import 'question.dart';
import 'test.dart';

abstract class BaseGenerator {
  abstract int maxNumberForClass;
  abstract int maxNumberForInsertQuestion;
  abstract int differenceAnswers;

  Test generateTest(ClassSettings classSettings);

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

    createAnswersNotCorrect(question, maxNumberForClass * 2);
    question.saveListAnswers();
    return question;
  }

  Question getMultiplicationTableExercise(int tableSize) {
    Question question = new Question();

    var now = new DateTime.now();
    Random rnd = new Random(now.millisecondsSinceEpoch);
    bool exerciseCreated = false;
    while (!exerciseCreated) {
      String functionOperator = "*";

      int operand1 = rnd.nextInt(tableSize) + 1;
      while (operand1 <= 1 && operand1 >= tableSize)
        operand1 = rnd.nextInt(tableSize) + 1;
      int operand2 = rnd.nextInt(10) + 1;
      while (operand1 <= 1 && operand1 >= 10)
        operand1 = rnd.nextInt(tableSize) + 1;

      question.exercise =
          "${operand1.toString()} $functionOperator ${operand2.toString()}";
      int answer;
      answer = multiply(operand1, operand2);

      if (answer >= 1 && answer <= (tableSize * 10)) {
        question.answer = answer.toString();
        exerciseCreated = true;
      }
    }
    createAnswersNotCorrect(question, (tableSize * 10));
    question.saveListAnswers();
    return question;
  }

  createAnswersNotCorrect(Question question, int maxNumberForExercise) {
    var now = new DateTime.now();
    Random rnd = new Random(now.microsecondsSinceEpoch);
    bool answerNotCorrect1Created = false;
    while (!answerNotCorrect1Created) {
      now = new DateTime.now();
      rnd = new Random(now.microsecondsSinceEpoch);
      int result = getRandomPlusMinusOperator() == "+"
          ? add(int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 0)
          : sub(
              int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 0);

      if (result != int.parse(question.answer!) &&
          result >= 0 &&
          result <= maxNumberForExercise) {
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
          : sub(
              int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 1);

      if (result != int.parse(question.answer!) &&
          result >= 0 &&
          result <= maxNumberForExercise &&
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
          : sub(
              int.parse(question.answer!), rnd.nextInt(differenceAnswers) + 1);

      if (result != int.parse(question.answer!) &&
          result >= 0 &&
          result <= maxNumberForExercise &&
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

  addDouble(double operand1, double operand2) {
    return operand1 + operand2;
  }

  sub(int operand1, int operand2) {
    return operand1 - operand2;
  }

  subDouble(double operand1, double operand2) {
    return operand1 - operand2;
  }

  int multiply(int operand1, int operand2) {
    return operand1 * operand2;
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
  getRandomMultyDivOperator() {
    var now = new DateTime.now();
    Random rnd = new Random(now.microsecondsSinceEpoch);
    return [
      "*",
      ":",
      "*",
      ":",
      "*",
      ":",
      "*",
      ":",
      "*",
      ":"
    ][rnd.nextInt(10) + 0];
  }

  List<Question>? createlistInsertNumbersExercises(int amountExercises) {
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
    int tempNumber = 0;
    if (maxNumberForInsertQuestion == 100) {
      while (tempNumber > 5 || tempNumber < 2) {
        tempNumber = rnd.nextInt(5);
      }
      tempNumber = tempNumber * 10 + 1;
    }
    var list = new List<int?>.generate(50, (i) => i + tempNumber);
    Set<String> listAnswers = {};
    while (listAnswers.length != 5) {
      int insertNumber = 0;
      bool numberNotCorrect = true;
      while (numberNotCorrect) {
        insertNumber = rnd.nextInt(maxNumberForInsertQuestion);
        if (insertNumber <= (tempNumber + 50) && insertNumber >= tempNumber) {
          var index = list.indexOf(insertNumber);
          if (index > 0 && index <= 49) {
            if (list[index] != null) numberNotCorrect = false;
          }
        }
      }
      var index = list.indexOf(insertNumber);
      list[index] = null;
      listAnswers.add(insertNumber.toString());
    }
    question.answersInsertNumbersExercises = listAnswers.toList();
    question.insertNumbersExercise = list;
    question.initControllers();
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

  Question getFractionExercise(int maxNumber, String? operator, int questionTypeFractions) {
    Question question = new Question();
    Fraction answer = Fraction(numerator: 1, denominator: 1);
    bool exerciseCreated = false;

    while (!exerciseCreated) {
      String functionOperator = operator ?? (questionTypeFractions == 7 ? getRandomPlusMinusOperator():getRandomMultyDivOperator());

      Fraction operand1 = _createFractionOperand(maxNumber);
      Fraction operand2 = _createFractionSecondOperand(maxNumber,operand1);

      answer = Fraction.reduceFraction(
          Fraction.calculateFractions(functionOperator, operand1, operand2));

      question.exerciseOperand1 = operand1.getFractionString();
      question.exerciseOperand2 = operand2.getFractionString();
      question.operator = functionOperator;

      if (answer.checkOtherFractionGreater(
          Fraction(numerator: maxNumber, denominator: 1))) {
        question.answer = answer.getFractionString();
        exerciseCreated = true;
      }
    }

    createFractionAnswersNotCorrect(question, answer, maxNumber);
    question.saveListAnswers();
    return question;
  }

  Fraction _createFractionOperand(int maxNumber) {
    var now = new DateTime.now();
    Random rnd1 = new Random(now.millisecondsSinceEpoch);
    Random rnd2 = new Random(now.millisecondsSinceEpoch + now.millisecondsSinceEpoch);
    bool fractionCreated = false;
    Fraction operand = Fraction(
      numerator: rnd1.nextInt(15) + 1,
      denominator: rnd2.nextInt(10) + 1,
    );
    while(!fractionCreated){
    if (maxNumber == 1) {
      while (operand.numerator > operand.denominator || operand.numerator == operand.denominator) {
        now = new DateTime.now();
        rnd1 = new Random(now.millisecondsSinceEpoch);
        rnd2 = new Random(now.millisecondsSinceEpoch + now.millisecondsSinceEpoch);
        operand = Fraction(
          numerator: rnd1.nextInt(10) + 1,
          denominator: rnd2.nextInt(10) + 1,
        );
      }
    } else {
        now = new DateTime.now();
        rnd1 = new Random(now.millisecondsSinceEpoch);
        rnd2 = new Random(now.millisecondsSinceEpoch + now.millisecondsSinceEpoch);
        operand = Fraction(
          numerator: rnd1.nextInt(15) + 1,
          denominator: rnd2.nextInt(10) + 1,
        );
    }
    if(operand.getFractionString() == "0")
      fractionCreated = false;
    else
      fractionCreated = true;
    if(operand.numerator == operand.denominator)
      fractionCreated = false;

    }
    return Fraction.reduceFraction(operand);
  }

  Fraction _createFractionSecondOperand(int maxNumber,Fraction firstOperand) {
    var now = new DateTime.now();
    Random rnd1 = new Random(now.millisecondsSinceEpoch);
    Random rnd2 = new Random(now.millisecondsSinceEpoch + now.millisecondsSinceEpoch);
    bool operandCreated = false;
    Fraction secondOperand = Fraction(
      numerator: rnd1.nextInt(10) + 1,
      denominator:firstOperand.denominator + rnd2.nextInt(3) + 1,
    );
    while(!operandCreated) {
      if (maxNumber == 1) {
        while (firstOperand.checkOtherFractionGreater(secondOperand) || !secondOperand.checkOtherFractionGreater(Fraction(numerator: 1,denominator: 1)) || firstOperand.getFractionString() == secondOperand.getFractionString()){
          now = new DateTime.now();
          rnd1 = new Random(now.millisecondsSinceEpoch);
          rnd2 =
          new Random(now.millisecondsSinceEpoch + now.millisecondsSinceEpoch);
          secondOperand = Fraction(
            numerator: rnd1.nextInt(10) + 1,
            denominator:firstOperand.denominator + rnd2.nextInt(3) + 1,
          );
        }
      } else {
          now = new DateTime.now();
          rnd1 = new Random(now.millisecondsSinceEpoch);
          rnd2 =
          new Random(now.millisecondsSinceEpoch + now.millisecondsSinceEpoch);
          secondOperand = Fraction(
            numerator: rnd1.nextInt(10) + 1,
            denominator:firstOperand.denominator + rnd2.nextInt(3) + 1,
          );

      }
      operandCreated = checkSecondFractionOperandIsCreated(firstOperand, secondOperand);
    }
    return Fraction.reduceFraction(secondOperand);
  }
  bool checkSecondFractionOperandIsCreated(Fraction firstOperand, Fraction secondOperand){
    return firstOperand.checkOtherFractionGreater(secondOperand) == false &&
        firstOperand.getFractionString() != secondOperand.getFractionString() &&
        secondOperand.denominator >= firstOperand.denominator &&
        secondOperand.getFractionString() != "0" && secondOperand.numerator != secondOperand.denominator
        && firstOperand.getFractionString() != secondOperand.getFractionString()
    ;
  }
  createFractionAnswersNotCorrect(
      Question question, Fraction answer, int maxNumberForExercise) {
    while (question.answerNotCorrect1 == null ||
        question.answerNotCorrect2 == null ||
        question.answerNotCorrect3 == null) {
      _createAnswerFractionNotCorrect(question, answer, maxNumberForExercise);
    }
  }

  void _createAnswerFractionNotCorrect(
      Question question, Fraction answer, int maxNumberForExercise) {
    var now = new DateTime.now();
    Random rnd = new Random(now.microsecondsSinceEpoch);
    bool answerNotCorrectCreated = false;
    while (!answerNotCorrectCreated) {
      now = new DateTime.now();
      rnd = new Random(now.microsecondsSinceEpoch);
      String operator = getRandomPlusMinusOperator();
      int numerator = 0;
      while (numerator < 1) {
        now = new DateTime.now();
        rnd = new Random(now.microsecondsSinceEpoch);
        operator = getRandomPlusMinusOperator();
        numerator = operator == "+"
            ? (answer.numerator + rnd.nextInt(5) + 1)
            : answer.numerator - rnd.nextInt(5) + 1;
      }
      operator = getRandomPlusMinusOperator();
      int denominator = 0;
      while (denominator < 1) {
        now = new DateTime.now();
        rnd = new Random(now.microsecondsSinceEpoch);
        operator = getRandomPlusMinusOperator();
        denominator = operator == "+"
            ? (answer.denominator + rnd.nextInt(5) + 1)
            : answer.denominator - rnd.nextInt(5) + 1;
      }
      Fraction answerNotCorrect =
          Fraction(numerator: numerator, denominator: denominator);
      if (answerNotCorrect.getFractionString() != answer.getFractionString()) {
        if (question.answerNotCorrect1 == null) {
          question.answerNotCorrect1 = answerNotCorrect.getFractionString();
        } else if (question.answerNotCorrect2 == null &&
            answerNotCorrect.getFractionString() !=
                question.answerNotCorrect1) {
          question.answerNotCorrect2 = answerNotCorrect.getFractionString();
        } else if (question.answerNotCorrect3 == null &&
            answerNotCorrect.getFractionString() !=
                question.answerNotCorrect1 &&
            answerNotCorrect.getFractionString() !=
                question.answerNotCorrect2) {
          question.answerNotCorrect3 = answerNotCorrect.getFractionString();
        }
        answerNotCorrectCreated = true;
      }
    }
  }
}
