import 'dart:math';

import 'package:math_world/math_generator/models/question.dart';
import 'package:math_world/math_generator/models/test.dart';

import 'base_generator.dart';

class GeneratorForFirstClass extends BaseGenerator {

  @override
  int maxNumberForClass = 10;

  @override
  int maxNumberForInsertQuestion = 50;

  @override
  int differenceAnswers = 5;

  @override
  Test generateTest(int amountExercises) {
      Test test = new Test();
      test.numberClass = 1;
      test.exercises = createExercises(amountExercises);
      test.insertNumbersExercises = createInsertNumbersExercises(amountExercises);
      test.comparisonNumbersExercises =
          createComparisonNumbersExercises(amountExercises);
      return test;

  }




}
