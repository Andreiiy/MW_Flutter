


import 'package:math_world/math_generator/models/question.dart';

class Test{

  List<Question>? exercises = [];
  List<Question>? insertNumbersExercises = [];
  List<Question>? comparisonNumbersExercises = [];


  List<Question> getListQuestions(){
    return (exercises ?? []) + (insertNumbersExercises ?? []) + (comparisonNumbersExercises ?? []);
  }
}

