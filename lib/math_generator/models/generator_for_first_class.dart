import 'dart:math';

import 'package:math_world/math_generator/models/question.dart';
import 'package:math_world/math_generator/models/test.dart';

import 'base_generator.dart';
import 'class_settings.dart';

class GeneratorForFirstClass extends BaseGenerator {

  @override
  int maxNumberForClass = 10;

  @override
  int maxNumberForInsertQuestion = 50;

  @override
  int differenceAnswers = 5;

  @override
  Test generateTest(ClassSettings classSettings) {
      Test test = new Test();
      test.numberClass = classSettings.classNumber;
      try {
        if (classSettings.listItemsSettings.first.active)
          test.exercises = createExercises(
              classSettings.listItemsSettings.first.amountQuestions);
      }catch(Exeption){}
      /////////////////////////////////////////////////////////////////////////////////////////
      try {
        ItemSettings questionInsert = classSettings.listItemsSettings.firstWhere((element) => element.typeQuestion == QUESTION_TYPE_INSERT_NUMBERS);
      if(questionInsert.active == true)
      test.insertNumbersExercises = createInsertNumbersExercises(questionInsert.amountQuestions);
      }catch(Exeption){
        var e = Exeption.toString();
      }
      /////////////////////////////////////////////////////////////////////////////////////////
      try {
        ItemSettings questionComparison = classSettings.listItemsSettings.firstWhere((element) => element.typeQuestion == QUESTION_TYPE_COMPARISON_NUMBERS);
      if(questionComparison.active)
      test.comparisonNumbersExercises =
          createComparisonNumbersExercises(questionComparison.amountQuestions);
      }catch(Exeption){}
      return test;

  }




}
