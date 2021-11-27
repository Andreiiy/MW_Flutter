import 'dart:math';

import 'package:math_world/math_generator/models/question.dart';

import 'base_generator.dart';
import 'class_settings.dart';
import 'test.dart';

class GeneratorForThirdClass extends BaseGenerator {
  @override
  int maxNumberForClass = 100;

  @override
  int maxNumberForInsertQuestion = 100;

  @override
  int differenceAnswers = 20;

  @override
  Test generateTest(ClassSettings classSettings) {
    Test test = new Test();
    test.numberClass = 3;
    try {
      if (classSettings.getListItemsSettings().first.active)
        test.exercises = createExercises(
            classSettings.getListItemsSettings().first.amountQuestions);
    } catch (Exeption) {}
    ////////////////////////////////////////////////////////////////////////////
    try {
      var questionWordNumbers = classSettings.getListItemsSettings().firstWhere(
              (element) => element.typeQuestion == QUESTION_TYPE_WORD_NUMBERS);
      if (questionWordNumbers.active)
        test.listQuestionsWordNumbers =
            createQuestionsWordNumber(questionWordNumbers.amountQuestions);
    } catch (Exeption) {}
    /////////////////////////////////////////////////////////////////////////////////////////
    try {
      var questionWordsAndNumbers = classSettings.getListItemsSettings().firstWhere(
              (element) =>
          element.typeQuestion == QUESTION_TYPE_WORDS_AND_NUMBERS);
      if (questionWordsAndNumbers.active)
        test.listQuestionsWordsAndNumbers = createlistQuestionsWordsAndNumbers(
            questionWordsAndNumbers.amountQuestions);
    } catch (Exeption) {}
    /////////////////////////////////////////////////////////////////////////////////////////
    try {
      var questionInsert = classSettings.getListItemsSettings().firstWhere(
              (element) =>
          element.typeQuestion == QUESTION_TYPE_INSERT_NUMBERS);
      if (questionInsert.active)
        test.listInsertNumbersExercises =
            createlistInsertNumbersExercises(questionInsert.amountQuestions);
    } catch (Exeption) {}
    /////////////////////////////////////////////////////////////////////////////////////////
    try {
      var questionComparison = classSettings.getListItemsSettings().firstWhere(
              (element) =>
          element.typeQuestion == QUESTION_TYPE_COMPARISON_NUMBERS);
      if (questionComparison.active)
        test.listComparisonNumbersExercises = createComparisonNumbersExercises(
            questionComparison.amountQuestions);
    } catch (Exeption) {}
    /////////////////////////////////////////////////////////////////////////////////////////
    try {
      var questionFromMultiplicationTable = classSettings.getListItemsSettings()
          .firstWhere(
              (element) =>
          element.typeQuestion == QUESTION_TYPE_FROM_MULTIPLICATION_TABLE);
      if (questionFromMultiplicationTable.active) {
        differenceAnswers = 5;
        test.listMultiplicationTableExercises = createMultiplicationTableExercises(
            questionFromMultiplicationTable.multiTableSize,
            questionFromMultiplicationTable.amountQuestions);
      }
    } catch (Exeption) {}
/////////////////////////////////////////////////////////////////////////////////////////
    try {
      var questionFraction = classSettings.getListItemsSettings()
          .firstWhere(
              (element) =>
          element.typeQuestion == QUESTION_TYPE_FRACTIONS);
      if (questionFraction.active) {
        test.listExercisesWithFractions = createExercisesWithFractions(questionFraction.amountQuestions);
      }
    } catch (Exeption) {}
    return test;
  }
  List<Question> createExercisesWithFractions(int numberExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != numberExercises) {
      var question = getFractionExercise(1,null);
      question.type = QUESTION_TYPE_FRACTIONS;
      try {
        listExercises
            .firstWhere((element) => element.exerciseOperand1 == question.exerciseOperand1
            && element.exerciseOperand2 == question.exerciseOperand2 && element.operator == question.operator);
      } catch (Exeption) {
        listExercises.add(question);
      }
    }
    return shuffle(listExercises);
  }
  List<Question> shuffle(List<Question> items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }
  List<Question> createMultiplicationTableExercises(int tableSize ,int numberExercises) {
    List<Question> listExercises = [];
    while (listExercises.length != numberExercises) {
      var question = getMultiplicationTableExercise(tableSize);
      question.type = QUESTION_TYPE_FROM_MULTIPLICATION_TABLE;
      try {
        listExercises
            .firstWhere((element) => element.exercise == question.exercise);
      } catch (Exeption) {
        listExercises.add(question);
      }
    }
    return listExercises;
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

  List<Question>? createlistQuestionsWordsAndNumbers(int amountExercises) {
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

    question.exercise = resultThousand > 0
        ? resultThousand.toString()
        : "" +
        (resultThousand > 0 ? resultHundreds.toString() : "") +
        resultTens.toString() +
        resultUnits.toString();

    question.answer = question.exercise;

    createAnswersNotCorrect(question, maxNumber * 2);
    question.saveListAnswers();
    return question;
  }

  Question getQuestionWordNumber(int maxNumber) {
    Question question = new Question();
    question.isWordNumberQuestion = true;

    var now = new DateTime.now();
    Random rnd = new Random(now.millisecondsSinceEpoch);

    var result = rnd.nextInt(100) + 21;
    while (result > 100 || result < 21) {
      result = rnd.nextInt(100) + 21;
    }
    question.exercise = result.toString();
    question.answer = result.toString();

    createAnswersNotCorrect(question, maxNumber);
    question.saveListAnswers();
    return question;
  }
}