


import 'package:math_world/math_generator/models/question.dart';

class Test{

  var listStringsImagesQuestions = [
    'assets/images/questions/1fish.png',
    'assets/images/questions/2fish.png',
    'assets/images/questions/3fish.png',
    'assets/images/questions/4fish.png',
    'assets/images/questions/5fish.png',
    'assets/images/questions/6fish.png',
    'assets/images/questions/7fish.png',
    'assets/images/questions/8fish.png',
    'assets/images/questions/9fish.png',
  ];
  var listStringsImagesAnswers = [
    'assets/images/answers/f0.png',
    'assets/images/answers/f1.png',
    'assets/images/answers/f2.png',
    'assets/images/answers/f3.png',
    'assets/images/answers/f4.png',
    'assets/images/answers/f5.png',
    'assets/images/answers/f6.png',
    'assets/images/answers/f7.png',
    'assets/images/answers/f8.png',
    'assets/images/answers/f9.png',
    'assets/images/answers/f10.png',
  ];



  int? numberClass;
  List<Question>? exercises = [];
  List<Question>? insertNumbersExercises = [];
  List<Question>? comparisonNumbersExercises = [];


  List<Question> getListQuestions(){
    return (exercises ?? []) + (insertNumbersExercises ?? []) + (comparisonNumbersExercises ?? []);
  }
}




