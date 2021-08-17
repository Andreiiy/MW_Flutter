
import 'dart:math';

import 'package:math_world/math_generator/models/question.dart';
import 'package:math_world/math_generator/models/test.dart';

import 'base_generator.dart';

class GeneratorForSecondClass extends BaseGenerator {
  @override
  int maxNumberForClass = 100;

  @override
  int maxNumberForInsertQuestion = 100;

  @override
  int differenceAnswers = 20;

  @override
  Test generateTest(int amountExercises) {
    Test test = new Test();
    test.numberClass = 2;
    test.exercises = createExercises(amountExercises);
    test.questionsWordNumbers = createQuestionsWordNumber(amountExercises);
    test.questionsWordsAndNumbers = createQuestionsWordsAndNumbers(amountExercises);
    test.insertNumbersExercises = createInsertNumbersExercises(amountExercises);
    test.comparisonNumbersExercises =
        createComparisonNumbersExercises(amountExercises);
    return test;
  }
  List<Question>? createQuestionsWordNumber(int amountExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != amountExercises) {
      var question = getQuestionWordNumber(100);
      question.type = TYPE_WORD_NUMBER;
      try {
        listExercises
            .firstWhere((element) => element.exercise == question.exercise);
      } catch (Exeption) {
        listExercises.add(question);
      }
    }
    return listExercises;
  }
  List<Question>? createQuestionsWordsAndNumbers(int amountExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != amountExercises) {
      var question = getQuestionWordsAndNumbers(100);
      question.type = TYPE_WORD_AND_NUMBER;
      try {
        listExercises
            .firstWhere((element) => element.exercise == question.exercise);
      } catch (Exeption) {
        listExercises.add(question);
      }
    }
    return listExercises;
  }
  Question getQuestionWordsAndNumbers(int maxNumber) {
    Question question = new Question();
    question.isWordsAndNumbersQuestion = true;


    var now = new DateTime.now();
    Random rnd = new Random(now.millisecondsSinceEpoch);

    int resultUnits = 0;
    int resultTens = 0;
    int? resultHundreds = 0;
    int? resultThousand = 0;

    resultUnits = rnd.nextInt(9) + 1;
    resultTens = rnd.nextInt(9) + 1;

    if (maxNumber >= 1000) resultHundreds = rnd.nextInt(9) + 1;
    if (maxNumber == 10000) resultThousand = rnd.nextInt(9) + 0;
    if (maxNumber == 100000) resultThousand = rnd.nextInt(99) + 1;

    question.exercise = resultThousand > 0? resultThousand.toString():"" + (resultThousand > 0? resultHundreds.toString():"") + resultTens.toString() + resultUnits.toString();

    question.answer = question.exercise;

    createAnswersNotCorrect(question,maxNumber*2);
    question.saveListAnswers();
    return question;
  }

  Question getQuestionWordNumber(int maxNumber) {
    Question question = new Question();
    question.isWordNumberQuestion = true;


    var now = new DateTime.now();
    Random rnd = new Random(now.millisecondsSinceEpoch);

   var  result = rnd.nextInt(100) + 21;

    question.exercise = result.toString();
    question.answer = result.toString();

    createAnswersNotCorrect(question,maxNumber);
    question.saveListAnswers();
    return question;
  }



}
