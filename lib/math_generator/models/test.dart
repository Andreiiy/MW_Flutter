


import 'package:flutter/cupertino.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/models/question.dart';

import '../math_generator.dart';

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
  List<Question>? listQuestionsWordsAndNumbers = [];
  List<Question>? listQuestionsWordNumbers = [];
  List<Question>? listInsertNumbersExercises = [];
  List<Question>? listComparisonNumbersExercises = [];
  List<Question>? listMultiplicationTableExercises = [];


  List<Question> getListQuestions(){
    return (exercises ?? []) + (listQuestionsWordNumbers ?? [])
        + (listQuestionsWordsAndNumbers ?? [])
        +  (listInsertNumbersExercises ?? [])
        + (listComparisonNumbersExercises ?? [])
        + (listMultiplicationTableExercises ?? []);
  }


 void transformTestForPdf(BuildContext context){
  listQuestionsWordsAndNumbers?.forEach((question) {
     String result = "";
     if ((question.exercise?.length ?? 0 > 3) == true) {
       result = " ${(int.parse(question.exercise!) / 1000)} " +
           (getTranslated(context, "thousand") ?? "");
     }
     if (question.exercise!.length >= 3) {
       result = result +
           " ${question.exercise![(question.exercise!.length - 3)]} " +
           (getTranslated(context, "hundreds") ?? "");
     }

     result = result +
         " ${question.exercise![(question.exercise!.length - 2)]} " +
         (getTranslated(context, "tens") ?? "");
     result = result +
         " ${question.exercise![(question.exercise!.length - 1)]} " +
         (getTranslated(context, "units") ?? "");
     question.exercise = result;
   });

  listQuestionsWordNumbers?.forEach((question) {
    question.exercise = getTranslated(context, MathGenerator.listStringNumbers[int.parse(question.exercise!)] ?? "");
  });
 }

}
